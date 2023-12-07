
class TransactionsModel {
  String? status;
  List<Data>? data;

  TransactionsModel({this.status, this.data});

  TransactionsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? type;
  int? amount;
  String? phoneNumber;
  String? created;

  Data({this.type,
    this.amount,
    this.phoneNumber,
    this.created,});

  Data.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    amount = (json['amount'] is int) ? json['amount'] : null;
    phoneNumber = json['phoneNumber'];
    created = json['created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['amount'] = amount;
    data['phoneNumber'] = phoneNumber;
    data['created'] = created;
    return data;
  }
}
