import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:serepok/model/order_model.dart';

import '../../../res/AppThemes.dart';
import '../../sale/createorder/order_provider.dart';

class EnterPhoneTransportScreen extends StatefulWidget {
  final List<OrderModel>? _listOrder;

  const EnterPhoneTransportScreen(this._listOrder, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EnterPhoneTransportScreen();
}

class _EnterPhoneTransportScreen extends State<EnterPhoneTransportScreen> {
  final _editingTransportController = TextEditingController();
  List<String> _listOrderCode = [];
  List<int> _listOrderId = [];
  late OrderProvider _orderProvider;


  @override
  void initState() {
    super.initState();
    try {
      _orderProvider = Provider.of<OrderProvider>(context, listen: false);
      _orderProvider.context = context;
      _orderProvider.pullShipSuccessCallback = () {
        Navigator.pop(context, "pull_ship_order_success");
      };
    } on Exception catch (error) {
      debugPrint('loi neeeeeee: $error');
    }
    if (widget._listOrder != null){
      for (var order in widget._listOrder!) {
        _listOrderCode.add(order.code);
        _listOrderId.add(order.id);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chuẩn bị đẩy ship'),
      ),
      body: GestureDetector(
        onPanDown: (pd) {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(child: mainView()),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CupertinoButton(
                        color: MyColor.PRIMARY_COLOR,
                        onPressed: () {
                          _orderProvider.pullShipOrder(_listOrderId, _editingTransportController.text);
                        },
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        padding: const EdgeInsets.only(
                            top: 8, left: 32, right: 32, bottom: 8),
                        pressedOpacity: 0.5,
                        child: const Text('Đẩy đơn')),
                  ),
                )
              ],
            )),
      ),
    );
  }

  Widget mainView() {
    return Column(
      children: [
        itemInfo(FontAwesomeIcons.barcode, _listOrderCode.toString()),
        height(),
        textField('Nhập Sđt nhà vận chuyển', _editingTransportController),
        height()
      ],
    );
  }

  Widget height() {
    return const SizedBox(
      height: 16,
    );
  }

  Widget textField(String label, TextEditingController controller,
      {bool isNotEdit = false, bool isCalculate = false, isNumber = false}) {
    return TextFormField(
      readOnly: isNotEdit,
      decoration: InputDecoration(labelText: label),
      controller: controller,
    );
  }
}

Widget itemInfo(IconData icon, String info) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Icon(
        icon,
        color: MyColor.PRIMARY_COLOR,
        size: 18,
      ),
      const SizedBox(
        width: 8,
      ),
      Text(
        info,
        style: const TextStyle(fontSize: 16),
      )
    ],
  );
}
