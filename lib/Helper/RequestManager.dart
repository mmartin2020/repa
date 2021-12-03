import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:delivery_boy/Helper/SharedManaged.dart';
import 'package:delivery_boy/Model/ModelDriverData.dart';
import 'package:delivery_boy/Model/ModelNotificationList.dart';
import 'package:delivery_boy/Model/ModelOrderDetails.dart';
import 'package:delivery_boy/Model/ModelOrderHistory.dart';
import 'package:delivery_boy/Model/ModelOrderList.dart';
import 'package:delivery_boy/Model/ModelProfileData.dart';
import 'package:delivery_boy/Model/ModelReviewList.dart';
import 'package:http/http.dart' as http;
import 'Constant.dart';

class Requestmanager {
//Driver Available or not
  Future<bool> driverAvailability(dynamic param) async {
    http.Response response = await _apiRequest(APIS.changeAvailability, param);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      print("shops Details:------>$result");
      final code = result['code'];
      if (code == 0) {
        return false;
      } else {
        return true;
      }
    } else {
      throw Exception("Obtener los detalles de las tiendas fallidas");
    }
  }

//Order Details
  Future<ResOrderDetails> getOrderDetails(String orderId) async {
    final param = {"order_id": orderId};

    http.Response response = await _apiRequest(APIS.orderDetails, param);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      print("Shops Details:------>$result");
      final code = result['code'];
      if (code == 0) {
        var object = ResOrderDetails();
        object.code = 0;
        object.message = result['message'];
        object.orderDetails = OrderDetails();
        return object;
      } else {
        return ResOrderDetails.fromJson(json.decode(response.body));
      }
    } else {
      throw Exception("Obtener los detalles de las tiendas fallidas");
    }
  }

//Notification List
  Future<ResNotificationList> getNotificationList(String userId) async {
    final param = {"user_id": userId};

    http.Response response = await _apiRequest(APIS.notificationList, param);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      print("Shopps Details:------>$result");
      final code = result['code'];
      if (code == 0) {
        var object = ResNotificationList();
        object.code = 0;
        object.message = result['message'];
        object.notificationList = [];
        return object;
      } else {
        return ResNotificationList.fromJson(json.decode(response.body));
      }
    } else {
      throw Exception("Obtener los detalles de las tiendas fallidas");
    }
  }

  //Fetch Driver Reviews
  Future<ResReviewList> fetchDriverReviews(String driverId) async {
    final param = {"driver_id": driverId};

    http.Response response = await _apiRequest(APIS.driverReview, param);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      print("Shops Details:------>$result");
      final code = result['code'];
      if (code == 0) {
        var object = ResReviewList();
        object.code = 0;
        object.message = result['message'];
        object.reviewList = [];
        return object;
      } else {
        return ResReviewList.fromJson(json.decode(response.body));
      }
    } else {
      throw Exception("Obtener los detalles de las tiendas fallidas");
    }
  }

//LogoutDriver
  Future<bool> logoutDriver(dynamic param) async {
    http.Response response = await _apiRequest(APIS.logout, param);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      print("Shops Details:------>$result");
      final code = result['code'];
      if (code == 0) {
        return false;
      } else {
        return true;
      }
    } else {
      throw Exception("Obtener los detalles de las tiendas fallidas");
    }
  }

//LogoutDriver
  Future<bool> updateDriverLocation(String driverId) async {
    final param = {
      "driver_id": driverId,
      "latitude": "${SharedManager.shared.latitude}",
      "longitude": "${SharedManager.shared.longitude}"
    };
    http.Response response =
        await _apiRequest(APIS.updateDriverLocation, param);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      print("Shops Details:------>$result");
      final code = result['code'];
      if (code == 0) {
        return false;
      } else {
        return true;
      }
    } else {
      throw Exception("Obtener los detalles de las tiendas fallidas");
    }
  }

//Picke up Order From the Restaurant
  Future<bool> pickuOrederFromTheRestaurant(dynamic param) async {
    http.Response response = await _apiRequest(APIS.changeOrderStatus, param);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      print("Shops Details:------>$result");
      final code = result['code'];
      if (code == 0) {
        return false;
      } else {
        return true;
      }
    } else {
      throw Exception("Obtener los detalles de las tiendas fallidas");
    }
  }

//Accept Reject Status
  Future<bool> acceptRejectOrderStatus(dynamic param) async {
    http.Response response = await _apiRequest(APIS.acceptRejectOrder, param);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      print("Shops Details:------>$result");
      final code = result['code'];
      if (code == 0) {
        return false;
      } else {
        return true;
      }
    } else {
      throw Exception("Obtener los detalles de las tiendas fallidas");
    }
  }

//Get All Order List which are assign to driver
  Future<ResOrderList> getOrderList(String userID) async {
    final param = {"user_id": userID};
    print('Parameters:$param');
    http.Response response = await _apiRequest(APIS.orderList, param);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      print("Shops Details:------>$result");
      final code = result['code'];
      if (code == 0) {
        var object = ResOrderList();
        object.code = 0;
        object.message = result['message'];
        object.orderList = [];
        return object;
      } else {
        return ResOrderList.fromJson(json.decode(response.body));
      }
    } else {
      throw Exception("Obtener los detalles de las tiendas fallidas");
    }
  }

//Get All Order List which are assign to driver
  Future<ResOrderHistory> getHistoryOrderList(String userID) async {
    final param = {"user_id": userID};

    http.Response response = await _apiRequest(APIS.orderHistory, param);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      print("Shops Details:------>$result");
      final code = result['code'];
      if (code == 0) {
        var object = ResOrderHistory();
        object.code = 0;
        object.message = result['message'];
        object.historyOrderList = [];
        return object;
      } else {
        return ResOrderHistory.fromJson(json.decode(response.body));
      }
    } else {
      throw Exception("Obtener los detalles de las tiendas fallidas");
    }
  }

//Fetch all notification list data
  Future<ResDriverData> loginWithDriverCredentials(dynamic param) async {
    http.Response response = await _apiRequest(APIS.login, param);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      print("Shops Details:------>$result");
      final code = result['code'];
      if (code == 0) {
        var object = ResDriverData();
        object.code = 0;
        object.message = result['message'];
        object.result = Result();
        return object;
      } else {
        return ResDriverData.fromJson(json.decode(response.body));
      }
    } else {
      throw Exception("Obtener los detalles de las tiendas fallidas");
    }
  }

//Fetch all Profile list data
  Future<ResProfileData> fetchProfileData(dynamic driverId) async {
    final param = {"user_id": driverId};

    http.Response response = await _apiRequest(APIS.userProfile, param);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      print("Shops Details:------>$result");
      final code = result['code'];
      if (code == 0) {
        var object = ResProfileData();
        object.code = 0;
        object.message = result['message'];
        object.result = Profile();
        return object;
      } else {
        return ResProfileData.fromJson(json.decode(response.body));
      }
    } else {
      throw Exception("Obtener los detalles de las tiendas fallidas");
    }
  }

//Common Method for request api

  Future<http.Response> _apiRequest(String url, Map jsonMap) async {
    print("URL is:------>$url");
    print("Parametere is:------>$jsonMap");
    var body = jsonEncode(jsonMap);
    var response = await http.post(
      url,
      headers: {
        "Accept": "application/json",
        "content-type": "application/json",
      },
      body: body,
    );
    print(response.body);
    return response;
  }
}
