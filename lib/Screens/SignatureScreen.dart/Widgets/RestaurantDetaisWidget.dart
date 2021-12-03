import 'package:delivery_boy/Helper/CommonWidgets.dart';
import 'package:delivery_boy/Helper/Constant.dart';
import 'package:flutter/material.dart';

class RestaurantDetailsWidget extends StatelessWidget {
  final String resName;
  final String resAddress;
  RestaurantDetailsWidget(this.resName, this.resAddress);
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
          setCommonText(resName, AppColor.black, 14.0, FontWeight.w500, 1),
          SizedBox(
            height: 5,
          ),
          setCommonText(resAddress, AppColor.grey, 12.0, FontWeight.w400, 2),
        ],
      ),
    );
  }
}
