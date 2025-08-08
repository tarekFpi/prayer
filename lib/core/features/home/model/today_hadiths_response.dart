// To parse this JSON data, do
//
//     final todayHadithsResponse = todayHadithsResponseFromJson(jsonString);

import 'dart:convert';

TodayHadithsResponse todayHadithsResponseFromJson(String str) => TodayHadithsResponse.fromJson(json.decode(str));

String todayHadithsResponseToJson(TodayHadithsResponse data) => json.encode(data.toJson());

class TodayHadithsResponse {
  String? id;
  DateTime? date;
  String? source;
  String? content;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  TodayHadithsResponse({
    this.id,
    this.date,
    this.source,
    this.content,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory TodayHadithsResponse.fromJson(Map<String, dynamic> json) => TodayHadithsResponse(
    id: json["_id"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    source: json["source"],
    content: json["content"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "date": date?.toIso8601String(),
    "source": source,
    "content": content,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
