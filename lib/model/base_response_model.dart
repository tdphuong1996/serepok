import 'package:json_annotation/json_annotation.dart';

import 'user.dart';

part 'base_response_model.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class BaseResponseModel<T> {
  bool result;
  String message;
  @JsonKey(fromJson: _dataFromJson)
  T data;

  BaseResponseModel(this.result, this.message, this.data);

  factory BaseResponseModel.fromJson(Map<String, dynamic> json) =>
      _$BaseResponseModelFromJson<T>(json);

  static T _dataFromJson<T>(Object json) {
    if (json is Map<String, dynamic>) {
      if (T == User) {
        return User.fromJson(json) as T;
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
