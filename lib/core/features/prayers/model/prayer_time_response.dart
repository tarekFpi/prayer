// To parse this JSON data, do
//
//     final prayerTimeResponse = prayerTimeResponseFromJson(jsonString);

import 'dart:convert';

PrayerTimeResponse prayerTimeResponseFromJson(String str) => PrayerTimeResponse.fromJson(json.decode(str));

String prayerTimeResponseToJson(PrayerTimeResponse data) => json.encode(data.toJson());

class PrayerTimeResponse {
  String? id;
  DateTime? date;
  String? auth;
  int? v;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Prayer>? prayers;

  PrayerTimeResponse({
    this.id,
    this.date,
    this.auth,
    this.v,
    this.createdAt,
    this.updatedAt,
    this.prayers,
  });

  factory PrayerTimeResponse.fromJson(Map<String, dynamic> json) => PrayerTimeResponse(
    id: json["_id"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    auth: json["auth"],
    v: json["__v"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    prayers: json["prayers"] == null ? [] : List<Prayer>.from(json["prayers"]!.map((x) => Prayer.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "date": date?.toIso8601String(),
    "auth": auth,
    "__v": v,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "prayers": prayers == null ? [] : List<dynamic>.from(prayers!.map((x) => x.toJson())),
  };
}

class Prayer {
  String? name;
  String? time;
  bool? isComplete;

  Prayer({
    this.name,
    this.time,
    this.isComplete,
  });

  factory Prayer.fromJson(Map<String, dynamic> json) => Prayer(
    name: json["name"],
    time: json["time"],
    isComplete: json["isComplete"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "time": time,
    "isComplete": isComplete,
  };
}
