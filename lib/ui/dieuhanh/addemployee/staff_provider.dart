import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:serepok/api/repository/staff_repository.dart';
import 'package:serepok/base/base_provider.dart';
import 'package:serepok/model/base_response_model.dart';
import 'package:serepok/model/paging_respone_model.dart';
import 'package:serepok/model/staff.dart';

import 'add_employee_screen.dart';

class StaffProvider extends BaseProvider {
  final StaffRepository _staffRepository = StaffRepository();
  List<StaffModel> listStaff = [];
  int lastPage = 0;
  Function? createStaffSuccessCallback;
  Function? updateStaffSuccessCallback;

  Future<void> getListStaff() async {
    showLoading();
    try {
      final response = await _staffRepository.getListStaff(pageNumber);
      handleDataList(response);
      hideLoading();
    } on Exception catch (error) {
      handleErrors(error);
    }
  }

  void handleDataList(PagingResponseModel<StaffModel> data) {
    if (isRefresh) {
      isRefresh = false;
      listStaff.clear();
    }
    listStaff.addAll(data.data);
    lastPage = data.lastPage;
    isCanLoadMore = pageNumber < lastPage;
    notifyListeners();
    hideLoading();
  }

  void createStaff(String name, String phone, String email, String password,
      String repassword, Role? role, File? image) async {
    String message = "";
    if (name.isEmpty ||
        phone.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        repassword.isEmpty ||
        role == null) {
      message = "Vui lòng nhập đầy đủ thông tin";
    } else if (password != repassword) {
      message = "Mật khẩu nhập lại không chính xác";
    }
    if (message.isNotEmpty) {
      showAlert(message);
      return;
    }
    showLoading();
    MultipartFile? avatar;
    if (image != null) {
      avatar = await MultipartFile.fromFile(image.path,
          filename: "avatar_${DateTime.now().millisecondsSinceEpoch}.jpg");
    } else {
      avatar = null;
    }
    var formData = FormData.fromMap({
      'name': name,
      'phone': phone,
      'status': 0,
      'email': email,
      'password': password,
      'staff_type': role == Role.SELL ? 1 : 2,
      'avatar': avatar
    });
    _staffRepository
        .createStaff(formData)
        .then(createStaffSuccess)
        .onError(handleError);
  }

  void updateStaff(int staffId, String name, String phone, String email,
      Role? role, File? image) async {
    String message = "";
    if (name.isEmpty || phone.isEmpty || email.isEmpty || role == null) {
      message = "Vui lòng nhập đầy đủ thông tin";
    }
    if (message.isNotEmpty) {
      showAlert(message);
      return;
    }
    showLoading();
    MultipartFile? avatar;
    if (image != null) {
      avatar = await MultipartFile.fromFile(image.path,
          filename: "avatar_${DateTime.now().millisecondsSinceEpoch}.jpg");
    } else {
      avatar = null;
    }
    var formData = FormData.fromMap({
      'name': name,
      'phone': phone,
      'status': 0,
      'email': email,
      'staff_type': role == Role.SELL ? 1 : 2,
      'avatar': await MultipartFile.fromFile(image!.path,
          filename: "avatar_${DateTime.now().millisecondsSinceEpoch}.jpg")
    });
    _staffRepository
        .updateStaff(formData, staffId)
        .then(updateStaffSuccess)
        .onError(handleError);
  }

  void dispose() {
    listStaff = [];
  }

  FutureOr createStaffSuccess(StaffModel value) {
    showAlert('Tạo nhân viên thành công');
    createStaffSuccessCallback?.call();
    hideLoading();
  }

  FutureOr updateStaffSuccess(StaffModel value) {
    showAlert('Cập nhật nhân viên thành công');
    updateStaffSuccessCallback?.call();
    hideLoading();
  }
}
