import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:serepok/model/order_model.dart';
import 'package:serepok/res/constant.dart';

import '../../../res/AppThemes.dart';
import '../../../routes.dart';
import '../createorder/order_provider.dart';

class DonChoScreen extends StatefulWidget {
  final OrderType _orderType;

  const DonChoScreen(this._orderType, {Key? key}) : super(key: key);

  @override
  State<DonChoScreen> createState() => _DonChoScreenState();
}

class _DonChoScreenState extends State<DonChoScreen> {
  late OrderProvider _orderProvider;
  late ScrollController _controller;
  bool _isLoadMoreRunning = false;
  bool _isLoading = false;
  OrderType? _orderTypeSetView;

  @override
  void initState() {
    super.initState();
    _orderProvider = Provider.of<OrderProvider>(context, listen: false);
    _orderProvider.context = context;
    _orderProvider.getListOrderPending();
    _orderProvider.getListOrderApproved();
    _controller = ScrollController();
    _controller.addListener(_loadMore);
    _orderTypeSetView = widget._orderType;
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
                itemCount: _orderTypeSetView == OrderType.PENDING
                    ? _orderProvider.listOrderPending.length
                    : _orderProvider.listOrderApproved.length,
                itemBuilder: (context, index) {
                  return _orderTypeSetView == OrderType.PENDING
                    ? item(_orderProvider.listOrderPending[index])
                    : item(_orderProvider.listOrderApproved[index]);
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
                itemInfo(FontAwesomeIcons.circleInfo,
                    '${orderModel.name} -  ${orderModel.phone}'),
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

  Future<void> _refresh() async {
    _orderProvider.isRefresh = true;
    _orderProvider.pageNumber = 1;
    if (_orderTypeSetView == OrderType.PENDING){
      await _orderProvider.getListOrderPending();
    }else{
      await _orderProvider.getListOrderApproved();
    }
  }

  @override
  void dispose() {
    _orderProvider.dispose();
    _controller.removeListener(_loadMore);
    super.dispose();
  }

  String convertDatetime(String date) {
    String stringYear = date.substring(0, 10);
    String stringTime = date.substring(11, 19);
    String result = '$stringYear $stringTime';
    return result;
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
      if (_orderTypeSetView == OrderType.PENDING){
        await _orderProvider.getListOrderPending();
      }else{
        await _orderProvider.getListOrderApproved();
      }
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
