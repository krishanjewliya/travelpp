class AccessRoleModel {
  List<AccessRoleModelData>? data;
  String? message;
  String? status;

  AccessRoleModel({this.data, required this.message, required this.status});

  AccessRoleModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <AccessRoleModelData>[];
      json['data'].forEach((v) {
        data?.add(new AccessRoleModelData.fromJson(v));
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

class AccessRoleModelData {
  int? id;
  int? plan_id;
  String? rolename;

  AccessRoleModelData({this.id, this.plan_id,this.rolename});

  AccessRoleModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    plan_id = json['plan_id'];
    rolename = json['rolename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['plan_id'] = this.plan_id;
    data['rolename'] = this.rolename;
    return data;
  }
}




