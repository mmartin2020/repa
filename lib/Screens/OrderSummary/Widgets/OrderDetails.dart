import 'dart:io';
import 'package:delivery_boy/Helper/CommonWidgets.dart';
import 'package:delivery_boy/Helper/Constant.dart';
import 'package:delivery_boy/generated/i18n.dart';
import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetailss extends StatelessWidget {
  final String orderId;
  final String paymentType;
  final String date;
  final String phone;
  final String latitude;
  final String longitude;
  final String deliveryAddress;
  final String deliveryDate;
  final String deliveryTime;

  OrderDetailss(
      this.orderId,
      this.paymentType,
      this.date,
      this.phone,
      this.deliveryAddress,
      this.latitude,
      this.longitude,
      this.deliveryDate,
      this.deliveryTime);
  @override
  Widget build(BuildContext context) {
    return new Container(
      // height: 350,
      // color: AppColor.red,
      padding: new EdgeInsets.all(10),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          setCommonText(S.current.order_details, AppColor.themeColor, 14.0,
              FontWeight.w500, 1),
          Divider(
            color: AppColor.grey,
          ),
          _setCommonWidgetForDetails(S.current.order_ID, "$orderId"),
          SizedBox(
            height: 15,
          ),
          _setCommonWidgetForDetails(
              'Entrega en:', "${this.deliveryDate} at ${this.deliveryTime}"),
          SizedBox(
            height: 15,
          ),
          _setCommonWidgetForDetails(
              S.current.payment, "${_setCardType(paymentType)}"),
          SizedBox(
            height: 15,
          ),
          _setCommonWidgetForDetails(S.current.date, "$date"),
          SizedBox(
            height: 15,
          ),
          _setCommonWidgetForPhoneAddress(
              S.current.phone_number, "$phone", true),
          SizedBox(
            height: 15,
          ),
          _setCommonWidgetForPhoneAddress(
              S.current.delivery_to, "$deliveryAddress", false),
        ],
      ),
    );
  }

  _setCommonWidgetForDetails(String title, String value) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        setCommonText(title, AppColor.grey, 13.0, FontWeight.w500, 1),
        SizedBox(
          height: 1,
        ),
        setCommonText(value, AppColor.black, 12.0, FontWeight.w400, 2),
      ],
    );
  }

  _setCommonWidgetForPhoneAddress(String title, String value, bool isPhone) {
    return new Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Expanded(
            flex: 4,
            child: new Container(
              child: _setCommonWidgetForDetails(title, value),
            )),
        new Expanded(
            flex: 1,
            child: Container(
              height: 50,
              // color:Colors.green,
              child: new Center(
                  child: new InkWell(
                onTap: () async {
                  if (isPhone) {
                    _launchURL(value);
                  } else {
                    if (Platform.isIOS) {
                      await MapLauncher.launchMap(
                        mapType: MapType.apple,
                        coords: Coords(
                            double.parse(latitude), double.parse(longitude)),
                        title: this.deliveryAddress,
                        description: "",
                      );
                    } else {
                      await MapLauncher.launchMap(
                        mapType: MapType.google,
                        coords: Coords(
                            double.parse(latitude), double.parse(longitude)),
                        title: this.deliveryAddress,
                        description: "",
                      );
                    }
                  }
                },
                child: new Container(
                    height: 30,
                    width: 30,
                    child: new Material(
                      color: AppColor.grey[300],
                      elevation: 1.0,
                      borderRadius: BorderRadius.circular(15),
                      child: Center(
                        child: isPhone
                            ? new Icon(Icons.phone,
                                color: AppColor.white, size: 18)
                            : new Icon(Icons.navigation,
                                color: AppColor.white, size: 18),
                      ),
                    )),
              )),
            ))
      ],
    );
  }

  _launchURL(String phoneNO) async {
    print('phone number:$phoneNO');
    final url = 'tel:$phoneNO';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  String _setCardType(String type) {
    if (type == "1") {
      return S.current.cod;
    } else if (type == "2") {
      return S.current.card;
    } else if (type == "4") {
      return 'RazorPay';
    } else if (type == "5") {
      return 'Wallet';
    } else {
      return S.current.paypal;
    }
  }
}
