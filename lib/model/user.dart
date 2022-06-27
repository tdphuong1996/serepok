
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';
@JsonSerializable()
class User {
  String name;
  @JsonKey(name: "province_id")
  int provinceId;
  String token;


  User(this.name, this.provinceId, this.token);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);


}
