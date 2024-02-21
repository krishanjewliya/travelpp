// To parse this JSON data, do
//
//     final expensisLatLngtModel = expensisLatLngtModelFromJson(jsonString);

import 'dart:convert';

ExpensisLatLngtModel expensisLatLngtModelFromJson(String str) => ExpensisLatLngtModel.fromJson(json.decode(str));

String expensisLatLngtModelToJson(ExpensisLatLngtModel data) => json.encode(data.toJson());

class ExpensisLatLngtModel {
  String? status;
  List<ExpensisDatalatitute>? data;
  String? message;

  ExpensisLatLngtModel({
     this.status,
     this.data,
     this.message,
  });

  factory ExpensisLatLngtModel.fromJson(Map<String, dynamic> json) => ExpensisLatLngtModel(
    status: json["status"],
    data: List<ExpensisDatalatitute>.from(json["data"].map((x) => ExpensisDatalatitute.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
  };
}

class ExpensisDatalatitute {
  int? id;
  String? tripName;
  int? amount;
  String? latitude;
  String? currency;
  String? longitude;
  String? category;

  ExpensisDatalatitute({
     this.id,
     this.tripName,
     this.amount,
     this.currency,
     this.latitude,
     this.longitude,
     this.category,
  });

  factory ExpensisDatalatitute.fromJson(Map<String, dynamic> json) => ExpensisDatalatitute(
    id: json["id"],
    tripName: json["trip_name"],
    amount: json["amount"],
    currency: json["currency"],
    latitude: json["latitude"]?.toString(),
    longitude: json["longitude"]?.toString(),
    category: json["category"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "trip_name": tripName,
    "amount": amount,
    "currency": currency,
    "latitude": latitude,
    "longitude": longitude,
    "category": category,
  };
}
