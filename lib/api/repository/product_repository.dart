import 'package:dio/dio.dart';
import 'package:serepok/api/api_client.dart';
import 'package:serepok/api/apis.dart';
import 'package:serepok/model/staff.dart';
import 'package:serepok/model/user.dart';

import '../../model/base_response_model.dart';
import '../../model/paging_respone_model.dart';
import '../../model/product_model.dart';

class ProductRepository {
  final ApiClient _apiClient = ApiClient();

  Future<PagingResponseModel<ProductModel>> getListProduct(
      int pageNumber) async {
    final dataResponse = await _apiClient
        .get<PagingResponseModel<ProductModel>>(Api.createProduct,
            param: {'page': pageNumber});
    return dataResponse.handleData();
  }

  Future<ProductModel> createProduct(FormData formData) async {
    final dataResponse = await _apiClient.postFormData<ProductModel>(
        Api.createProduct, formData);
    return dataResponse.handleData();
  }

  Future<ProductModel> updateProduct(FormData formData, int id) async {
    final dataResponse = await _apiClient.postFormData<ProductModel>(
        "${Api.updateProduct}/$id", formData);
    return dataResponse.handleData();
  }
}
