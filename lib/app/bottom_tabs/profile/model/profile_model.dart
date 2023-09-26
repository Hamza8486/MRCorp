class GetProfileModel {
  bool? status;
  ProfileDataModel? data;
  String? baseUrl;
  String? message;

  GetProfileModel({this.status, this.data, this.baseUrl, this.message});

  GetProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new ProfileDataModel.fromJson(json['data']) : null;
    baseUrl = json['base_url'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['base_url'] = this.baseUrl;
    data['message'] = this.message;
    return data;
  }
}

class ProfileDataModel {
  int? id;
  String? fullName;
  String? userName;
  String? email;
  String? hasCar;
  String? hasHouse;
  String? livingStatus;
  String? dob;
  String? mobile;
  int? province;
  var emailVerifiedAt;
  int? status;
  int? isAdmin;
  String? deviceToken;
  var stripeCustomer;
  String? image;
  var verificationCode;
  var slotId;
  String? referCode;
  var earning;

  ProfileDataModel(
      {this.id,
      this.fullName,
        this.userName,
        this.email,
        this.hasCar,
        this.hasHouse,
        this.livingStatus,
        this.dob,
        this.mobile,
        this.earning,
        this.province,
        this.emailVerifiedAt,
        this.status,
        this.isAdmin,
        this.deviceToken,
        this.stripeCustomer,
        this.image,
        this.verificationCode,
        this.slotId,
        this.referCode});

  ProfileDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    userName = json['user_name'];
    email = json['email'];
    hasCar = json['has_car'];
    earning = json['earning'];
    hasHouse = json['has_house'];
    livingStatus = json['living_status'];
    dob = json['dob'];
    mobile = json['mobile'];
    province = json['province'];
    emailVerifiedAt = json['email_verified_at'];
    status = json['status'];
    isAdmin = json['is_admin'];
    deviceToken = json['device_token'];
    stripeCustomer = json['stripe_customer'];
    image = json['image'];
    verificationCode = json['verification_code'];
    slotId = json['slot_id'];
    referCode = json['refer_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['user_name'] = this.userName;
    data['email'] = this.email;
    data['has_car'] = this.hasCar;
    data['has_house'] = this.hasHouse;
    data['living_status'] = this.livingStatus;
    data['dob'] = this.dob;
    data['mobile'] = this.mobile;
    data['province'] = this.province;
    data['earning'] = this.earning;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['status'] = this.status;
    data['is_admin'] = this.isAdmin;
    data['device_token'] = this.deviceToken;
    data['stripe_customer'] = this.stripeCustomer;
    data['image'] = this.image;
    data['verification_code'] = this.verificationCode;
    data['slot_id'] = this.slotId;
    data['refer_code'] = this.referCode;
    return data;
  }
}
