import 'package:delivery_boy/BLoC/CommonBlocClass/BaseMode.dart';

class ResNotificationList extends BaseModel {
  int code;
  String message;
  List<Notification> notificationList;

  ResNotificationList({this.code, this.message, this.notificationList});

  ResNotificationList.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['result'] != null) {
      notificationList = [];
      json['result'].forEach((v) {
        notificationList.add(new Notification.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.notificationList != null) {
      data['result'] = this.notificationList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notification {
  String title;
  String description;
  String type;
  String typeId;
  String date;

  Notification(
      {this.title, this.description, this.type, this.typeId, this.date});

  Notification.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    type = json['type'];
    typeId = json['type_id'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['type'] = this.type;
    data['type_id'] = this.typeId;
    data['date'] = this.date;
    return data;
  }
}
