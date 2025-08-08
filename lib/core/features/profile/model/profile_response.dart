// To parse this JSON data, do
//
//     final profileResponse = profileResponseFromJson(jsonString);

import 'dart:convert';

ProfileResponse profileResponseFromJson(String str) => ProfileResponse.fromJson(json.decode(str));

String profileResponseToJson(ProfileResponse data) => json.encode(data.toJson());

class ProfileResponse {
  dynamic city;
  dynamic country;
  String? id;
  String? fullName;
  String? email;
  dynamic image;
  String? role;
  bool? isSocialLogin;
  dynamic provider;
  dynamic address;
  dynamic phoneNumber;
  bool? notifications;
  bool? isVerified;
  bool? isBlocked;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  ProfileResponse({
    this.city,
    this.country,
    this.id,
    this.fullName,
    this.email,
    this.image,
    this.role,
    this.isSocialLogin,
    this.provider,
    this.address,
    this.phoneNumber,
    this.notifications,
    this.isVerified,
    this.isBlocked,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) => ProfileResponse(
    city: json["city"],
    country: json["country"],
    id: json["_id"],
    fullName: json["fullName"],
    email: json["email"],
    image: json["image"],
    role: json["role"],
    isSocialLogin: json["isSocialLogin"],
    provider: json["provider"],
    address: json["address"],
    phoneNumber: json["phoneNumber"],
    notifications: json["notifications"],
    isVerified: json["isVerified"],
    isBlocked: json["isBlocked"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "city": city,
    "country": country,
    "_id": id,
    "fullName": fullName,
    "email": email,
    "image": image,
    "role": role,
    "isSocialLogin": isSocialLogin,
    "provider": provider,
    "address": address,
    "phoneNumber": phoneNumber,
    "notifications": notifications,
    "isVerified": isVerified,
    "isBlocked": isBlocked,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
