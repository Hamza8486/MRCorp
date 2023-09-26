class winnersModel {
  bool? status;
  String? baseUrl;
  List<Data>? data;
  String? message;

  winnersModel({this.status, this.baseUrl, this.data, this.message});

  winnersModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    baseUrl = json['base_url'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['base_url'] = this.baseUrl;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int? id;
  String? lucky;
  String? luckyType;
  var other;
  int? provinceId;
  int? userId;
  int? provinceSlotCount;
  Province? province;
  User? user;

  Data(
      {this.id,
        this.lucky,
        this.luckyType,
        this.other,
        this.provinceId,
        this.userId,
        this.provinceSlotCount,
        this.province,
        this.user});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lucky = json['lucky'];
    luckyType = json['lucky_type'];
    other = json['other'];
    provinceId = json['province_id'];
    userId = json['user_id'];
    provinceSlotCount = json['provinceSlotCount'];
    province = json['province'] != null
        ? new Province.fromJson(json['province'])
        : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['lucky'] = this.lucky;
    data['lucky_type'] = this.luckyType;
    data['other'] = this.other;
    data['province_id'] = this.provinceId;
    data['user_id'] = this.userId;
    data['provinceSlotCount'] = this.provinceSlotCount;
    if (this.province != null) {
      data['province'] = this.province!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class Province {
  int? id;
  String? name;

  Province({this.id, this.name});

  Province.fromJson(Map<String, dynamic> json) {
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

class User {
  String? fullName;
  String? email;
  String? image;

  User({this.fullName, this.email, this.image});

  User.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'];
    email = json['email'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    data['image'] = this.image;
    return data;
  }
}
