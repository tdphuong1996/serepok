import 'package:serepok/api/api_client.dart';
import 'package:serepok/api/apis.dart';
import 'package:serepok/model/user.dart';

import '../../model/base_response_model.dart';

class AuthRepository {
  final ApiClient _apiClient = ApiClient();

  Future<User> login(Map<String, dynamic> param) async {
    final dataResponse = await _apiClient.post<User>(Api.login, param);
    return dataResponse.handleData();
  }
}
