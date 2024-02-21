class CurrencyModel {
  List<CurrencyDataList>? data;
  String? message;
  String? status;

  CurrencyModel({this.data, required this.message, required this.status});

  CurrencyModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <CurrencyDataList>[];
      json['data'].forEach((v) {
        data?.add(new CurrencyDataList.fromJson(v));
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

class CurrencyDataList {
  int? id;
  String? currency;

  CurrencyDataList({this.id, this.currency});

  CurrencyDataList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['currency'] = this.currency;
    return data;
  }
}




