import 'package:serepok/api/api_client.dart';
import 'package:serepok/api/apis.dart';
import 'package:serepok/model/staff.dart';

import '../../model/base_response_model.dart';

class StaffRepository{
  final ApiClient _apiClient = ApiClient();

  Future<StaffListResponse> getListStaff<StaffListResponse>() async {
    final dataResponse = await _apiClient.get<StaffListResponse>(Api.listStaff, {});
    return dataResponse.handleData();
  }
}