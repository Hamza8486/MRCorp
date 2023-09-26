class getMySlots {
  bool? status;
  List<SlotDataNew>? data;
  int? price;
  String? baseUrl;
  String? message;

  getMySlots({this.status, this.data, this.price, this.baseUrl, this.message});

  getMySlots.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <SlotDataNew>[];
      json['data'].forEach((v) {
        data!.add(new SlotDataNew.fromJson(v));
      });
    }
    price = json['price'];
    baseUrl = json['base_url'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['price'] = this.price;
    data['base_url'] = this.baseUrl;
    data['message'] = this.message;
    return data;
  }
}

class SlotDataNew {
  int? id;
  int? betId;
  int? provinceId;
  String? coupon;
  String? price;
  String? type;
  String? isScratch;
  String? createdAt;

  SlotDataNew(
      {this.id,
        this.betId,
        this.provinceId,
        this.coupon,
        this.isScratch,
        this.price,
        this.type,
        this.createdAt});

  SlotDataNew.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    betId = json['bet_id'];
    provinceId = json['province_id'];
    coupon = json['coupon'];
    price = json['price'];
    isScratch = json['isScratch'];
    type = json['type'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bet_id'] = this.betId;
    data['province_id'] = this.provinceId;
    data['coupon'] = this.coupon;
    data['isScratch'] = this.isScratch;
    data['price'] = this.price;
    data['type'] = this.type;
    data['created_at'] = this.createdAt;
    return data;
  }
}
