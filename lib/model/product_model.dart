class ProductModel {
  int id;
  int price;
  int cost;
  String code;
  String unit;
  String name;
  String gardenName;
  String location;
  String species;
  String description;
  String imageUrl;

  ProductModel(
      {required this.id,
      required this.price,
      required this.cost,
      required this.code,
      required this.unit,
      required this.name,
      required this.gardenName,
      required this.location,
      required this.species,
      required this.description,
      required this.imageUrl});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    try {
      return ProductModel(
        id: json['id'],
        price: json['price'],
        cost: json['cost'],
        unit: json['unit'],
        name: json['name'],
        code: json['code'],
        gardenName: json['garden_name'],
        location: json['location'],
        species: json['species'],
        description: json['description'],
        imageUrl: json['image_url'],
      );
    } on Exception {
      rethrow;
    }
  }
}
