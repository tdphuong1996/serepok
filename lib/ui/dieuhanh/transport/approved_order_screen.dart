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

class ApprovedOrderScreen extends StatefulWidget {
  const ApprovedOrderScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ApprovedOrderScreen();
}

class _ApprovedOrderScreen extends State<ApprovedOrderScreen> {
  late OrderProvider _orderProvider;
  late ScrollController _controller;
  bool _isLoadMoreRunning = false;
  bool _isLoading = false;
  final List<OrderModel> _listOrderChoose = [];
  bool _isChoose = false;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _orderProvider = Provider.of<OrderProvider>(context, listen: false);
    _orderProvider.context = context;
    _controller = ScrollController();
    _controller.addListener(_loadMore);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (context, value, child) {
        return Scaffold(
          body: Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _refresh,
                  child: ListView.builder(
                    controller: _controller,
                    itemCount: _orderProvider.listOrderApproved.length,
                    itemBuilder: (context, index) {
                      return item(_orderProvider.listOrderApproved[index], index);
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
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (_listOrderChoose.isEmpty) {
                showOkAlertDialog(
                    context: context,
                    message:
                    'Vui lòng chọn ít nhất 1 đơn hàng để đẩy ship!');
              } else {
                _pullShip();
              }
            },
            child: const Icon(FontAwesomeIcons.truckFast,color: MyColor.ICON_COLOR,),
          ),
        );
      },
    );
  }

  Widget item(OrderModel orderModel, int index) {
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
                    Checkbox(
                        checkColor: Colors.white,
                        activeColor: MyColor.PRIMARY_COLOR,
                        value: _listOrderChoose.contains(orderModel)
                            ? true
                            : false,
                        onChanged: (bool? value) {
                          if (value == true) {
                            _listOrderChoose.add(orderModel);
                          } else {
                            _listOrderChoose.remove(orderModel);
                          }
                          setState(() => {
                                _isChoose =
                                    _listOrderChoose.contains(orderModel)
                                        ? true
                                        : false,
                              });
                        }),
                    Text(
                      orderModel.code,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    launch("tel://${orderModel.phone}");
                  },
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
                Row(children: [
                  itemInfo(FontAwesomeIcons.listCheck,
                      orderModel.moneyType == 1 ? 'Nhận đủ' : 'Tạm ứng'),
                  const Spacer(),
                  itemInfo(FontAwesomeIcons.calendar,
                      convertDatetime(orderModel.createdAt)),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> itemClick(OrderModel orderModel) async {}

  String convertDatetime(String date) {
    String stringYear = date.substring(0, 10);
    String stringTime = date.substring(11, 19);
    String result = '$stringYear $stringTime';
    return result;
  }

  Future<void> _refresh() async {
    _orderProvider.isRefresh = true;
    _orderProvider.pageNumber = 1;
    await _orderProvider.getListOrderApproved();
  }

  @override
  void dispose() {
    _orderProvider.dispose();
    _controller.removeListener(_loadMore);
    super.dispose();
  }

  void _pullShip() async {
    final result = await Navigator.of(context).pushNamed(
        Routes.ENTER_PHONE_TRANSPORT_SCREEN,
        arguments: _listOrderChoose);
    if (result != null) {
      showOkAlertDialog(context: context, message: 'Đã đẩy ship thành công!');
      _refresh();
    }
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
      await _orderProvider.getListOrderApproved();
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
