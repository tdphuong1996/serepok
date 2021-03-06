import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:serepok/model/address_model.dart';
import 'package:serepok/model/order_model.dart';
import 'package:serepok/model/product_model.dart';
import 'package:serepok/ui/sale/createorder/order_provider.dart';

import '../../../res/AppThemes.dart';
import '../../../res/AppThemes.dart';
import '../../../res/AppThemes.dart';
import '../../../res/AppThemes.dart';
import '../../../res/constant.dart';
import '../../../routes.dart';

enum Status { CONFIRM, CANCEL }

class CreateOrderScreen extends StatefulWidget {
  final OrderModel? _orderModel;

  const CreateOrderScreen(this._orderModel, {Key? key}) : super(key: key);

  @override
  State<CreateOrderScreen> createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends State<CreateOrderScreen> {
  late OrderProvider _orderProvider;
  late ScrollController _controller;
  final TextEditingController _editingFullNameController =
      TextEditingController();
  final TextEditingController _editingPhoneNumberController =
      TextEditingController();
  final TextEditingController _editingAddressController =
      TextEditingController();
  final TextEditingController _editingProductNameController =
      TextEditingController();
  final TextEditingController _editingStatusController =
      TextEditingController();
  final TextEditingController _editingProductTypeController =
      TextEditingController();
  final TextEditingController _editingProductUnitController =
      TextEditingController();
  final TextEditingController _editingProductAmountController =
      TextEditingController();
  final TextEditingController _editingProductBoxController =
      TextEditingController();
  final TextEditingController _editingProductPriceController =
      TextEditingController();
  final TextEditingController _editingProductTotalMoneyController =
      TextEditingController();
  final TextEditingController _editingNoteController = TextEditingController();
  final TextEditingController _editingTamUngController =
      TextEditingController();
  final TextEditingController _editingThuHoController = TextEditingController();
  final _editingProvinceController = TextEditingController();
  TypeAction _typeAction = TypeAction.ADD;
  TypePay _typePay = TypePay.PAID;
  bool _isEditCOD = false;
  int _productId = 0;
  int _orderId = 0;
  int _selectedProdvince = 0;
  Status? _status;

  @override
  void initState() {
    super.initState();
    try {
      _orderProvider = Provider.of<OrderProvider>(context, listen: false);
      _orderProvider.context = context;
      _orderProvider.createOrderSuccessCallback = () async {
        _orderProvider.isRefresh = true;
        _orderProvider.pageNumber = 1;
        await _orderProvider.getListOrderPending();
        _orderProvider.isRefresh = true;
        _orderProvider.pageNumber = 1;
        await _orderProvider.getListOrderApproved();
        resetData();
      };
      _orderProvider.updateOrderSuccessCallback = () {
        Navigator.pop(context, "update_order_success");
      };
      if (widget._orderModel?.id != 0) {
        _typeAction = TypeAction.EDIT;
        _orderId = widget._orderModel!.id;
      } else {
        _typeAction = TypeAction.ADD;
      }
      if (_typeAction == TypeAction.EDIT) {
        setDefaultData();
      }
      _orderProvider.getListProvince();
      _controller = ScrollController();
    } on Exception catch (error) {
      debugPrint('loi neeeeeee: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _typeAction == TypeAction.EDIT
          ? AppBar(
              centerTitle: true,
              title: const Text('C???t nh???t ????n h??ng'),
            )
          : null,
      body: GestureDetector(
        onPanDown: (pd) {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: _typeAction == TypeAction.ADD
                        ? viewCreate()
                        : viewUpdate(),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CupertinoButton(
                        color: MyColor.PRIMARY_COLOR,
                        onPressed: () {
                          createOrder();
                        },
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        padding: const EdgeInsets.only(
                            top: 8, left: 32, right: 32, bottom: 8),
                        pressedOpacity: 0.5,
                        child: Text(_typeAction == TypeAction.ADD
                            ? 'Ho??n th??nh'
                            : 'C???p nh???t')),
                  ),
                )
              ],
            )),
      ),
    );
  }

  Widget viewUpdate() {
    return Column(
      children: [
        height(),
        textField("T??n kh??ch h??ng", _editingFullNameController),
        height(),
        textField("S??? ??i???n tho???i", _editingPhoneNumberController),
        height(),
        textField("?????a ch???", _editingAddressController),
        height(),
        textAddressFieldTap("T???nh/ Th??nh ph???"),
        height(),
        textFieldTap("T??n h??ng", true),
        height(),
        viewChungLoaiDVT(),
        height(),
        viewSoLuongDonGia(),
        height(),
        textFieldTap("Tr???ng th??i ????n h??ng", false),
        height(),
        viewSoThungTongTien(),
        height(),
        header(),
        height(),
        paymentView(),
        textField("Ghi ch??", _editingNoteController),
        height(),
      ],
    );
  }

  Widget viewCreate() {
    return Column(
      children: [
        height(),
        textField("T??n kh??ch h??ng", _editingFullNameController),
        height(),
        textField("S??? ??i???n tho???i", _editingPhoneNumberController),
        height(),
        textField("?????a ch???", _editingAddressController),
        height(),
        textAddressFieldTap("T???nh/ Th??nh ph???"),
        height(),
        textFieldTap("T??n h??ng", true),
        height(),
        viewChungLoaiDVT(),
        height(),
        viewSoLuongDonGia(),
        height(),
        viewSoThungTongTien(),
        height(),
        header(),
        height(),
        paymentView(),
        textField("Ghi ch??", _editingNoteController),
        height(),
      ],
    );
  }

  Future<void> chooseProduct() async {
    final result = await Navigator.of(context).pushNamed(Routes.CHOOSE_PRODUCT);
    if (result != null) {
      final product = result as ProductModel;
      _editingProductNameController.text = product.name!;
      _editingProductTypeController.text = product.species!;
      _editingProductUnitController.text = product.unit!;
      _editingProductPriceController.text = product.price.toString();
      _productId = product.id;
      if (_editingProductAmountController.text.isNotEmpty) {
        _editingProductTotalMoneyController.text =
            (int.parse(_editingProductAmountController.text) *
                    int.parse(_editingProductPriceController.text))
                .toString();
      }
    }
  }

  Widget header() {
    return Row(
      children: const [
        Text(
          "Thanh to??n",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  Widget height() {
    return const SizedBox(
      height: 16,
    );
  }

  Widget viewChungLoaiDVT() {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: textField("Ch???ng lo???i", _editingProductTypeController,
                isNotEdit: true)),
        const SizedBox(
          width: 16,
        ),
        Expanded(
            flex: 1,
            child: textField("????n v??? t??nh", _editingProductUnitController,
                isNotEdit: true))
      ],
    );
  }

  Widget viewSoLuongDonGia() {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: textField("S??? l?????ng", _editingProductAmountController,
                isCalculate: true, isNumber: true)),
        const SizedBox(
          width: 16,
        ),
        Expanded(
            flex: 1,
            child: textField("????n gi??", _editingProductPriceController,
                isNotEdit: true))
      ],
    );
  }

  Widget viewSoThungTongTien() {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: textField("S??? th??ng", _editingProductBoxController,
                isCalculate: true, isNumber: true)),
        const SizedBox(
          width: 16,
        ),
        Expanded(
            flex: 1,
            child: textField("T???ng ti???n", _editingProductTotalMoneyController,
                isNotEdit: true))
      ],
    );
  }

  Widget textField(String label, TextEditingController controller,
      {bool isNotEdit = false, bool isCalculate = false, isNumber = false}) {
    return TextFormField(
      readOnly: isNotEdit,
      decoration: InputDecoration(labelText: label),
      controller: controller,
      keyboardType:
          isNumber == true ? TextInputType.number : TextInputType.text,
      onChanged: (text) => {
        isCalculate == true
            ? _editingProductTotalMoneyController.text =
                (int.parse(_editingProductAmountController.text) *
                        int.parse(_editingProductPriceController.text))
                    .toString()
            : {}
      },
    );
  }

  void pickStatus() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Center(
                      child: Text(
                        "Ch???n tr???ng th??i c???p nh???t",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      height: 1,
                      width: double.infinity,
                      color: Colors.grey.shade200,
                    ),
                    InkWell(
                      onTap: () {
                        _status = Status.CONFIRM;
                        _editingStatusController.text = "Duy???t ????n";
                        Navigator.pop(context);
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text("Duy???t ????n"),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _status = Status.CANCEL;
                        _editingStatusController.text = "Hu??? ????n";
                        Navigator.pop(context);
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text("Hu??? ????n"),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        });
  }

  void pickProvinceOrDistrictOrWard() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ListView.builder(
              controller: _controller,
              itemCount: _orderProvider.listProvice.length,
              itemBuilder: (BuildContext context, int index) {
                return item(_orderProvider.listProvice[index]);
              },
            ),
          );
        });
  }

  Widget item(ProvinceModel provinceModel) {
    return InkWell(
      onTap: () => {
        _editingProvinceController.text = provinceModel.name,
        _selectedProdvince = provinceModel.id,
        Navigator.pop(context),
      },
      child: Center(
        child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(provinceModel.name, style: const TextStyle(fontSize: 16)),
                ),
      ),
    );
  }

  Widget textFieldTap(String label, bool isProduct) {
    return InkWell(
      onTap: () => {
        isProduct == true ? chooseProduct() : pickStatus(),
      },
      child: IgnorePointer(
        child: TextFormField(
          decoration: InputDecoration(
              labelText: label,
              suffixIcon: const Icon(FontAwesomeIcons.angleDown)),
          controller: isProduct == true
              ? _editingProductNameController
              : _editingStatusController,
        ),
      ),
    );
  }

  Widget textAddressFieldTap(String label) {
    return InkWell(
      onTap: () => {
        pickProvinceOrDistrictOrWard(),
      },
      child: IgnorePointer(
        child: TextFormField(
          decoration: InputDecoration(
              labelText: label,
              suffixIcon: const Icon(FontAwesomeIcons.angleDown)),
          controller: _editingProvinceController,
        ),
      ),
    );
  }

  Widget paymentView() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      Radio(
                        fillColor: MaterialStateColor.resolveWith(
                            (states) => MyColor.PRIMARY_COLOR),
                        value: TypePay.PAID,
                        groupValue: _typePay,
                        onChanged: (TypePay? value) {
                          setState(() {
                            _typePay = value!;
                            _editingTamUngController.text = "";
                            _editingThuHoController.text = "";
                          });
                        },
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text(
                        'Nh???n ?????',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  )),
              Expanded(flex: 3, child: Container())
            ],
          ),
          Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      Radio(
                        fillColor: MaterialStateColor.resolveWith(
                            (states) => MyColor.PRIMARY_COLOR),
                        value: TypePay.PAYLATER,
                        groupValue: _typePay,
                        onChanged: (TypePay? value) {
                          setState(() {
                            _typePay = value!;
                          });
                        },
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text(
                        'T???m ???ng',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  )),
              Expanded(
                  flex: 3,
                  child: textField("S??? ti???n", _editingTamUngController,
                      isNumber: true))
            ],
          ),
          _typePay == TypePay.PAYLATER ? viewThuHo() : height(),
        ],
      ),
    );
  }

  Widget viewThuHo() {
    return Row(
      children: [
        Expanded(
            flex: 2,
            child: Row(
              children: [
                Radio(
                  fillColor: MaterialStateColor.resolveWith(
                      (states) => MyColor.PRIMARY_COLOR),
                  value: null,
                  groupValue: null,
                  onChanged: (void value) {
                    setState(() {
                      _isEditCOD = true;
                    });
                  },
                ),
                const SizedBox(
                  width: 8,
                ),
                const Text(
                  'Thu h???',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            )),
        Expanded(
            flex: 3,
            child: textField("S??? ti???n", _editingThuHoController,
                isNotEdit: _isEditCOD, isNumber: true))
      ],
    );
  }

  void createOrder() {
    String name = _editingFullNameController.text;
    String phone = _editingPhoneNumberController.text;
    String address = _editingAddressController.text;
    int moneyType = 0;
    _typePay == TypePay.PAID ? moneyType = 1 : moneyType = 2;
    String advanceMoney = _editingTamUngController.text;
    String collectMoney = _editingThuHoController.text;
    String note = _editingNoteController.text;
    int productId = _productId;
    int orderId = _orderId;
    String amount = _editingProductAmountController.text;
    String amountBox = _editingProductBoxController.text;
    int status = 0;
    if (_status == Status.CONFIRM) {
      status = 1;
    } else if (_status == Status.CANCEL) {
      status = 4;
    }

    switch (_typeAction) {
      case TypeAction.EDIT:
        if (name.isEmpty ||
            phone.isEmpty ||
            address.isEmpty ||
            amount.isEmpty ||
            status == 0 ||
            _selectedProdvince == 0) {
          _orderProvider.showAlert('Vui l??ng nh???p v?? ch???n ?????y ????? th??ng tin!');
          return;
        } else {
          if (productId == 0) {
            _orderProvider.showAlert('Vui l??ng ch???n s???n ph???m!');
            return;
          } else {
            if (moneyType == 2) {
              if (advanceMoney.isEmpty || collectMoney.isEmpty) {
                _orderProvider.showAlert('Vui l??ng nh???p s??? ti???n!');
                return;
              } else {
                if (_editingProductTotalMoneyController.text.isNotEmpty) {
                  int totalAmount =
                      int.parse(_editingProductTotalMoneyController.text);
                  int tamUng = int.parse(advanceMoney);
                  int thuHo = int.parse(collectMoney);
                  if (tamUng + thuHo < totalAmount) {
                    _orderProvider
                        .showAlert('T???ng t???m ???ng v?? thu h??? kh??ng ????ng!');
                    return;
                  }
                }
              }
            }
          }
        }
        _orderProvider.updateOrder(
            name,
            phone,
            address,
            moneyType,
            advanceMoney,
            collectMoney,
            note,
            productId,
            amount,
            orderId,
            status,
            amountBox,
            _selectedProdvince);
        break;
      case TypeAction.ADD:
        if (name.isEmpty ||
            phone.isEmpty ||
            address.isEmpty ||
            amount.isEmpty) {
          _orderProvider.showAlert('Vui l??ng nh???p ?????y ????? th??ng tin!');
          return;
        } else {
          if (productId == 0) {
            _orderProvider.showAlert('Vui l??ng ch???n s???n ph???m!');
            return;
          } else {
            if (moneyType == 2) {
              if (advanceMoney.isEmpty || collectMoney.isEmpty) {
                _orderProvider.showAlert('Vui l??ng nh???p s??? ti???n!');
                return;
              } else {
                if (_editingProductTotalMoneyController.text.isNotEmpty) {
                  int totalAmount =
                      int.parse(_editingProductTotalMoneyController.text);
                  int tamUng = int.parse(advanceMoney);
                  int thuHo = int.parse(collectMoney);
                  if (tamUng + thuHo < totalAmount) {
                    _orderProvider
                        .showAlert('T???ng t???m ???ng v?? thu h??? kh??ng ????ng!');
                    return;
                  }
                }
              }
            }
          }
        }
        _orderProvider.createOrder(
            name,
            phone,
            address,
            moneyType,
            advanceMoney,
            collectMoney,
            note,
            productId,
            amount,
            amountBox,
            _selectedProdvince);
        break;
    }
  }

  void setDefaultData() {
    final order = widget._orderModel!;
    _editingProductBoxController.text = order.numberBox.toString();
    _editingFullNameController.text = order.name;
    _editingPhoneNumberController.text = order.phone;
    _editingAddressController.text = order.address;
    _editingProductNameController.text = order.orderDetails.first.product.name!;
    _editingProductTypeController.text =
        order.orderDetails.first.product.species!;
    _editingProductUnitController.text = order.orderDetails.first.product.unit!;
    _editingProductAmountController.text =
        order.orderDetails.first.quantity.toString();
    _editingProductPriceController.text =
        order.orderDetails.first.product.price.toString();
    if (order.note != null) {
      _editingNoteController.text = order.note!;
    } else {
      _editingNoteController.text = "";
    }
    if (order.status == 1){
      _status = Status.CONFIRM;
      _editingStatusController.text = "Duy???t ????n";
    }
    for (var province in _orderProvider.listProvice) {
      if (province.id == order.provinceId){
        _editingProvinceController.text = province.name;
        _selectedProdvince = province.id;
        break;
      }
    }
    _editingProductTotalMoneyController.text =
        (int.parse(_editingProductAmountController.text) *
                int.parse(_editingProductPriceController.text))
            .toString();
    if (order.moneyType == 1) {
      _typePay = TypePay.PAID;
      _editingTamUngController.text = "0";
      _editingThuHoController.text = "0";
    } else {
      _editingTamUngController.text = order.advanceMoney.toString();
      _editingThuHoController.text = order.collectMoney.toString();
      _typePay = TypePay.PAYLATER;
    }
    _productId = order.orderDetails.first.productId;
  }

  resetData() {
    _productId = 0;
    _isEditCOD = false;
    _typePay = TypePay.PAID;
    final controllers = [
      _editingFullNameController,
      _editingPhoneNumberController,
      _editingAddressController,
      _editingProductNameController,
      _editingProductTypeController,
      _editingProductUnitController,
      _editingTamUngController,
      _editingThuHoController,
      _editingProductAmountController,
      _editingProductPriceController,
      _editingProductTotalMoneyController,
      _editingProductBoxController,
      _editingProvinceController
    ];
    for (var element in controllers) {
      element.text = "";
    }
    _selectedProdvince = 0;
  }
}
