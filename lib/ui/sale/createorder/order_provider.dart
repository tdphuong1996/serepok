import 'dart:async';

import 'package:dio/dio.dart';
import 'package:serepok/api/repository/order_repository.dart';

import '../../../base/base_provider.dart';
import '../../../model/order_model.dart';
import '../../../model/paging_respone_model.dart';

class OrderProvider extends BaseProvider {
  final OrderRepository _orderRepository = OrderRepository();
  Function? createOrderSuccessCallback;
  Function? updateOrderSuccessCallback;
  List<OrderModel> listOrder = [];


  Future<void> getListOrder() async {
    showLoading();
    try {
      final response = await _orderRepository.getListOrder(pageNumber);
      handleDataList(response);
      hideLoading();
    } on Exception catch (error) {
      handleErrors(error);
    }
  }

  FutureOr handleDataList(PagingResponseModel<OrderModel> data) async {
    if(isRefresh){
      isRefresh=  false;
      listOrder.clear();
    }
    listOrder.addAll(data.data);
    isCanLoadMore = pageNumber < data.lastPage;
    notifyListeners();
    hideLoading();
  }

  void createOrder(
      String name,
      String phone,
      String address,
      int moneyType,
      String advanceMoney,
      String collectMoney,
      String note,
      int productId,
      String amount,
      ) async{
    showLoading();
    String paramId = "products[$productId]";
    int tamUng = 0;
    int thuHo = 0;
    if(moneyType == 2){
      tamUng = int.parse(advanceMoney);
      thuHo = int.parse(collectMoney);
    }
    var formData = FormData.fromMap({
      'name': name,
      'phone': phone,
      'address': address,
      'money_type': moneyType,
      'advance_money': tamUng,
      'collect_money': thuHo,
      'note': note,
      paramId: int.parse(amount)
    });

    _orderRepository.createOrder(formData).then(createOrderSuccess).onError(handleError);
  }

  void updateOrder(
      String name,
      String phone,
      String address,
      int moneyType,
      String advanceMoney,
      String collectMoney,
      String note,
      int productId,
      String amount,
      int orderId,
      ) async{
    showLoading();
    String paramId = "products[$productId]";
    int tamUng = 0;
    int thuHo = 0;
    if(moneyType == 2){
      tamUng = int.parse(advanceMoney);
      thuHo = int.parse(collectMoney);
    }
    var formData = FormData.fromMap({
      'name': name,
      'phone': phone,
      'address': address,
      'money_type': moneyType,
      'advance_money': tamUng,
      'collect_money': thuHo,
      'note': note,
      paramId: int.parse(amount)
    });

    _orderRepository.updateOrder(formData, orderId).then(updateOrderSuccess).onError(handleError);
  }

  FutureOr createOrderSuccess(l){
    showAlert('Tạo đơn hàng thành công');
    createOrderSuccessCallback?.call();
    hideLoading();
  }

  FutureOr updateOrderSuccess(OrderModel orderModel){
    showAlert('Cập nhật đơn hàng thành công');
    updateOrderSuccessCallback?.call();
    hideLoading();
  }
}