class AuthUserModel {
  String? status;
  String? message;
  List<DataUser>? data;

  AuthUserModel({this.status, this.message, this.data});

  AuthUserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DataUser>[];
      json['data'].forEach((v) {
        data!.add(new DataUser.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataUser {
  String? phoneNumber;
  int? balance;
  String? created;

  DataUser({this.phoneNumber, this.balance, this.created});

  DataUser.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['phoneNumber'];
    balance = (json['balance'] is int) ? json['balance'] : null;
    created = json['created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phoneNumber'] = this.phoneNumber;
    data['balance'] = this.balance;
    data['created'] = this.created;
    return data;
  }
}
