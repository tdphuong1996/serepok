import 'dart:math';

import 'package:serepok/model/paging_respone_model.dart';
import 'package:serepok/model/staff.dart';

import 'user.dart';

class BaseResponseModel<T> {
  bool result;
  String message;
  T data;

  BaseResponseModel(
      {required this.result, required this.message, required this.data});

  factory BaseResponseModel.fromJson(Map<String, dynamic> json) {
    try {
      return BaseResponseModel<T>(
          result: json["result"] as bool,
          message: json["message"] as String,
          data: _dataFromJson(json["data"]));
    } on Exception catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  static T _dataFromJson<T>(Object json) {
    if (json is Map<String, dynamic>) {

      if (T == User) {
        return User.fromJson(json) as T;
      } else if (T == PagingResponseModel<StaffModel>) {
        return PagingResponseModel<StaffModel>.fromJson(json) as T;
      }
    }

    throw ArgumentError.value(
      json,
      'json',
      'Cannot convert the provided data.',
    );
  }
}

extension handleDataResponse on BaseResponseModel {
  dynamic handleData() {
    if (result) {
      return data;
    } else {
      throw Exception(message);
    }
  }
}
