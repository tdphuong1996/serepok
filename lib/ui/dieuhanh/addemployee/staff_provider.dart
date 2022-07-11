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
      String repassword, List<Role>? listRole, File? image) async {
    String message = "";
    if (name.isEmpty ||
        phone.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        repassword.isEmpty ||
        listRole == null) {
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
    List<int>? listType;
    if (listRole?.contains(Role.SELL) == true){
      listType?.add(1);
    }
    if (listRole?.contains(Role.SHIPPER) == true){
      listType?.add(2);
    }
    var formData = FormData.fromMap({
      'name': name,
      'phone': phone,
      'status': 0,
      'email': email,
      'password': password,
      'roles': listType,
      'avatar': avatar
    });
    _staffRepository
        .createStaff(formData)
        .then(createStaffSuccess)
        .onError(handleError);
  }

  void updateStaff(int staffId, String name, String phone, String email,
      List<Role>? listRole, File? image) async {
    String message = "";
    if (name.isEmpty || phone.isEmpty || email.isEmpty || listRole == null) {
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
    List<int>? listType;
    if (listRole?.contains(Role.SELL) == true){
      listType?.add(1);
    }
    if (listRole?.contains(Role.SHIPPER) == true){
      listType?.add(2);
    }
    var formData = FormData.fromMap({
      'name': name,
      'phone': phone,
      'status': 0,
      'email': email,
      'roles': listType,
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
    updateStaffSuccessCallback?.call();
    hideLoading();
  }
}
