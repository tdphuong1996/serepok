import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:serepok/api/repository/staff_repository.dart';
import 'package:serepok/base/base_provider.dart';
import 'package:serepok/model/paging_respone_model.dart';
import 'package:serepok/model/staff.dart';

import '../../../model/user.dart';

class ProductProvider extends BaseProvider {
  final StaffRepository _staffRepository = StaffRepository();
  List<StaffModel> listStaff = [];
  Function? createStaffSuccessCallback;

  void getListStaff() {
    showLoading();
    _staffRepository.getListStaff().then(handleDataList).onError(handleError);
  }

  String text = "";

  void getText() {
    Future.delayed(
      const Duration(seconds: 4),
      () {
        text = "12344";
        notifyListeners();
      },
    );
  }

  FutureOr handleDataList(PagingResponseModel<StaffModel> data) async {
    listStaff.addAll(data.data);
    notifyListeners();
    hideLoading();
  }
  void createProduct() {
    showLoading();
  }

  void createStaff(String name, String phone, String email, String password,
      String repassword, File? image) async {
    String message = "";
    if (name.isEmpty ||
        phone.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        repassword.isEmpty) {
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
      'staff_type': 1,
      'avatar': await MultipartFile.fromFile(image!.path,
          filename: "avatar_${DateTime.now().millisecondsSinceEpoch}.jpg")
    });
    _staffRepository
        .createStaff(formData)
        .then(createStaffSuccess)
        .onError(handleError);
  }

  FutureOr createStaffSuccess(User value) {
    showAlert('Tạo nhân viên thành công');
    createStaffSuccessCallback?.call();
    hideLoading();
  }
}
