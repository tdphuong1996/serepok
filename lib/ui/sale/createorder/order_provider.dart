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
  List<OrderModel> listOrderPending = [];
  List<OrderModel> listOrderApproved = [];
  List<OrderModel> listOrderComplete = [];
  List<OrderModel> listOrderShipping = [];
  late int _status;

  Future<void> getListOrderPending() async {
    showLoading();
    try {
      final response = await _orderRepository.getListOrderPending(pageNumber);
      handleDataListPending(response);
      hideLoading();
    } on Exception catch (error) {
      handleErrors(error);
    }
  }

  Future<void> getListOrderApproved() async {
    showLoading();
    try {
      final response = await _orderRepository.getListOrderApproved(pageNumber);
      handleDataListApproved(response);
      hideLoading();
    } on Exception catch (error) {
      handleErrors(error);
    }
  }

  Future<void> getListOrderComplete() async {
    showLoading();
    try {
      final response = await _orderRepository.getListOrderComplete(pageNumber);
      handleDataListComplete(response);
      hideLoading();
    } on Exception catch (error) {
      handleErrors(error);
    }
  }

  Future<void> getListOrderShipping() async {
    showLoading();
    try {
      final response = await _orderRepository.getListOrderShipping(pageNumber);
      handleDataListShipping(response);
      hideLoading();
    } on Exception catch (error) {
      handleErrors(error);
    }
  }

  FutureOr handleDataListShipping(PagingResponseModel<OrderModel> data) async {
    if(isRefresh){
      isRefresh=  false;
      listOrderShipping.clear();
    }
    listOrderShipping.addAll(data.data);
    isCanLoadMore = pageNumber < data.lastPage;
    notifyListeners();
    hideLoading();
  }

  FutureOr handleDataListComplete(PagingResponseModel<OrderModel> data) async {
    if(isRefresh){
      isRefresh=  false;
      listOrderComplete.clear();
    }
    listOrderComplete.addAll(data.data);
    isCanLoadMore = pageNumber < data.lastPage;
    notifyListeners();
    hideLoading();
  }

  FutureOr handleDataListPending(PagingResponseModel<OrderModel> data) async {
    if(isRefresh){
      isRefresh=  false;
      listOrderPending.clear();
    }
    listOrderPending.addAll(data.data);
    isCanLoadMore = pageNumber < data.lastPage;
    notifyListeners();
    hideLoading();
  }

  FutureOr handleDataListApproved(PagingResponseModel<OrderModel> data) async {
    if(isRefresh){
      isRefresh=  false;
      listOrderApproved.clear();
    }
    listOrderApproved.addAll(data.data);
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
      String amount, String amountBox,
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
      'number_box': int.parse(amountBox),
      paramId: int.parse(amount)
    });

    _orderRepository.createOrder(formData).then(createOrderSuccess).onError(handleError);
  }

  void dispose() {
    listOrderPending = [];
    listOrderApproved = [];
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
      int orderId, int status, String amountBox,
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
      'number_box': int.parse(amountBox),
      paramId: int.parse(amount)
    });
    _status = status;
    _orderRepository.updateOrder(formData, orderId).then(updateOrderSuccess).onError(handleError);
  }

  FutureOr createOrderSuccess(l){
    showAlert('Tạo đơn hàng thành công');
    createOrderSuccessCallback?.call();
    hideLoading();
  }

  FutureOr updateOrderSuccess(OrderModel orderModel){
    var formData = FormData.fromMap({
      'status': _status,
    });
    _orderRepository.updateOrderStatus((formData), orderModel.id).then(updateStatusSuccess).onError(handleError);
  }

  FutureOr updateStatusSuccess(l){
    updateOrderSuccessCallback?.call();
    hideLoading();
  }
}