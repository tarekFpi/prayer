// To parse this JSON data, do
//
//     final fitnessResponse = fitnessResponseFromJson(jsonString);

import 'dart:convert';

FitnessResponse fitnessResponseFromJson(String str) => FitnessResponse.fromJson(json.decode(str));

String fitnessResponseToJson(FitnessResponse data) => json.encode(data.toJson());

class FitnessResponse {
  String? user;
  Calculation? calculation;
  List<History>? history;

  FitnessResponse({
    this.user,
    this.calculation,
    this.history,
  });

  factory FitnessResponse.fromJson(Map<String, dynamic> json) => FitnessResponse(
    user: json["user"],
    calculation: json["calculation"] == null ? null : Calculation.fromJson(json["calculation"]),
    history: json["history"] == null ? [] : List<History>.from(json["history"]!.map((x) => History.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "user": user,
    "calculation": calculation?.toJson(),
    "history": history == null ? [] : List<dynamic>.from(history!.map((x) => x.toJson())),
  };
}

class Calculation {
  int? totalStep;
  double? totalWater;
  int? totalCalories;

  Calculation({
    this.totalStep,
    this.totalWater,
    this.totalCalories,
  });

  factory Calculation.fromJson(Map<String, dynamic> json) => Calculation(
    totalStep: json["totalStep"],
    totalWater: json["totalWater"]?.toDouble(),
    totalCalories: json["totalCalories"],
  );

  Map<String, dynamic> toJson() => {
    "totalStep": totalStep,
    "totalWater": totalWater,
    "totalCalories": totalCalories,
  };
}

class History {
  String? id;
  DateTime? date;
  String? day;
  int? calories;
  int? step;
  double? water;

  History({
    this.id,
    this.date,
    this.day,
    this.calories,
    this.step,
    this.water,
  });

  factory History.fromJson(Map<String, dynamic> json) => History(
    id: json["_id"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    day: json["day"],
    calories: json["calories"],
    step: json["step"],
    water: json["water"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "date": date?.toIso8601String(),
    "day": day,
    "calories": calories,
    "step": step,
    "water": water,
  };
}
