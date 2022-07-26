class ProvinceModel {
  int id;
  String name;

  ProvinceModel({
    required this.id,
    required this.name,
  });

  factory ProvinceModel.fromJson(Map<String, dynamic> json) {
    try {
      return ProvinceModel(id: json['id'],
        name: json['name'],);
    } on Exception {
      rethrow;
    }

  }
}

class DistrictModel {
  int id;
  int provinceId;
  String name;

  DistrictModel({
    required this.id,
    required this.provinceId,
    required this.name,
  });

  factory DistrictModel.fromJson(Map<String, dynamic> json) {
    try {
      return DistrictModel(
        id: json['id'],
        provinceId: json['province_id'],
        name: json['name'],);
    } on Exception {
      rethrow;
    }
  }
}

class WardModel {
  int id;
  int provinceId;
  int districtId;
  String name;

  WardModel({
    required this.id,
    required this.provinceId,
    required this.districtId,
    required this.name,
  });

  factory WardModel.fromJson(Map<String, dynamic> json) {
    try {
      return WardModel(
        id: json['id'],
        provinceId: json['province_id'],
        districtId: json['district_id'],
        name: json['name'],);
    } on Exception {
      rethrow;
    }
  }
}