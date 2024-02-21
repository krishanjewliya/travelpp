// To parse this JSON data, do
//
//     final appendListModel = appendListModelFromJson(jsonString);

import 'dart:convert';

AppendListModel appendListModelFromJson(String str) => AppendListModel.fromJson(json.decode(str));

String appendListModelToJson(AppendListModel data) => json.encode(data.toJson());

class AppendListModel {
  String status;
  List<AppendData> data;
  String message;

  AppendListModel({
    required this.status,
    required this.data,
    required this.message,
  });

  factory AppendListModel.fromJson(Map<String, dynamic> json) => AppendListModel(
    status: json["status"],
    data: List<AppendData>.from(json["data"].map((x) => AppendData.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
  };
}

class AppendData {
  int id;
  int userId;
  int adminId;
  String name;
  String tripType;
  String tripName;
  int budget;
  String currency;
  String startDate;
  String endDate;
  int tripStatus;

  AppendData({
    required this.id,
    required this.userId,
    required this.adminId,
    required this.name,
    required this.tripType,
    required this.tripName,
    required this.budget,
    required this.currency,
    required this.startDate,
    required this.endDate,
    required this.tripStatus,
  });

  factory AppendData.fromJson(Map<String, dynamic> json) => AppendData(
    id: json["id"],
    userId: json["user_id"],
    adminId: json["admin_id"],
    name: json["name"],
    tripType: json["trip_type"],
    tripName: json["trip_name"],
    budget: json["budget"],
    currency: json["currency"],
    startDate: json["start_date"],
    endDate: json["end_date"],
    tripStatus: json["trip_status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "admin_id": adminId,
    "name": name,
    "trip_type": tripType,
    "trip_name": tripName,
    "budget": budget,
    "currency": currency,
    "start_date": startDate,
    "end_date": endDate,
    "trip_status": tripStatus,
  };
}
