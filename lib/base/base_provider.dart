import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BaseProvider with ChangeNotifier {
  BuildContext? context = null;
  int pageNumber = 1;
  bool isRefresh =  false;
  bool isLoadMore =  false;
  bool isCanLoadMore =  false;


  bool isLoading = false;
  String error = "";

  FutureOr handleError(Object error, StackTrace stackTrace) {
    handleErrors(error);
  }

  void handleErrors(Object error) {
    debugPrint('error: $error');
    String message = "";
    if (error is DioError) {
      if (error.response?.data != null) {
        final response = error.response?.data as Map<String, dynamic>;
        message = response["message"] as String;
      } else {
        message = "Có lỗi trong quá trình xử lý, Vui lòng thử lại!";
      }
    } else {
      message = "Có lỗi trong quá trình xử lý, Vui lòng thử lại!";
    }
    hideLoading();
    showAlert(message);

  }

  void showLoading() {
    if(isRefresh || isLoadMore) return;
    EasyLoading.show(status: 'loading...');
  }

  void showAlert(String title, {String titleButton = "Đóng"}) {
    showOkAlertDialog(context: context!, message: title, okLabel: titleButton)
        .then(handleClickOkAlert);
  }

  FutureOr handleClickOkAlert(OkCancelResult value) {}

  void hideLoading() {
    EasyLoading.dismiss();
  }
}
