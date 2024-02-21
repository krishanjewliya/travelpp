class GetExpensisModel {
  List<GetExpensisData>? data;
  String? message;
  String? status;

  GetExpensisModel({this.data, required this.message, required this.status});

  GetExpensisModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <GetExpensisData>[];
      json['data'].forEach((v) {
        data?.add(new GetExpensisData.fromJson(v));
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

class GetExpensisData {
  int? id;
  String? category_name;
  String? category_logo;

  GetExpensisData({this.id, this.category_name,this.category_logo});


  GetExpensisData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category_name = json['category_name'];
    category_logo = json['category_logo'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_name'] = this.category_name;
    data['category_logo'] = this.category_logo;
    return data;
  }
}




