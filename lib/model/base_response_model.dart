import 'dart:math';

import 'package:serepok/model/order_model.dart';
import 'package:serepok/model/paging_respone_model.dart';
import 'package:serepok/model/staff.dart';

import 'address_model.dart';
import 'product_model.dart';
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
      }else if (T == PagingResponseModel<ProductModel>) {
        return PagingResponseModel<ProductModel>.fromJson(json) as T;
      }
      else if (T == PagingResponseModel<OrderModel>) {
        return PagingResponseModel<OrderModel>.fromJson(json) as T;
      }
      else if (T == StaffModel) {
        return StaffModel.fromJson(json) as T;
      }else if (T == ProductModel) {
        return ProductModel.fromJson(json) as T;
      }
      else if (T == OrderModel) {
        return OrderModel.fromJson(json) as T;
      }
      else if (T == CreateModel) {
        return CreateModel.fromJson(json) as T;
      }
    }else if (json is List){
      if (T == List<CreateModel>) {
      List<CreateModel> list = [];
      return list as T;
      }
      else if (T == List<ProvinceModel>) {
        List<ProvinceModel> list = List.from(json)
            .map((item) => ProvinceModel.fromJson(item))
            .toList();
        return list as T;
      }
      else if (T == List<DistrictModel>) {
        List<DistrictModel> list = List.from(json)
            .map((item) => DistrictModel.fromJson(item))
            .toList();
        return list as T;
      }
      else if (T == List<WardModel>) {
        List<WardModel> list = List.from(json)
            .map((item) => WardModel.fromJson(item))
            .toList();
        return list as T;
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
