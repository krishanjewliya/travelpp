// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';
class LoginModel {
  Data? data;
  String? message;
  String? status;

  LoginModel({this.data, this.message,  this.status});

  LoginModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
class Data {
  int? id;
  String? name;
  int? mobile;
  String? email;
  String? country_code;
  //dynamic? profile_pic;
  //dynamic? company_name;
  //dynamic? company_logo;
  String? rolename;
  String? remember_token;
  int? isEmailVerified;
  int? createdBy;
  DateTime? createdAt;
  DateTime? updatedAt;

  Data({this.id,
     this.name,
     this.mobile,
     this.email,
     this.country_code,
    //required this.profile_pic,
    //required this.company_name,
    //required this.company_logo,
     this.rolename,
     this.remember_token,
     this.isEmailVerified,
     this.createdBy,
     this.createdAt,
     this.updatedAt,
    });

  Data.fromJson(Map<String, dynamic> json) {
    id= json["id"];
    name= json["name"];
    mobile= json["mobile"];
    email= json["email"];
    country_code= json["country_code"];
    //profile_pic= json["profile_pic"];
    //company_name= json["company_name"];
    //company_logo= json["company_logo"];
    rolename= json["rolename"];
    remember_token= json["remember_token"];
    isEmailVerified= json["is_email_verified"];
    createdBy= json["created_by"];
    createdAt= DateTime.parse(json["created_at"]);
    updatedAt= DateTime.parse(json["updated_at"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['country_code'] = this.country_code;
    //data['profile_pic'] = this.profile_pic;
    //data['company_name'] = this.company_name;
    //data['company_logo'] = this.company_logo;
    data['rolename'] = this.rolename;
    data['remember_token'] = this.remember_token;
    data['is_email_verified'] = this.isEmailVerified;
    data['updated_at'] = this.updatedAt;
    data['created_at']=this. createdAt;
    data['updated_at']=this. updatedAt;
    return data;
  }
}
