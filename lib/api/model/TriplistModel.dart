// To parse this JSON data, do
//
//     final tripListModel = tripListModelFromJson(jsonString);

import 'dart:convert';


class TripListModel {
  String? status;
  List<TripListDataModel>? data;
  String? message;

  TripListModel({
     this.status,
     this.data,
     this.message,
  });

/*
  TripListModel.fromJson(Map<String, dynamic> json)
  json['data'] != null ? new Data.fromJson(json['data']) : null
      : data = json['data'] != null
      ? List<TripListDataModel>.from(json['data'].map((v) => TripListDataModel.fromJson(v)))
      : null,
        message = json['message'],
        status = json['status'];
*/

  TripListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <TripListDataModel>[];
      json['data'].forEach((v) {
        data?.add(new TripListDataModel.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }

Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  if (this.data != null) {
    data['data'] = this.data?.map((v) => v.toJson()).toList();
  }
  data['message'] = this.message;
  data['status'] = this.status;
  return data;
}
}
class TripListDataModel {
  int? id;
  int? userId;
  int? adminId;
  String? name;
  String? tripType;
  String? tripName;
  int? budget;
  String? currency;
  String? startDate;
  String? endDate;
  int? tripStatus;
  String? statusRemark;

  TripListDataModel({
     this.id,
     this.userId,
     this.adminId,
     this.name,
     this.tripType,
     this.tripName,
     this.budget,
     this.currency,
     this.startDate,
     this.endDate,
     this.tripStatus,
     this.statusRemark,
  });

  factory TripListDataModel.fromJson(Map<String, dynamic> json) => TripListDataModel(
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
    statusRemark: json["status_remark"],
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
    "status_remark": statusRemark,
  };
}
