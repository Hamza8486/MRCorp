class GetBusinessStore {
  bool? status;
  List<Data>? data;
  String? message;

  GetBusinessStore({this.status, this.data, this.message});

  GetBusinessStore.fromJson(Map<String, dynamic> json) {
    status = json['status'];
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
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int? id;
  String? fullName;
  String? email;
  String? storeName;
  String? storeAddress;
  String? lat;
  String? lng;
  String? storeLicenseId;
  String? storeLicensePic;
  String? storeCity;
  String? storePicture;
  String? deviceToken;
  String? storeId;
  String? createdAt;

  Data(
      {this.id,
        this.fullName,
        this.email,
        this.storeName,
        this.storeAddress,
        this.lat,
        this.lng,
        this.storeLicenseId,
        this.storeLicensePic,
        this.storeCity,
        this.storePicture,
        this.deviceToken,
        this.storeId,
        this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    email = json['email'];
    storeName = json['store_name'];
    storeAddress = json['store_address'];
    lat = json['lat'];
    lng = json['lng'];
    storeLicenseId = json['store_license_id'];
    storeLicensePic = json['store_license_pic'];
    storeCity = json['store_city'];
    storePicture = json['store_picture'];
    deviceToken = json['device_token'];
    storeId = json['store_id'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    data['store_name'] = this.storeName;
    data['store_address'] = this.storeAddress;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['store_license_id'] = this.storeLicenseId;
    data['store_license_pic'] = this.storeLicensePic;
    data['store_city'] = this.storeCity;
    data['store_picture'] = this.storePicture;
    data['device_token'] = this.deviceToken;
    data['store_id'] = this.storeId;
    data['created_at'] = this.createdAt;
    return data;
  }
}
