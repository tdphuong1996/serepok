import 'package:serepok/api/api_client.dart';
import 'package:serepok/api/apis.dart';

import '../../model/base_response_model.dart';

class AuthRepository {
  final ApiClient _apiClient = ApiClient();

  Future<T> login<T>(Map<String, dynamic> param) async {
    final dataResponse = await _apiClient.post<T>(Api.login, param);
    return dataResponse.handleData();
  }

}
