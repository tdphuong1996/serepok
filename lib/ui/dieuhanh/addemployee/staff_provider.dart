import 'dart:async';

import 'package:serepok/api/repository/staff_repository.dart';
import 'package:serepok/base/base_provider.dart';
import 'package:serepok/model/staff.dart';

class StaffProvider extends BaseProvider {
  final StaffRepository _staffRepository = StaffRepository();
  List<StaffModel> listStaff = [];

  void getListStaff()  {
    showLoading();
    _staffRepository.getListStaff<StaffListResponse>().then(handleDataList).onError(handleError);
  }

  FutureOr handleDataList(StaffListResponse value) async {
    listStaff.addAll(value.data);
    notifyListeners();

    hideLoading();
  }
}