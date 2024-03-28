import 'dart:convert';

import 'package:store_ui/Models/product_model.dart';

OrderModel orderModelFromJson(String str) =>
    OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  OrderModel({
    required this.success,
    required this.data,
  });

  bool success;
  Data data;

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        success: json["success"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.orders,
  });

  List<Order> orders;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        orders: List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "orders": List<dynamic>.from(orders.map((x) => x.toJson())),
      };
}

class Order {
  Order({
    required this.id,
    required this.status,
    this.deliveredAt,
    required this.note,
    required this.cartId,
    this.canceledReason,
    this.cancelledBy,
    this.cancelledAt,
    required this.userId,
    required this.finalTotal,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.products,
  });

  int id;
  Status status;
  dynamic deliveredAt;
  String note;
  int cartId;
  dynamic canceledReason;
  dynamic cancelledBy;
  dynamic cancelledAt;
  int userId;
  int finalTotal;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  List<Product> products;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        status: statusValues.map[json["status"]]!,
        deliveredAt: json["deliveredAt"],
        note: json["note"],
        cartId: json["cartId"],
        canceledReason: json["canceledReason"],
        cancelledBy: json["cancelledBy"],
        cancelledAt: json["cancelledAt"],
        userId: json["userId"],
        finalTotal: json["finalTotal"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": statusValues.reverse[status],
        "deliveredAt": deliveredAt,
        "note": note,
        "cartId": cartId,
        "canceledReason": canceledReason,
        "cancelledBy": cancelledBy,
        "cancelledAt": cancelledAt,
        "userId": userId,
        "finalTotal": finalTotal,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "deletedAt": deletedAt,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

class OrdersItem {
  OrdersItem({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.quantity,
    required this.total,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  int id;
  int orderId;
  int productId;
  int quantity;
  int total;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  factory OrdersItem.fromJson(Map<String, dynamic> json) => OrdersItem(
        id: json["id"],
        orderId: json["orderId"],
        productId: json["productId"],
        quantity: json["quantity"],
        total: json["total"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "orderId": orderId,
        "productId": productId,
        "quantity": quantity,
        "total": total,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "deletedAt": deletedAt,
      };
}

// ignore: constant_identifier_names
enum Status { PENDING }

final statusValues = EnumValues({"pending": Status.PENDING});

class EnumValues<T> {
  EnumValues(this.map);

  final Map<String, T> map;
  Map<T, String>? _reverseMap;

  Map<T, String> get reverse {
    _reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return _reverseMap!;
  }
}
