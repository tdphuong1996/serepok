import 'package:json_annotation/json_annotation.dart';

part 'staff.g.dart';

@JsonSerializable()
class StaffListResponse {
  @JsonKey(name: "current_page")
  int currentPage;
  List<StaffModel> data;
  @JsonKey(name: "first_page_url")
  String firstPageUrl;
  int from;
  @JsonKey(name: "last_page")
  int lastPage;
  @JsonKey(name: "last_page_url")
  String lastPageUrl;
  @JsonKey(name: "next_page_url")
  String nextPageUrl;
  String path;
  @JsonKey(name: "per_page")
  int perPage;
  @JsonKey(name: "prev_page_url")
  String prevPageUrl;
  int to;
  int total;

  StaffListResponse(this.currentPage, this.data, this.firstPageUrl, this.from,
      this
          .lastPage, this.lastPageUrl, this.nextPageUrl, this.path,
      this.perPage, this.prevPageUrl, this.to, this.total);

  factory StaffListResponse.fromJson(Map<String, dynamic> json) =>
      _$StaffListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StaffListResponseToJson(this);
}

@JsonSerializable()
class StaffModel {
  int id;
  String code;
  String name;
  String email;
  String phone;
  String avatar;
  @JsonKey(name: "operator_id")
  int operatorId;
  @JsonKey(name: "province_id")
  int provinceId;
  @JsonKey(name: "district_id")
  int districtId;
  @JsonKey(name: "ward_id")
  int wardId;
  String address;
  int status;
  @JsonKey(name: "staff_type")
  int staffType;
  @JsonKey(name: "created_at")
  DateTime createdAt;
  @JsonKey(name: "updated_at")
  DateTime updatedAt;
  @JsonKey(name: "avatar_url")
  int avatarUrl;

  StaffModel(this.id, this.code, this.name, this.email, this.phone, this.avatar,
      this.operatorId, this.provinceId, this.districtId, this.wardId,
      this.address, this.status, this.staffType, this.createdAt, this.updatedAt,
      this.avatarUrl);

  factory StaffModel.fromJson(Map<String, dynamic> json) =>
      _$StaffModelFromJson(json);

  Map<String, dynamic> toJson() => _$StaffModelToJson(this);
}