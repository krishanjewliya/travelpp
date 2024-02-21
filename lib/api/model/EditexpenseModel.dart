// To parse this JSON data, do
//
//     final editexpenseModel = editexpenseModelFromJson(jsonString);

import 'dart:convert';

EditexpenseModel editexpenseModelFromJson(String str) => EditexpenseModel.fromJson(json.decode(str));

String editexpenseModelToJson(EditexpenseModel data) => json.encode(data.toJson());

class EditexpenseModel {
  String status;
  List<Data> data;
  String message;

  EditexpenseModel({
    required this.status,
    required this.data,
    required this.message,
  });

  factory EditexpenseModel.fromJson(Map<String, dynamic> json) => EditexpenseModel(
    status: json["status"],
    data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
  };
}

class Data {
  int id;
  int userId;
  int tripId;
  String expenseCategory;
  String expense_name;
  int amount;
  String currency;
  String description;
  DateTime date;
  int distribution;
  String paymentMode;
  double latitude;
  double longitude;
  String billImage;
  bool deleteStatus;
  DateTime createdAt;
  DateTime updatedAt;

  Data({
    required this.id,
    required this.userId,
    required this.tripId,
    required this.expenseCategory,
    required this.expense_name,
    required this.amount,
    required this.currency,
    required this.description,
    required this.date,
    required this.distribution,
    required this.paymentMode,
    required this.latitude,
    required this.longitude,
    required this.billImage,
    required this.deleteStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    userId: json["user_id"],
    tripId: json["trip_id"],
    expenseCategory: json["expense_category"].toString(),
    expense_name: json["expense_name"],
    amount: json["amount"],
    currency: json["currency"],
    description: json["description"],
    date: DateTime.parse(json["date"]),
    distribution: json["distribution"],
    paymentMode: json["payment_mode"],
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    billImage: json["bill_image"].toString(),
    deleteStatus: json["delete_status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "trip_id": tripId,
    "expense_category": expenseCategory.toString(),
    "expense_name": expense_name,
    "amount": amount,
    "currency": currency,
    "description": description,
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
