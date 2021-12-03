import 'package:flutter/material.dart';

//All Api placed in this class.
//Just replace with existing base url here.
class APIS {
  // static var baseurl = "https://grocers.galaxy1344.com/drivers/";
  static var baseurl = "https://flashliver.cf/drivers/";
  static var login = baseurl + "login";
  static var orderList = baseurl + "orders_list";
  static var acceptRejectOrder = baseurl + "accept_reject_order";
  static var changeOrderStatus = baseurl + "change_order_status";
  static var logout = baseurl + "logout";
  static var notificationList = baseurl + "notifications";
  static var orderHistory = baseurl + "orders_history";
  static var orderDetails = baseurl + "order_details";
  static var changeAvailability = baseurl + "change_availability_status";
  static var userProfile = baseurl + "profile";
  static var updateDriverLocation = baseurl + "update_driver_location";
  static var driverReview = baseurl + "get_all_review";
}

//We have used Shared preferance for storing some low level data.
//For this we have used this keys.
class DefaultKeys {
  static var userName = "name";
  static var userEmail = "email";
  static var userId = "userId";
  static var userImage = "image";
  static var userAddress = "address";
  static var userPhone = "phone";
  static var isLoggedIn = "isLoogedIn";
  static var pushToken = "firebaseToken";
}

//This is the app colors.
//You can change your theme color based on your requirements.
class AppColor {
  //This is the main application theme color.
  // static var themeColor =   Colors.green;
  static var pagingIndicatorColor = Colors.red;
  static var black = HexToColor("#000000");
  static var orangeDeep = Colors.deepOrange;
  static var colorGyay_100 = Colors.grey[100];
  static var white = Colors.white;
  static var amber = Colors.amber;
  static var grey = Colors.grey;
  static var black87 = Colors.black87;
  static var red = Colors.red;
  static var black38 = Colors.black38;
  static var deepOrange = Colors.deepOrange;
  static var black54 = Colors.black54;
  static var orange = Colors.orange;
  static var teal = Colors.teal;
  static var facebookBG = hexToColor("#5B7CB4"); //Facebook icon color
  static var googleBG = hexToColor("#D95946"); //Google plus icon color

  // You can use sample theme color
  // #f03526

  // static var themeColor = hexToColor('#65cd9d');
  static var themeColor = hexToColor('#f03526');
  // static var themeColor = hexToColor('#2F3841'); //this is icon bg color.
  // static var themeColor = HexToColor("#79CABD");
  // static var themeColor = HexToColor("#f2bd68");
  // static var themeColor = HexToColor("#9468f2");
  // static var themeColor = HexToColor("#f268b4");
  // static var themeColor = HexToColor("#f26868");

}

//Convert color from hax color.
class HexToColor extends Color {
  static _hexToColor(String code) {
    return int.parse(code.substring(1, 7), radix: 16) + 0xFF000000;
  }

  HexToColor(final String code) : super(_hexToColor(code));
}

//Important Images path we have used in application.
class AppImages {
  static var appLogo = "Assets/FoodZoneLogo.png";
  static var background = 'Assets/RestaurantDetails/RestaurantApp.jpg';
  static var googleIcon = "Assets/googlePlus.png";
  static var facebookIcon = "Assets/facebook.png";
  static var vegItem = "Assets/RestaurantDetails/veg.png";
  static var nonVegItem = "Assets/RestaurantDetails/nonVeg.png";
  static var cartDefaultImage = "Assets/Cart/emptyCart.png";
}

class AppRoute {
  static const dashboard = '/dashboard';
  static const tabbar = '/tabbar';
  static const login = '/login';
  static const signUp = '/signUp';
}

class Keys {
  static const directionKeys = 'AIzaSyAKJf1g3IxcYUQd_DyVdQANPmYxOXQQMD8';
}

Color hexToColor(String code) {
  return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}

class SharedKeys {
  static var userId = "userID";
  static var profile = "profile";
  static var name = "name";
  static var email = "email";
  static var phone = "phone";
  static var address = "address";
}
