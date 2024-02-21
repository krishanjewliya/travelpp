class CategoryModel {

  Data? data;
  String? message;
  String? status;

  CategoryModel({this.data, required this.message, required this.status});

  CategoryModel.fromJson(Map<String, dynamic> json) {
      data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data;
    }
    return data;
  }
}

class Data {
  int? id;
  String? category_name;
  String? category_logo;

  Data({this.id, this.category_name, this.category_logo});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category_name = json['category_name'];
    category_logo = json['category_logo'];
  }

}




