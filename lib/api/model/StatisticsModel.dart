// To parse this JSON data, do
//
//     final expenseStaticsModel = expenseStaticsModelFromJson(jsonString);

import 'dart:convert';
class ExpenseStaticsModel {
  List<ExpenseStaticsData>? data;
  String? message;
  String? status;

  ExpenseStaticsModel({this.data, required this.message, required this.status});

  ExpenseStaticsModel.fromJson(Map<String, dynamic> json) {
  if (json['data'] != null) {
  data = <ExpenseStaticsData>[];
  json['data'].forEach((v) {
  data?.add(new ExpenseStaticsData.fromJson(v));
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

  class ExpenseStaticsData {
  String? Category;
  String? amount;

  ExpenseStaticsData({this.Category,this.amount});


  ExpenseStaticsData.fromJson(Map<String, dynamic> json) {
    Category = json['Category'];
  amount = json['amount'].toString();

  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['Category'] = this.Category;
  data['amount'] = this.amount;
  return data;
  }
  }

