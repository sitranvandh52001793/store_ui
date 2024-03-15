// To parse this JSON data, do
//
//     final UserModel = UserModelFromJson(jsonString);

import 'dart:convert';

// ignore: non_constant_identifier_names
UserModel UserModelFromJson(String str) => UserModel.fromJson(json.decode(str));

// ignore: non_constant_identifier_names
String UserModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  Profile? profile;

  UserModel({
    this.profile,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        profile: Profile.fromJson(json["profile"]),
      );

  Map<String, dynamic> toJson() => {
        "profile": profile?.toJson(),
      };
}

class Profile {
  int? id;
  String? name;
  String? email;
  dynamic avatar;
  bool? verified;
  String? role;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Address>? address;

  Profile({
    this.id,
    this.name,
    this.email,
    this.avatar,
    this.verified,
    this.role,
    this.createdAt,
    this.updatedAt,
    this.address,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        avatar: json["avatar"],
        verified: json["verified"],
        role: json["role"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        address:
            List<Address>.from(json["address"].map((x) => Address.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "avatar": avatar,
        "verified": verified,
        "role": role,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "address": List<dynamic>.from(address!.map((x) => x.toJson())),
      };
}

class Address {
  int? id;
  String? phone;
  String? province;
  dynamic district;
  dynamic village;
  String? shortDescription;
  DateTime? createdAt;
  DateTime? updatedAt;

  Address({
    this.id,
    this.phone,
    this.province,
    this.district,
    this.village,
    this.shortDescription,
    this.createdAt,
    this.updatedAt,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        phone: json["phone"],
        province: json["province"],
        district: json["district"],
        village: json["village"],
        shortDescription: json["shortDescription"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "phone": phone,
        "province": province,
        "district": district,
        "village": village,
        "shortDescription": shortDescription,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
