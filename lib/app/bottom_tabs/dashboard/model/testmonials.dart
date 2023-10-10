class TestMonialsModel {
  bool? status;
  String? baseUrl;
  List<Data>? data;
  String? message;

  TestMonialsModel({this.status, this.baseUrl, this.data, this.message});

  TestMonialsModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? lastName;
  String? provinceId;
  String? phoneNumber;
  String? address;
  String? email;
  int? userId;
  int? betId;
  int? status;
  var video;
  String? createdAt;
  String? updatedAt;
  int? slotId;
  Images? images;
  Videos? videos;

  Data(
      {this.id,
        this.name,
        this.lastName,
        this.provinceId,
        this.phoneNumber,
        this.address,
        this.email,
        this.userId,
        this.betId,
        this.status,
        this.video,
        this.createdAt,
        this.updatedAt,
        this.slotId,
        this.images,
        this.videos});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    lastName = json['last_name'];
    provinceId = json['province_id'];
    phoneNumber = json['phone_number'];
    address = json['address'];
    email = json['email'];
    userId = json['user_id'];
    betId = json['bet_id'];
    status = json['status'];
    video = json['video'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    slotId = json['slot_id'];
    images =
    json['images'] != null ? new Images.fromJson(json['images']) : null;
    videos =
    json['videos'] != null ? new Videos.fromJson(json['videos']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['last_name'] = this.lastName;
    data['province_id'] = this.provinceId;
    data['phone_number'] = this.phoneNumber;
    data['address'] = this.address;
    data['email'] = this.email;
    data['user_id'] = this.userId;
    data['bet_id'] = this.betId;
    data['status'] = this.status;
    data['video'] = this.video;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['slot_id'] = this.slotId;
    if (this.images != null) {
      data['images'] = this.images!.toJson();
    }
    if (this.videos != null) {
      data['videos'] = this.videos!.toJson();
    }
    return data;
  }
}

class Images {
  int? id;
  int? testId;
  String? image;
  var video;
  String? createdAt;
  String? updatedAt;

  Images(
      {this.id,
        this.testId,
        this.image,
        this.video,
        this.createdAt,
        this.updatedAt});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    testId = json['test_id'];
    image = json['image'];
    video = json['video'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['test_id'] = this.testId;
    data['image'] = this.image;
    data['video'] = this.video;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Videos {
  int? id;
  int? testId;
  var image;
  String? video;
  String? createdAt;
  String? updatedAt;

  Videos(
      {this.id,
        this.testId,
        this.image,
        this.video,
        this.createdAt,
        this.updatedAt});

  Videos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    testId = json['test_id'];
    image = json['image'];
    video = json['video'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['test_id'] = this.testId;
    data['image'] = this.image;
    data['video'] = this.video;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
