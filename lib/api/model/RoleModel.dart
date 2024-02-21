class RoleModel {
  List<RoleModelData>? data;
  String? message;
  String? status;

  RoleModel({this.data, required this.message, required this.status});

  RoleModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <RoleModelData>[];
      json['data'].forEach((v) {
        data?.add(new RoleModelData.fromJson(v));
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

class RoleModelData {
  int? id;
  String? name;

  RoleModelData({this.id, this.name});

  RoleModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}




