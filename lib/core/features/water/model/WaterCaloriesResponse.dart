// To parse this JSON data, do
//
//     final waterCaloriesResponse = waterCaloriesResponseFromJson(jsonString);

import 'dart:convert';

WaterCaloriesResponse waterCaloriesResponseFromJson(String str) => WaterCaloriesResponse.fromJson(json.decode(str));

String waterCaloriesResponseToJson(WaterCaloriesResponse data) => json.encode(data.toJson());

class WaterCaloriesResponse {
  String? id;
  String? user;
  dynamic? water;
  dynamic? step;
  dynamic? calories;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  WaterCaloriesResponse({
    this.id,
    this.user,
    this.water,
    this.step,
    this.calories,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory WaterCaloriesResponse.fromJson(Map<String, dynamic> json) => WaterCaloriesResponse(
    id: json["_id"],
    user: json["user"],
    water: json["water"],
    step: json["step"],
    calories: json["calories"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "user": user,
    "water": water,
    "step": step,
    "calories": calories,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
