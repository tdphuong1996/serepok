import 'package:serepok/model/product_model.dart';

class CreateModel {

  factory CreateModel.fromJson(Map<String, dynamic> json) {
    return CreateModel();
  }

  CreateModel();
}

class OrderModel {
  int id;
  String code;
  int operatorId;
  int customerId;
  String name;
  String phone;
  String address;
  int total;
  int subTotal;
  int profit;
  int status;
  int moneyType;
  int advanceMoney;
  int collectMoney;
  int numberBox;
  String? note;
  String createdAt;
  String updatedAt;
  List<OrderDetail> orderDetails;

  OrderModel({
    required this.id,
    required this.code,
    required this.operatorId,
    required this.customerId,
    required this.name,
    required this.phone,
    required this.address,
    required this.total,
    required this.subTotal,
    required this.profit,
    required this.status,
    required this.moneyType,
    required this.advanceMoney,
    required this.collectMoney,
    required this.numberBox,
    required this.note,
    required this.createdAt,
    required this.updatedAt,
    required this.orderDetails,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    try {
      return OrderModel(
        id: json['id'],
        code: json['code'],
        operatorId: json['operator_id'],
        customerId: json['customer_id'],
        name: json['name'],
        phone: json['phone'],
        address: json['address'],
        total: json['total'],
        subTotal: json['sub_total'],
        profit: json['profit'],
        status: json['status'],
        moneyType: json['money_type'],
        advanceMoney: json['advance_money'],
        collectMoney: json['collect_money'],
        numberBox: json['number_box'],
        note: json['note'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
        orderDetails: List.from(json['order_details'])
            .map((item) => OrderDetail.fromJson(item))
            .toList(),
      );
    } on Exception {
      rethrow;
    }
  }
}

class OrderDetail {
  int id;
  int orderId;
  int productId;
  int price;
  int cost;
  int quantity;
  String createdAt;
  String updatedAt;
  ProductModel product;

  OrderDetail({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.price,
    required this.cost,
    required this.quantity,
    required this.createdAt,
    required this.updatedAt,
    required this.product,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    try {
      return OrderDetail(
        id: json['id'],
        orderId: json['order_id'],
        productId: json['product_id'],
        price: json['price'],
        cost: json['cost'],
        quantity: json['quantity'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
        product: ProductModel.fromJson(json['product']),
      );
    } on Exception {
      rethrow;
    }
  }
}
