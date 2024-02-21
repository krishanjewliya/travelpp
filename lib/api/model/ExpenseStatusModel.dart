// To parse this JSON data, do
//
//     final expenseStatusModel = expenseStatusModelFromJson(jsonString);

import 'dart:convert';

ExpenseStatusModel expenseStatusModelFromJson(String str) => ExpenseStatusModel.fromJson(json.decode(str));

String expenseStatusModelToJson(ExpenseStatusModel data) => json.encode(data.toJson());

class ExpenseStatusModel {
  String? status;
  Data? data;
  String? message;

  ExpenseStatusModel({
     this.status,
     this.data,
     this.message,
  });

  factory ExpenseStatusModel.fromJson(Map<String, dynamic> json) => ExpenseStatusModel(
    status: json["status"],
    data: Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data?.toJson(),
    "message": message,
  };
}

class Data {
  String? trip_name;
  String? id;
  String? totalAmount;
  String? todaySpend;
  String? dailyAverageSpend;
  String? totalTripAmount;
  String? surplusMoney;

  Data({
     this.trip_name,
     this.id,
     this.totalAmount,
     this.todaySpend,
     this.dailyAverageSpend,
     this.totalTripAmount,
     this.surplusMoney,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    trip_name: json["trip_name"].toString(),
    id: json["id"].toString(),
    totalAmount: json["total_amount"].toString(),
    todaySpend: json["today_spend"].toString(),
    dailyAverageSpend: json["daily_average_spend"].toString(),
    totalTripAmount: json["total_trip_amount"].toString(),
    surplusMoney: json["surplus_money"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "trip_name": trip_name,
    "total_amount": totalAmount.toString(),
    "today_spend": todaySpend,
    "daily_average_spend": dailyAverageSpend,
    "total_trip_amount": totalTripAmount,
    "surplus_money": surplusMoney,
  };
}
