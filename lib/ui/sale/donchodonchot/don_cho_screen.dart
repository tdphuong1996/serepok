import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:serepok/model/order_model.dart';

import '../../../res/AppThemes.dart';
import '../../../routes.dart';
import '../createorder/order_provider.dart';

class DonChoScreen extends StatefulWidget {
  const DonChoScreen({Key? key}) : super(key: key);

  @override
  State<DonChoScreen> createState() => _DonChoScreenState();
}

class _DonChoScreenState extends State<DonChoScreen> {
  late OrderProvider _orderProvider;
  late ScrollController _controller;
  bool _isLoadMoreRunning = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _orderProvider = Provider.of<OrderProvider>(context, listen: false);
    _orderProvider.context = context;
    _orderProvider.getListOrder();
    _controller = ScrollController();
    _controller.addListener(_loadMore);
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
                itemCount: _orderProvider.listOrder.length,
                itemBuilder: (context, index) {
                  return item(_orderProvider.listOrder[index]);
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
          elevation: 3,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    itemInfo(FontAwesomeIcons.calendar, '12/12/1212'),
                    const SizedBox(width: 30),
                    itemInfo(FontAwesomeIcons.barcode, '234324A'),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                itemInfo(
                    FontAwesomeIcons.circleInfo, 'Nguyen Van A -  09888787878'),
                const SizedBox(
                  height: 8,
                ),
                itemInfo(FontAwesomeIcons.fileInvoice,
                    'Sầu Ri6 - 10 - Dak nong  '),
                const SizedBox(
                  height: 8,
                ),
                itemInfo(FontAwesomeIcons.listCheck,
                    'Tạm ứng'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> itemClick(OrderModel orderModel) async {
    final result = await Navigator.pushNamed(context, Routes.ADD_PRODUCT,
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
    await _orderProvider.getListOrder();
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
      await _orderProvider.getListOrder();
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
        style: TextStyle(fontSize: 16),
      )
    ],
  );
}
