
class StaffModel {
  int id;
  String name;
  String email;
  String phone;
  String avatarUrl;
  int staffType;

  StaffModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.phone,
      required this.avatarUrl,
      required this.staffType});

  factory StaffModel.fromJson(Map<String, dynamic> json) {
    try {
      return StaffModel(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
        avatarUrl: json['avatar_url'],
        staffType: json['staff_type'],
      );
    } on Exception {
      rethrow;
    }
  }
}
