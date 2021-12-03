import 'package:delivery_boy/BLoC/CommonBlocClass/BaseMode.dart';

class ResProfileData extends BaseModel {
  int code;
  String message;
  Profile result;

  ResProfileData({this.code, this.message, this.result});

  ResProfileData.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    result =
        json['result'] != null ? new Profile.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    return data;
  }
}

class Profile {
  String driverId;
  String name;
  String email;
  String profileImage;
  String identityNumber;
  String identityImage;
  String licenseNumber;
  String licenseImage;
  String phone;
  String gender;
  String dateOfBirth;
  String age;
  String isAvailable;
  String permenentAddress;
  String totalTip;
  String totalDeliveredOrders;
  String totalRejectedOrders;
  String currentAddress;
  String averageReview;

  Profile(
      {this.driverId,
      this.name,
      this.email,
      this.profileImage,
      this.identityNumber,
      this.identityImage,
      this.licenseNumber,
      this.licenseImage,
      this.phone,
      this.gender,
      this.dateOfBirth,
      this.age,
      this.isAvailable,
      this.permenentAddress,
      this.totalTip,
      this.totalDeliveredOrders,
      this.totalRejectedOrders,
      this.currentAddress,
      this.averageReview});

  Profile.fromJson(Map<String, dynamic> json) {
    driverId = json['driver_id'];
    name = json['name'];
    email = json['email'];
    profileImage = json['profile_image'];
    identityNumber = json['identity_number'];
    identityImage = json['identity_image'];
    licenseNumber = json['license_number'];
    licenseImage = json['license_image'];
    phone = json['phone'];
    gender = json['gender'];
    dateOfBirth = json['date_of_birth'];
    age = json['age'];
    isAvailable = json['is_available'];
    permenentAddress = json['permenent_address'];
    totalTip = json['total_tip'];
    totalDeliveredOrders = json['total_delivered_orders'];
    totalRejectedOrders = json['total_rejected_orders'];
    currentAddress = json['current_address'];
    averageReview = json['avg_review'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['driver_id'] = this.driverId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['profile_image'] = this.profileImage;
    data['identity_number'] = this.identityNumber;
    data['identity_image'] = this.identityImage;
    data['license_number'] = this.licenseNumber;
    data['license_image'] = this.licenseImage;
    data['phone'] = this.phone;
    data['gender'] = this.gender;
    data['date_of_birth'] = this.dateOfBirth;
    data['age'] = this.age;
    data['is_available'] = this.isAvailable;
    data['permenent_address'] = this.permenentAddress;
    data['total_tip'] = this.totalTip;
    data['total_delivered_orders'] = this.totalDeliveredOrders;
    data['total_rejected_orders'] = this.totalRejectedOrders;
    data['current_address'] = this.currentAddress;
    data['avg_review'] = this.averageReview;
    return data;
  }
}
