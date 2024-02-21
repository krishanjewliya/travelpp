// To parse this JSON data, do
//
//     final totalexpenseModel = totalexpenseModelFromJson(jsonString);

import 'dart:convert';

TotalexpenseModel totalexpenseModelFromJson(String str) => TotalexpenseModel.fromJson(json.decode(str));

String totalexpenseModelToJson(TotalexpenseModel data) => json.encode(data.toJson());

class TotalexpenseModel {
  String status;
  ExpensisData data;
  String message;

  TotalexpenseModel({
    required this.status,
    required this.data,
    required this.message,
  });

  factory TotalexpenseModel.fromJson(Map<String, dynamic> json) => TotalexpenseModel(
    status: json["status"],
    data: ExpensisData.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data.toJson(),
    "message": message,
  };
}

class ExpensisData {
  List<Expense>? expenses;
  String? totalExpense;

  ExpensisData({
     this.expenses,
     this.totalExpense,
  });

  factory ExpensisData.fromJson(Map<String, dynamic> json) => ExpensisData(
    expenses: List<Expense>.from(json["expenses"].map((x) => Expense.fromJson(x))),
    totalExpense: json["total_expense"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "expenses": List<dynamic>.from(expenses!.map((x) => x.toJson())),
    "total_expense": totalExpense,
  };
}

class Expense {
  int id;
  int userId;
  int tripId;
  String expenseCategory;
  int amount;
  String currency;
  String description;
  DateTime date;
  int distribution;
  int expense_status;
  String paymentMode;
  double latitude;
  double longitude;
  String? billImage;
  bool deleteStatus;
  DateTime createdAt;
  DateTime updatedAt;

  Expense({
    required this.id,
    required this.userId,
    required this.tripId,
    required this.expenseCategory,
    required this.amount,
    required this.currency,
    required this.description,
    required this.date,
    required this.distribution,
    required this.expense_status,
    required this.paymentMode,
    required this.latitude,
    required this.longitude,
    this.billImage,
    required this.deleteStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Expense.fromJson(Map<String, dynamic> json) => Expense(
    id: json["id"],
    userId: json["user_id"],
    tripId: json["trip_id"],
    expenseCategory: json["expense_category"],
    amount: json["amount"],
    currency: json["currency"],
    description: json["description"],
    date: DateTime.parse(json["date"]),
    distribution: json["distribution"],
    expense_status: json["expense_status"],
    paymentMode: json["payment_mode"],
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    billImage: json["bill_image"],
    deleteStatus: json["delete_status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "trip_id": tripId,
    "expense_category": expenseCategory,
    "amount": amount,
    "currency": currency,
    "description": description,
    "expense_status": expense_status,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "distribution": distribution,
    "payment_mode": paymentMode,
    "latitude": latitude,
    "longitude": longitude,
    "bill_image": billImage,
    "delete_status": deleteStatus,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
