// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponseModel<T> _$BaseResponseModelFromJson<T>(
  Map<String, dynamic> json,
) =>
    BaseResponseModel<T>(
      json['result'] as bool,
      json['message'] as String,
      BaseResponseModel._dataFromJson(json['data'] as Object),
    );

Map<String, dynamic> _$BaseResponseModelToJson<T>(
  BaseResponseModel<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'result': instance.result,
      'message': instance.message,
      'data': toJsonT(instance.data),
    };
