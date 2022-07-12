import 'package:dio/dio.dart';
import 'package:serepok/model/base_response_model.dart';

import '../../model/order_model.dart';
import '../../model/paging_respone_model.dart';
import '../api_client.dart';
import '../apis.dart';

class OrderRepository {
  final ApiClient _apiClient = ApiClient();

  Future<PagingResponseModel<OrderModel>> getListOrder(
      int pageNumber) async {
    final dataResponse = await _apiClient
        .get<PagingResponseModel<OrderModel>>(Api.createOrder,
        param: {'page': pageNumber, 'status': 0});
    return dataResponse.handleData();
  }

  Future createOrder(FormData formData) async {
    final dataResponse =
        await _apiClient.postFormData(Api.createOrder, formData);
    return dataResponse.handleData();
  }

  Future<OrderModel> updateOrder(FormData formData, int id) async {
    final dataResponse = await _apiClient.postFormData<OrderModel>(
        "${Api.updateOrder}/$id", formData);
    return dataResponse.handleData();
  }

  Future updateOrderStatus(FormData formData, int id) async {
    final dataResponse = await _apiClient.postFormData(
        "${Api.updateOrderStatus}/$id", formData);
    return dataResponse.handleData();
  }
}
