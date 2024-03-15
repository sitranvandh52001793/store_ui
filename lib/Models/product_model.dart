// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  Data? data;

  ProductModel({
    this.data,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  List<Product>? products;
  Pagination? pagination;

  Data({
    this.products,
    this.pagination,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
        pagination: Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "products": List<dynamic>.from(products!.map((x) => x.toJson())),
        "pagination": pagination!.toJson(),
      };
}

class Pagination {
  int? page;
  int? limit;
  int? pageSize;

  Pagination({
    this.page,
    this.limit,
    this.pageSize,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        page: json["page"],
        limit: json["limit"],
        pageSize: json["page_size"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "limit": limit,
        "page_size": pageSize,
      };
}

class Product {
  int? id;
  String? name;
  String? photo;
  String? description;
  String? specification;
  int? price;
  int? promotionPrice;
  int? sold;
  int? categoryId;
  int? brandId;
  DateTime? createdAt;
  DateTime? updatedAt;
  Brand? category;
  Brand? brand;
  List<dynamic>? totalStar;

  Product({
    this.id,
    this.name,
    this.photo,
    this.description,
    this.specification,
    this.price,
    this.promotionPrice,
    this.sold,
    this.categoryId,
    this.brandId,
    this.createdAt,
    this.updatedAt,
    this.category,
    this.brand,
    this.totalStar,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        photo: json["photo"],
        description: json["description"],
        specification: json["specification"],
        price: json["price"],
        promotionPrice: json["promotionPrice"],
        sold: json["sold"],
        categoryId: json["categoryId"],
        brandId: json["brandId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        category: Brand.fromJson(json["category"]),
        brand: Brand.fromJson(json["brand"]),
        totalStar: List<dynamic>.from(json["total_star"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "photo": photo,
        "description": description,
        "specification": specification,
        "price": price,
        "promotionPrice": promotionPrice,
        "sold": sold,
        "categoryId": categoryId,
        "brandId": brandId,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "category": category!.toJson(),
        "brand": brand!.toJson(),
        "total_star": List<dynamic>.from(totalStar!.map((x) => x)),
      };
}

class Brand {
  String? name;

  Brand({
    this.name,
  });

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
