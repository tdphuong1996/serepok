import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:async';

class BaseProvider with ChangeNotifier {
  bool isLoading = false;
  String error = "";

  FutureOr handleError(Object error, StackTrace stackTrace) {
    hideLoading();
  }

  void showLoading() {
    EasyLoading.show(status: 'loading...');
  }

  void hideLoading() {
    EasyLoading.dismiss();
  }
}
