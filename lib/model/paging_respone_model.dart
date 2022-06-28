import 'package:serepok/model/staff.dart';

class PagingResponseModel<T> {
  int lastPage;
  int total;
  List<T> data;

  PagingResponseModel(
      {required this.data, required this.lastPage, required this.total});

  factory PagingResponseModel.fromJson(Map<String, dynamic> json) {
    try {
      return PagingResponseModel<T>(
          lastPage: json["last_page"],
          total: json["total"],
          data: _listDataFromJson<T>(json['data']));
    } on Exception catch (e) {
      rethrow;
    }
  }

  static List<T> _listDataFromJson<T>(Object json) {
    if (json is List<dynamic>) {
      if (T == StaffModel) {
        return List.from(json.map((e) => StaffModel.fromJson(e)).toList());
      }
    }

    throw ArgumentError.value(
      json,
      'json',
      'Cannot convert the provided data.',
    );
  }
}
