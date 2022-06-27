import 'package:dio/dio.dart';

import '../model/base_response_model.dart';
import 'pretty_dio_logger.dart';

class ApiClient {
  final Dio _dio = Dio();
  final _baseUrl = 'https://saurieng.vexe.vn/api/';

  ApiClient() {
    BaseOptions options = BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: 3000,
      receiveTimeout: 3000,
    );
    _dio.options = options;
    _dio.interceptors.add(PrettyDioLogger(
        requestHeader: false,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
    _dio.interceptors.add(InterceptorsWrapper(
      onResponse: (response, handler) {
        if (response.statusCode ==200) {
          return handler.resolve(response);
        }else {
          throw Exception("Lõi nè");
        }
      },
    ));
  }

  Future<BaseResponseModel<T>> get<T>(
      String path, Map<String, dynamic> param) async {
    final response = await _dio.get(path, queryParameters: param);
    try {
      BaseResponseModel<T> responseModel =
          BaseResponseModel.fromJson(response.data);
      return responseModel;
    } on Exception catch (e) {
      rethrow;
    }
  }

  Future<BaseResponseModel<T>> post<T>(
      String path, Map<String, dynamic> param) async {
    final response = await _dio.post(path, queryParameters: param);
    try {
      BaseResponseModel<T> responseModel =
          BaseResponseModel.fromJson(response.data);
      return responseModel;
    } on Exception catch (e) {
      print(e);
      rethrow;
    }
  }
}
