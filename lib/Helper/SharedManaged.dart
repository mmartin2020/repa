import 'dart:async';

import 'package:delivery_boy/Helper/Constant.dart';
import 'package:delivery_boy/Helper/RequestManager.dart';
import 'package:delivery_boy/generated/i18n.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math' show cos, sqrt, asin;
import 'package:http/http.dart' as http;
import 'dart:convert';

class SharedManager {
  static final SharedManager shared = SharedManager._internal();

  factory SharedManager() {
    return shared;
  }

  SharedManager._internal();

  var fontFamilyName = "Quicksand";
  bool isFromTab = false;
  bool isFromCart = false;
  var currentIndex = 1;
  var direction = TextDirection.ltr;
  var token = "";
  bool isNotificationComes = false;
  String userID = "";
  double latitude = 0.0;
  double longitude = 0.0;

  Timer timer;

  // final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  ValueNotifier<Locale> locale = new ValueNotifier(Locale('en', ''));

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Ingresa un email válido';
    else
      return null;
  }

  storeString(String value, String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  Future<String> getStrng(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final value = await prefs.get(key);
    if (value != null) {
      return value;
    } else {
      return "";
    }
  }

  Future<String> getUserID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userID = prefs.getString(DefaultKeys.userId);
    if (userID != "") {
      return userID;
    } else {
      return "";
    }
  }

  void showAlertDialog(String message, BuildContext context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("${S.current.food_zone}"),
          content: new Text(message),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new TextButton(
              child: new Text("${S.current.ok}"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  setTimerMethod() async {
    this.timer = Timer.periodic(Duration(seconds: 10), (timer) async {
      print('Timer Method Called:${this.latitude},${this.longitude}');
      Requestmanager manager = Requestmanager();
      await manager.updateDriverLocation(userID);
    });
  }
}

class GoogleMapsServices {
  Future<String> getRouteCoordinates(LatLng l1, LatLng l2) async {
    String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${l1.latitude},${l1.longitude}&destination=${l2.latitude},${l2.longitude}&key=${Keys.directionKeys}";
    http.Response response = await http.get(url);
    Map values = jsonDecode(response.body);

    return values["routes"][0]["overview_polyline"]["points"];
  }
}

double calculateDistance(lat1, lon1, lat2, lon2) {
  var p = 0.017453292519943295;
  var c = cos;
  var a = 0.5 -
      c((lat2 - lat1) * p) / 2 +
      c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  return 12742 * asin(sqrt(a));
}
