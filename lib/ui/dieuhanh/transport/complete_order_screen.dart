import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../model/order_model.dart';
import '../../../res/AppThemes.dart';
import '../../../routes.dart';
import '../../sale/createorder/order_provider.dart';

class CompleteOrderScreen extends StatefulWidget{
  const CompleteOrderScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CompleteOrderScreen();
}

class _CompleteOrderScreen extends State<CompleteOrderScreen>{
  late OrderProvider _orderProvider;
  late ScrollController _controller;
  bool _isLoadMoreRunning = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _orderProvider = Provider.of<OrderProvider>(context, listen: false);
    _orderProvider.context = context;
    _controller = ScrollController();
    _controller.addListener(_loadMore);
    _orderProvider.getListOrderComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(builder: (context, value, child) {
      return Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refresh,
              child: ListView.builder(
                controller: _controller,
                itemCount: _orderProvider.listOrderComplete.length,
                itemBuilder: (context, index) {
                  return item(_orderProvider.listOrderComplete[index]);
                },
              ),
            ),
          ),
          if (_isLoadMoreRunning == true)
            const Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: SizedBox(
                width: 30,
                height: 30,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
        ],
      );
    });
  }

  Widget item(OrderModel orderModel) {
    return InkWell(
      onTap: () => {itemClick(orderModel)},
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
        child: Card(
          elevation: 5,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    itemInfo(FontAwesomeIcons.calendar,
                        convertDatetime(orderModel.createdAt)),
                    const SizedBox(width: 30),
                    itemInfo(FontAwesomeIcons.barcode, orderModel.code),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                InkWell(
                  onTap: () {launch("tel://${orderModel.phone}");},
                  child: itemInfo(FontAwesomeIcons.circleInfo,
                      '${orderModel.name} -  ${orderModel.phone}'),
                ),
                const SizedBox(
                  height: 8,
                ),
                itemInfo(FontAwesomeIcons.fileInvoice,
                    orderModel.orderDetails.first.product.name!),
                const SizedBox(
                  height: 8,
                ),
                itemInfo(FontAwesomeIcons.listCheck,
                    orderModel.moneyType == 1 ? 'Nhận đủ' : 'Tạm ứng'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> itemClick(OrderModel orderModel) async {
    final result = await Navigator.pushNamed(context, Routes.CREATE_ORDER,
        arguments: orderModel);
    if (result != null) {
      showOkAlertDialog(
          context: context, message: 'Cập nhật thông tin thành công');
      _refresh();
    }
  }

  String convertDatetime(String date) {
    String stringYear = date.substring(0, 10);
    String stringTime = date.substring(11, 19);
    String result = '$stringYear $stringTime';
    return result;
  }

  Future<void> _refresh() async {
    _orderProvider.isRefresh = true;
    _orderProvider.pageNumber = 1;
    await _orderProvider.getListOrderComplete();
  }


  @override
  void dispose() {
    _orderProvider.dispose();
    _controller.removeListener(_loadMore);
    super.dispose();
  }

  void _loadMore() async {
    if (_isLoading) return;
    final thresholdReached = _controller.position.extentAfter < 200;
    if (thresholdReached && _orderProvider.isCanLoadMore) {
      setState(() {
        _isLoadMoreRunning = true;
      });
      _isLoading = true;
      _orderProvider.isLoadMore = true;
      _orderProvider.pageNumber++;
      await _orderProvider.getListOrderComplete();
      _isLoading = false;
      setState(() {
        _isLoadMoreRunning = false;
      });
    }
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