import 'package:dio/dio.dart';
import 'package:serepok/model/base_response_model.dart';

import '../../model/order_model.dart';
import '../../model/paging_respone_model.dart';
import '../api_client.dart';
import '../apis.dart';

class OrderRepository {
  final ApiClient _apiClient = ApiClient();

  Future<PagingResponseModel<OrderModel>> getListOrderPending(
      int pageNumber) async {
    final dataResponse = await _apiClient
        .get<PagingResponseModel<OrderModel>>(Api.createOrder,
        param: {'page': pageNumber, 'status': 0});
    return dataResponse.handleData();
  }

  Future<PagingResponseModel<OrderModel>> getListOrderApproved(
      int pageNumber) async {
    final dataResponse = await _apiClient
        .get<PagingResponseModel<OrderModel>>(Api.createOrder,
        param: {'page': pageNumber, 'status': 1});
    return dataResponse.handleData();
  }

  Future<PagingResponseModel<OrderModel>> getListOrderComplete(
      int pageNumber) async {
    final dataResponse = await _apiClient
        .get<PagingResponseModel<OrderModel>>(Api.createOrder,
        param: {'page': pageNumber, 'status': 3});
    return dataResponse.handleData();
  }

  Future<PagingResponseModel<OrderModel>> getListOrderShipping(
      int pageNumber) async {
    final dataResponse = await _apiClient
        .get<PagingResponseModel<OrderModel>>(Api.createOrder,
        param: {'page': pageNumber, 'status': 2});
    return dataResponse.handleData();
  }

  Future<CreateModel> createOrder(FormData formData) async {
    final dataResponse =
        await _apiClient.postFormData<CreateModel>(Api.createOrder, formData);
    return dataResponse.handleData();
  }

  Future<CreateModel> pullShipOrder(FormData formData) async {
    final dataResponse =
    await _apiClient.postFormData<CreateModel>(Api.pullShip, formData);
    return dataResponse.handleData();
  }

  Future<OrderModel> updateOrder(FormData formData, int id) async {
    final dataResponse = await _apiClient.postFormData<OrderModel>(
        "${Api.updateOrder}/$id", formData);
    return dataResponse.handleData();
  }

  Future<OrderModel> updateOrderStatus(FormData formData, int id) async {
    final dataResponse = await _apiClient.postFormData<OrderModel>(
        "${Api.updateOrderStatus}/$id", formData);
    return dataResponse.handleData();
  }
}
