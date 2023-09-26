class MyTransactionModel {
  bool? status;
  Data? data;
  String? message;

  MyTransactionModel({this.status, this.data, this.message});

  MyTransactionModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int? id;
  String? balance;
  List<MyTransaction>? myTransaction;

  Data({this.id, this.balance, this.myTransaction});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    balance = json['balance'];
    if (json['my_transaction'] != null) {
      myTransaction = <MyTransaction>[];
      json['my_transaction'].forEach((v) {
        myTransaction!.add(new MyTransaction.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['balance'] = this.balance;
    if (this.myTransaction != null) {
      data['my_transaction'] =
          this.myTransaction!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MyTransaction {
  int? id;
  String? type;
  var amount;
  int? walletId;
  int? province;
  var slot;
  String? createdAt;

  MyTransaction(
      {this.id,
        this.type,
        this.amount,
        this.walletId,
        this.province,
        this.slot,
        this.createdAt});

  MyTransaction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    amount = json['amount'];
    walletId = json['wallet_id'];
    province = json['province'];
    slot = json['slot'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['amount'] = this.amount;
    data['wallet_id'] = this.walletId;
    data['province'] = this.province;
    data['slot'] = this.slot;
    data['created_at'] = this.createdAt;
    return data;
  }
}
