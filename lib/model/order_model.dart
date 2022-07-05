import 'package:serepok/model/product_model.dart';

class OrderModel{
  int id;
  String code;
  int operatorId;
  String customerId;
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
  String note;
  DateTime createdAt;
  DateTime updatedAt;
  List<OrderDetail> orderDetails;

  OrderModel(
  {
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
    required this.note,
    required this.createdAt,
    required this.updatedAt,
    required this.orderDetails,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json){
    try{
      return OrderModel(
        id: json['id'],
        code: json['code'],
        operatorId: json['cooperator_id'],
        customerId: json['customer_id'],
        name: json['name'],
        phone: json['phone'],
        address: json['address'],
        total: json['total'],
        subTotal: json['subTotal'],
        profit: json['profit'],
        status: json['status'],
        moneyType: json['money_type'],
        advanceMoney: json['advance_money'],
        collectMoney: json['collect_money'],
        note: json['note'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
        orderDetails: json['order_details'],
      );
    }on Exception {
      rethrow;
    }
  }
}

class OrderDetail{
  int id;
  int orderId;
  int productId;
  int price;
  int cost;
  int quantity;
  DateTime createdAt;
  DateTime updatedAt;
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

  factory OrderDetail.fromJson(Map<String, dynamic> json){
    try{
      return OrderDetail(
        id: json['id'],
        orderId: json['order_id'],
        productId: json['product_id'],
        price: json['price'],
        cost: json['cost'],
        quantity: json['quantity'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
        product: json['product'],
      );
    }on Exception {
      rethrow;
    }
  }
}