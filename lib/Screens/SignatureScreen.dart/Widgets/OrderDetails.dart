import 'package:delivery_boy/Helper/CommonWidgets.dart';
import 'package:delivery_boy/Helper/Constant.dart';
import 'package:delivery_boy/generated/i18n.dart';
import 'package:flutter/material.dart';

class OrderDetails extends StatelessWidget {
  final String orderId;
  final String paymentType;
  final String date;
  final String phone;
  final String deliveryAddress;
  OrderDetails(this.orderId, this.paymentType, this.date, this.phone,
      this.deliveryAddress);
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
          setCommonText(S.current.order_details, AppColor.themeColor, 15.0,
              FontWeight.w500, 1),
          Divider(
            color: AppColor.grey,
          ),
          _setCommonWidgetForDetails(S.current.order_ID, "$orderId"),
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
              S.current.delivery_to, "$deliveryAddress", false),
          SizedBox(height: 15),
        ],
      ),
    );
  }

  _setCommonWidgetForDetails(String title, String value) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        setCommonText(title, AppColor.grey, 14.0, FontWeight.w500, 1),
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
            ))
      ],
    );
  }

  String _setCardType(String type) {
    if (type == "1") {
      return S.current.cod;
    } else if (type == "2") {
      return S.current.card;
    } else {
      return S.current.paypal;
    }
  }
}
