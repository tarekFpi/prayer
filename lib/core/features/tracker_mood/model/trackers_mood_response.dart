// To parse this JSON data, do
//
//     final trackersMoodResponse = trackersMoodResponseFromJson(jsonString);

import 'dart:convert';

TrackersMoodResponse trackersMoodResponseFromJson(String str) => TrackersMoodResponse.fromJson(json.decode(str));

String trackersMoodResponseToJson(TrackersMoodResponse data) => json.encode(data.toJson());

class TrackersMoodResponse {
  final String? id;
  final String? auth;
  final DateTime? date;
  final int? v;
  final String? description;
  final String? title;

  TrackersMoodResponse({
    this.id,
    this.auth,
    this.date,
    this.v,
    this.description,
    this.title,
  });

  factory TrackersMoodResponse.fromJson(Map<String, dynamic> json) => TrackersMoodResponse(
    id: json["_id"],
    auth: json["auth"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    v: json["__v"],
    description: json["description"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "auth": auth,
    "date": date?.toIso8601String(),
    "__v": v,
    "description": description,
    "title": title,
  };
}
