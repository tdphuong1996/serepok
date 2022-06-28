class User {
  String name;
  String token;

  User(this.name, this.token);

  factory User.fromJson(Map<String, dynamic> json) {
    try {
      return User(json["name"], json['token']);
    } on Exception {
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'token': token};
  }
}
