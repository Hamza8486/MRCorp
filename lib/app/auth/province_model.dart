class GetProvinceModel {
  bool? status;
  List<Province>? province;
  String? baseUrl;
  String? message;

  GetProvinceModel({this.status, this.province, this.baseUrl, this.message});

  GetProvinceModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['province'] != null) {
      province = <Province>[];
      json['province'].forEach((v) {
        province!.add(new Province.fromJson(v));
      });
    }
    baseUrl = json['base_url'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.province != null) {
      data['province'] = this.province!.map((v) => v.toJson()).toList();
    }
    data['base_url'] = this.baseUrl;
    data['message'] = this.message;
    return data;
  }
}

class Province {
  int? id;
  String? name;
  int? status;
 var image;
  String? createdAt;
  String? updatedAt;

  Province(
      {this.id,
        this.name,
        this.status,
        this.image,
        this.createdAt,
        this.updatedAt});

  Province.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
