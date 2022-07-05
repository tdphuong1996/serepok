import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:serepok/model/order_model.dart';
import 'package:serepok/model/product_model.dart';
import 'package:serepok/ui/sale/createorder/order_provider.dart';

import '../../../res/AppThemes.dart';
import '../../../res/AppThemes.dart';
import '../../../res/AppThemes.dart';
import '../../../res/AppThemes.dart';
import '../../../res/constant.dart';
import '../../../routes.dart';

class CreateOrderScreen extends StatefulWidget {
  final OrderModel? _orderModel;

  const CreateOrderScreen(this._orderModel, {Key? key}) : super(key: key);

  @override
  State<CreateOrderScreen> createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends State<CreateOrderScreen> {
  late OrderProvider _orderProvider;
  final TextEditingController _editingFullNameController =
      TextEditingController();
  final TextEditingController _editingPhoneNumberController =
      TextEditingController();
  final TextEditingController _editingAddressController =
      TextEditingController();
  final TextEditingController _editingProductNameController =
      TextEditingController();
  final TextEditingController _editingProductTypeController =
      TextEditingController();
  final TextEditingController _editingProductUnitController =
      TextEditingController();
  final TextEditingController _editingProductAmountController =
      TextEditingController();
  final TextEditingController _editingProductPriceController =
      TextEditingController();
  final TextEditingController _editingProductTotalMoneyController =
      TextEditingController();
  final TextEditingController _editingNoteController = TextEditingController();
  final TextEditingController _editingTamUngController =
      TextEditingController();
  final TextEditingController _editingThuHoController = TextEditingController();
  TypeAction _typeAction = TypeAction.ADD;
  TypePay _typePay = TypePay.PAID;
  bool _isEditCOD = false;
  int _productId = 0;

  @override
  void initState() {
    super.initState();
    try {
      _orderProvider = Provider.of<OrderProvider>(context, listen: false);
      _orderProvider.context = context;
      _orderProvider.createOrderSuccessCallback = resetData;
      _orderProvider.updateOrderSuccessCallback = () {
        Navigator.pop(context, "update_success");
      };
      _typeAction =
          widget._orderModel?.id != 0 ? TypeAction.EDIT : TypeAction.ADD;
      if (_typeAction == TypeAction.EDIT) {
        setDefaultData();
      }
    } on Exception catch (error) {
      debugPrint('loi neeeeeee: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanDown: (pd) {
        FocusScope.of(context).unfocus();
      },
      child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      height(),
                      textField("Tên khách hàng", _editingFullNameController),
                      height(),
                      textField("Số điện thoại", _editingPhoneNumberController),
                      height(),
                      textField("Địa chỉ", _editingAddressController),
                      height(),
                      textFieldTap("Tên hàng"),
                      height(),
                      viewChungLoaiDVT(),
                      height(),
                      viewSoLuongDonGia(),
                      height(),
                      textField(
                          "Tổng tiền", _editingProductTotalMoneyController,
                          isNotEdit: true),
                      height(),
                      header(),
                      height(),
                      paymentView(),
                      textField("Ghi chú", _editingNoteController),
                      height(),
                    ],
                  ),
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
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      padding: const EdgeInsets.only(
                          top: 8, left: 32, right: 32, bottom: 8),
                      pressedOpacity: 0.5,
                      child: const Text('Hoàn thành')),
                ),
              )
            ],
          )),
    );
  }

  Future<void> chooseProduct() async {
    final result = await Navigator.of(context).pushNamed(Routes.CHOOSE_PRODUCT);
    if (result != null) {
      final product = result as ProductModel;
      _editingProductNameController.text = product.name;
      _editingProductTypeController.text = product.species;
      _editingProductUnitController.text = product.unit;
      _editingProductPriceController.text = product.price.toString();
      _productId = product.id;
    }
  }

  Widget header() {
    return Row(
      children: const [
        Text(
          "Thanh toán",
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
            child: textField("Chủng loại", _editingProductTypeController,
                isNotEdit: true)),
        const SizedBox(
          width: 16,
        ),
        Expanded(
            flex: 1,
            child: textField("Đơn vị tính", _editingProductUnitController,
                isNotEdit: true))
      ],
    );
  }

  Widget viewSoLuongDonGia() {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: textField("Số lượng", _editingProductAmountController,
                isCalculate: true, isNumber: true)),
        const SizedBox(
          width: 16,
        ),
        Expanded(
            flex: 1,
            child: textField("Đơn giá", _editingProductPriceController,
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
      onFieldSubmitted: (text) => {
        isCalculate == true
            ? _editingProductTotalMoneyController.text =
                (int.parse(_editingProductAmountController.text) *
                        int.parse(_editingProductPriceController.text))
                    .toString()
            : controller.text = text
      },
    );
  }

  Widget textFieldTap(String label) {
    return InkWell(
      onTap: () => {chooseProduct()},
      child: IgnorePointer(
        child: TextFormField(
          decoration: InputDecoration(
              labelText: label,
              suffixIcon: const Icon(FontAwesomeIcons.angleDown)),
          controller: _editingProductNameController,
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
                          });
                        },
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text(
                        'Nhận đủ',
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
                        'Tạm ứng',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  )),
              Expanded(
                  flex: 3,
                  child: textField("Số tiền", _editingTamUngController,
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
                  'Thu hộ',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            )),
        Expanded(
            flex: 3,
            child: textField("Số tiền", _editingThuHoController,
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
    String amount = _editingProductAmountController.text;

    switch (_typeAction) {
      case TypeAction.EDIT:
      case TypeAction.ADD:
        if (name.isEmpty ||
            phone.isEmpty ||
            address.isEmpty ||
            amount.isEmpty) {
          _orderProvider.showAlert('Vui lòng nhập đầy đủ thông tin!');
          return;
        } else {
          if (productId == 0) {
            _orderProvider.showAlert('Vui lòng chọn sản phẩm!');
            return;
          } else {
            if (moneyType == 2) {
              if (advanceMoney.isEmpty || collectMoney.isEmpty) {
                _orderProvider.showAlert('Vui lòng nhập số tiền!');
                return;
              } else {
                if (_editingProductTotalMoneyController.text.isNotEmpty) {
                  int totalAmount =
                      int.parse(_editingProductTotalMoneyController.text);
                  int tamUng = int.parse(advanceMoney);
                  int thuHo = int.parse(collectMoney);
                  if (tamUng + thuHo < totalAmount) {
                    _orderProvider
                        .showAlert('Tổng tạm ứng và thu hộ không đúng!');
                    return;
                  }
                }
              }
            }
          }
        }
        _orderProvider.createOrder(name, phone, address, moneyType,
            advanceMoney, collectMoney, note, productId, amount);
        break;
    }
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
    ];
    for (var element in controllers) {
      element.text = "";
    }
  }

  void setDefaultData() {}
}
