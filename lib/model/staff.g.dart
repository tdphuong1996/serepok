// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staff.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StaffListResponse _$StaffListResponseFromJson(Map<String, dynamic> json) =>
    StaffListResponse(
      json['current_page'] as int,
      (json['data'] as List<dynamic>)
          .map((e) => StaffModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['first_page_url'] as String,
      json['from'] as int,
      json['last_page'] as int,
      json['last_page_url'] as String,
      json['next_page_url'] as String,
      json['path'] as String,
      json['per_page'] as int,
      json['prev_page_url'] as String,
      json['to'] as int,
      json['total'] as int,
    );

Map<String, dynamic> _$StaffListResponseToJson(StaffListResponse instance) =>
    <String, dynamic>{
      'current_page': instance.currentPage,
      'data': instance.data,
      'first_page_url': instance.firstPageUrl,
      'from': instance.from,
      'last_page': instance.lastPage,
      'last_page_url': instance.lastPageUrl,
      'next_page_url': instance.nextPageUrl,
      'path': instance.path,
      'per_page': instance.perPage,
      'prev_page_url': instance.prevPageUrl,
      'to': instance.to,
      'total': instance.total,
    };

StaffModel _$StaffModelFromJson(Map<String, dynamic> json) => StaffModel(
      json['id'] as int,
      json['code'] as String,
      json['name'] as String,
      json['email'] as String,
      json['phone'] as String,
      json['avatar'] as String,
      json['operator_id'] as int,
      json['province_id'] as int,
      json['district_id'] as int,
      json['ward_id'] as int,
      json['address'] as String,
      json['status'] as int,
      json['staff_type'] as int,
      DateTime.parse(json['created_at'] as String),
      DateTime.parse(json['updated_at'] as String),
      json['avatar_url'] as int,
    );

Map<String, dynamic> _$StaffModelToJson(StaffModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'avatar': instance.avatar,
      'operator_id': instance.operatorId,
      'province_id': instance.provinceId,
      'district_id': instance.districtId,
      'ward_id': instance.wardId,
      'address': instance.address,
      'status': instance.status,
      'staff_type': instance.staffType,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'avatar_url': instance.avatarUrl,
    };
