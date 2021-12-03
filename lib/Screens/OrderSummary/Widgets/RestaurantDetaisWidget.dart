import 'dart:io';

import 'package:delivery_boy/Helper/CommonWidgets.dart';
import 'package:delivery_boy/Helper/Constant.dart';
import 'package:delivery_boy/Screens/GoogleMapPage/GoogleMapPage.dart';
import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';

class RestaurantDetailsWidget extends StatelessWidget {
  final String resName;
  final String resAddress;
  final String resImage;
  final String resLatitude;
  final String resLongitude;

  RestaurantDetailsWidget(this.resName, this.resAddress, this.resImage,
      this.resLatitude, this.resLongitude);
  @override
  Widget build(BuildContext context) {
    return new Container(
      // height: 110,
      // color: AppColor.green,
      padding: new EdgeInsets.all(10),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Divider(
            color: AppColor.grey[400],
          ),
          setCommonText(resName, AppColor.black, 15.0, FontWeight.w500, 1),
          SizedBox(
            height: 5,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: setCommonText(
                      resAddress, AppColor.grey, 12.0, FontWeight.w400, 2),
                ),
              ),
              InkWell(
                onTap: () async {
                  print('restaurant latitude:$resLatitude');
                  print('restaurant longitude:$resLongitude');
                  if (Platform.isIOS) {
                    await MapLauncher.launchMap(
                      mapType: MapType.apple,
                      coords: Coords(double.parse(resLatitude),
                          double.parse(resLongitude)),
                      title: this.resAddress,
                      description: "",
                    );
                  } else {
                    await MapLauncher.launchMap(
                      mapType: MapType.google,
                      coords: Coords(double.parse(resLatitude),
                          double.parse(resLongitude)),
                      title: this.resAddress,
                      description: "",
                    );
                  }
                },
                child: new Container(
                    height: 30,
                    width: 30,
                    child: new Material(
                      color: AppColor.grey[300],
                      borderRadius: BorderRadius.circular(15),
                      child: Center(
                        child: Icon(Icons.navigation,
                            color: AppColor.white, size: 18),
                      ),
                    )),
              )
            ],
          )
        ],
      ),
    );
  }
}
