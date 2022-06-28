import 'dart:async';

import 'package:serepok/api/repository/staff_repository.dart';
import 'package:serepok/base/base_provider.dart';
import 'package:serepok/model/base_response_model.dart';
import 'package:serepok/model/paging_respone_model.dart';
import 'package:serepok/model/staff.dart';

class StaffProvider extends BaseProvider {
  final StaffRepository _staffRepository = StaffRepository();
  List<StaffModel> listStaff = [];

  void getListStaff() {
    showLoading();
    _staffRepository.getListStaff().then(handleDataList).onError(handleError);
  }

  FutureOr handleDataList(PagingResponseModel<StaffModel> data) async {
    listStaff.addAll(data.data);
    notifyListeners();
    hideLoading();
  }
}
