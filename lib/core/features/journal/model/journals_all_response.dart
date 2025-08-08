// To parse this JSON data, do
//
//     final journalsAllResponse = journalsAllResponseFromJson(jsonString);

import 'dart:convert';

JournalsAllResponse journalsAllResponseFromJson(String str) => JournalsAllResponse.fromJson(json.decode(str));

String journalsAllResponseToJson(JournalsAllResponse data) => json.encode(data.toJson());

class JournalsAllResponse {
  String? id;
  String? reflection;
  String? goals;
  String? challenges;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  JournalsAllResponse({
    this.id,
    this.reflection,
    this.goals,
    this.challenges,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory JournalsAllResponse.fromJson(Map<String, dynamic> json) => JournalsAllResponse(
    id: json["_id"],
    reflection: json["reflection"],
    goals: json["goals"],
    challenges: json["challenges"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "reflection": reflection,
    "goals": goals,
    "challenges": challenges,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
