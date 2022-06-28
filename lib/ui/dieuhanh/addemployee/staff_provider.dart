import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:serepok/api/repository/staff_repository.dart';
import 'package:serepok/base/base_provider.dart';
import 'package:serepok/model/base_response_model.dart';
import 'package:serepok/model/paging_respone_model.dart';
import 'package:serepok/model/staff.dart';

import '../../../model/user.dart';
import 'add_employee_screen.dart';

class StaffProvider extends BaseProvider {
  final StaffRepository _staffRepository = StaffRepository();
  List<StaffModel> listStaff = [];
  Function? createStaffSuccessCallback ;
  void getListStaff() {
    showLoading();
    _staffRepository.getListStaff().then(handleDataList).onError(handleError);
  }

  FutureOr handleDataList(PagingResponseModel<StaffModel> data) async {
    listStaff.addAll(data.data);
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
    var formData = FormData.fromMap({
      'name': name,
      'phone': phone,
      'status': 0,
      'email': email,
      'password': password,
      'staff_type': role == Role.SELL ? 1 : 2,
      'avatar': await MultipartFile.fromFile(image!.path,
          filename: "avatar_${DateTime.now().millisecondsSinceEpoch}.jpg")
    });
    _staffRepository.createStaff(formData).then(createStaffSuccess).onError(handleError);

  }

  void dispose() {
    listStaff = [];
  }

  FutureOr createStaffSuccess(User value) {
    showAlert('Tạo nhân viên thành công');
    createStaffSuccessCallback?.call();
    hideLoading();

  }
}
