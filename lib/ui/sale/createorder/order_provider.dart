import 'dart:async';

import 'package:dio/dio.dart';
import 'package:serepok/api/repository/order_repository.dart';

import '../../../base/base_provider.dart';
import '../../../model/address_model.dart';
import '../../../model/order_model.dart';
import '../../../model/paging_respone_model.dart';

class OrderProvider extends BaseProvider {
  final OrderRepository _orderRepository = OrderRepository();
  Function? createOrderSuccessCallback;
  Function? updateOrderSuccessCallback;
  Function? pullShipSuccessCallback;
  List<OrderModel> listOrderPending = [];
  List<OrderModel> listOrderApproved = [];
  List<OrderModel> listOrderComplete = [];
  List<OrderModel> listOrderShipping = [];
  List<ProvinceModel> listProvice = [];
  List<DistrictModel> listDistrict = [];
  List<WardModel> listWard = [];
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

  Future<void> getListOrderShipping(int provinceId) async {
    showLoading();
    try {
      final response = await _orderRepository.getListOrderShipping(pageNumber,provinceId);
      handleDataListShipping(response);
      hideLoading();
    } on Exception catch (error) {
      handleErrors(error);
    }
  }

  Future<void> getListProvince() async {
    showLoading();
    try {
      final response = await _orderRepository.getListProvince();
      handleDataListProvince(response);
      hideLoading();
    } on Exception catch (error) {
      handleErrors(error);
    }
  }

  FutureOr handleDataListProvince(List<ProvinceModel> data) async {
    listProvice.addAll(data);
    notifyListeners();
    hideLoading();
  }

  Future<void> getListDistrict(int provinceId) async {
    showLoading();
    try {
      final response = await _orderRepository.getListDistrict(provinceId);
      handleDataListDistrict(response);
      hideLoading();
    } on Exception catch (error) {
      handleErrors(error);
    }
  }

  FutureOr handleDataListDistrict(
      List<DistrictModel> data) async {
    listDistrict.addAll(data);
    notifyListeners();
    hideLoading();
  }

  Future<void> getListWard(int districtId) async {
    showLoading();
    try {
      final response = await _orderRepository.getListWard(districtId);
      handleDataListWard(response);
      hideLoading();
    } on Exception catch (error) {
      handleErrors(error);
    }
  }

  FutureOr handleDataListWard(List<WardModel> data) async {
    listWard.addAll(data);
    notifyListeners();
    hideLoading();
  }

  FutureOr handleDataListShipping(PagingResponseModel<OrderModel> data) async {
    if (isRefresh) {
      isRefresh = false;
      listOrderShipping.clear();
    }
    listOrderShipping.addAll(data.data);
    isCanLoadMore = pageNumber < data.lastPage;
    notifyListeners();
    hideLoading();
  }

  FutureOr handleDataListComplete(PagingResponseModel<OrderModel> data) async {
    if (isRefresh) {
      isRefresh = false;
      listOrderComplete.clear();
    }
    listOrderComplete.addAll(data.data);
    isCanLoadMore = pageNumber < data.lastPage;
    notifyListeners();
    hideLoading();
  }

  FutureOr handleDataListPending(PagingResponseModel<OrderModel> data) async {
    if (isRefresh) {
      isRefresh = false;
      listOrderPending.clear();
    }
    listOrderPending.addAll(data.data);
    isCanLoadMore = pageNumber < data.lastPage;
    notifyListeners();
    hideLoading();
  }

  FutureOr handleDataListApproved(PagingResponseModel<OrderModel> data) async {
    if (isRefresh) {
      isRefresh = false;
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
    String amount,
    String amountBox,
    int provinceId,
  ) async {
    showLoading();
    String paramId = "products[$productId]";
    int tamUng = 0;
    int thuHo = 0;
    if (moneyType == 2) {
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
      'number_box': amountBox,
      'province_id': provinceId,
      'number_box': int.parse(amountBox),
      paramId: int.parse(amount)
    });

    _orderRepository
        .createOrder(formData)
        .then(createOrderSuccess)
        .onError(handleError);
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
    int status,
    String amountBox,
    int provinceId,
  ) async {
    showLoading();
    String paramId = "products[$productId]";
    int tamUng = 0;
    int thuHo = 0;
    if (moneyType == 2) {
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
      'number_box': amountBox,
      'province_id': provinceId,
      paramId: int.parse(amount)
    });
    _status = status;
    _orderRepository
        .updateOrder(formData, orderId)
        .then(updateOrderSuccess)
        .onError(handleError);
  }

  void dispose() {
    listOrderPending = [];
    listOrderApproved = [];
    listOrderComplete = [];
    listOrderShipping = [];
  }

  void pullShipOrder(
    List<int> listId,
    String phone,
  ) async {
    showLoading();
    var formData = FormData.fromMap({'ids': listId, 'phone': phone});
    _orderRepository
        .pullShipOrder(formData)
        .then(pullShipOrderSuccess)
        .onError(handleError);
  }

  FutureOr createOrderSuccess(l) {
    showAlert('Tạo đơn hàng thành công');
    createOrderSuccessCallback?.call();
    hideLoading();
  }

  FutureOr pullShipOrderSuccess(List<CreateModel> data) {
    pullShipSuccessCallback?.call();
    hideLoading();
  }

  FutureOr updateOrderSuccess(OrderModel orderModel) {
    var formData = FormData.fromMap({
      'status': _status,
    });
    _orderRepository
        .updateOrderStatus((formData), orderModel.id)
        .then(updateStatusSuccess)
        .onError(handleError);
  }

  FutureOr updateStatusSuccess(l) {
    updateOrderSuccessCallback?.call();
    hideLoading();
  }
}
