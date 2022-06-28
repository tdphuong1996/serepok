import 'package:serepok/api/api_client.dart';
import 'package:serepok/api/apis.dart';
import 'package:serepok/model/staff.dart';

import '../../model/base_response_model.dart';
import '../../model/paging_respone_model.dart';

class StaffRepository {
  final ApiClient _apiClient = ApiClient();

  Future<PagingResponseModel<StaffModel>> getListStaff() async {
    final dataResponse = await _apiClient.get<PagingResponseModel<StaffModel>>(Api.listStaff);
    return dataResponse.handleData();
  }
}
