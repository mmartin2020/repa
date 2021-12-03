import 'package:delivery_boy/BLoC/CommonBlocClass/BaseMode.dart';

class ResDriverData extends BaseModel {
  int code;
  String message;
  Result result;

  ResDriverData({this.code, this.message, this.result});

  ResDriverData.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
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

class Result {
  String driverId;
  String name;
  String email;
  String profileImage;
  String phone;
  String address;

  Result(
      {this.driverId,
      this.name,
      this.email,
      this.profileImage,
      this.phone,
      this.address});

  Result.fromJson(Map<String, dynamic> json) {
    driverId = json['driver_id'];
    name = json['name'];
    email = json['email'];
    profileImage = json['profile_image'];
    phone = json['phone'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['driver_id'] = this.driverId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['profile_image'] = this.profileImage;
    data['phone'] = this.phone;
    data['address'] = this.address;
    return data;
  }
}
