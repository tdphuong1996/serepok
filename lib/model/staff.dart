class StaffModel {
  int id;
  String name;
  String email;
  String phone;
  String avatarUrl;
  int staffType;
  List<RoleModel>? roles;

  StaffModel({required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.avatarUrl,
    required this.staffType,
    required this.roles});

  factory StaffModel.fromJson(Map<String, dynamic> json) {
    try {
      return StaffModel(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
        avatarUrl: json['avatar_url'],
        staffType: json['staff_type'],
        roles: List.from(json['roles'])
            .map((item) => RoleModel.fromJson(item))
            .toList(),
      );
    } on Exception {
      rethrow;
    }
  }
}

class RoleModel {
  int id;
  String name;

  RoleModel({
    required this.id,
    required this.name,
  });

  factory RoleModel.fromJson(Map<String, dynamic> json){
    try {
      return RoleModel(
        id: json['id'],
        name: json['name']
      );
    } on Exception {
      rethrow;
    }
  }
}
