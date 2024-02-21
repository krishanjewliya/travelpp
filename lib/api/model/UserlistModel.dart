// To parse this JSON data, do
//
//     final userListModel = userListModelFromJson(jsonString);

import 'dart:convert';

UserListModel userListModelFromJson(String str) => UserListModel.fromJson(json.decode(str));

String userListModelToJson(UserListModel data) => json.encode(data.toJson());

class UserListModel {
  String? status;
  List<UserlistData>? data;
  String? message;

  UserListModel({
     this.status,
     this.data,
     this.message,
  });

  factory UserListModel.fromJson(Map<String, dynamic> json) => UserListModel(
    status: json["status"],
    data: List<UserlistData>.from(json["data"].map((x) => UserlistData.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
  };
}

class UserlistData {
  int? id;
  String? name;
  String? countryCode;
  int? mobile;
  String? email;
  String? empId;
  int? isEmailVerified;
  int? createdBy;
  String? rememberToken;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? rolename;

  UserlistData({
     this.id,
     this.name,
     this.countryCode,
     this.mobile,
     this.email,
     this.empId,
     this.isEmailVerified,
     this.createdBy,
     this.rememberToken,
     this.createdAt,
     this.updatedAt,
     this.rolename,
  });

  factory UserlistData.fromJson(Map<String, dynamic> json) => UserlistData(
    id: json["id"],
    name: json["name"],
    countryCode: json["country_code"],
    mobile: json["mobile"],
    email: json["email"],
    empId: json["emp_id"],
    isEmailVerified: json["is_email_verified"],
    createdBy: json["created_by"],
    rememberToken: json["remember_token"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    rolename: json["rolename"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "country_code": countryCode,
    "mobile": mobile,
    "email": email,
    "emp_id": empId,
    "is_email_verified": isEmailVerified,
    "created_by": createdBy,
    "remember_token": rememberToken,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "rolename": rolename,
  };
}
