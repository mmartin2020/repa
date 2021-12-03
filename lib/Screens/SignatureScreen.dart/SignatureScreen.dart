import 'dart:convert';
import 'dart:ui';
import 'package:delivery_boy/Helper/CommonWidgets.dart';
import 'package:delivery_boy/Helper/Constant.dart';
import 'package:delivery_boy/Helper/RequestManager.dart';
import 'package:delivery_boy/Helper/SharedManaged.dart';
import 'package:delivery_boy/Screens/OrderSummary/Widgets/RestaurantDetaisWidget.dart';
import 'package:delivery_boy/Screens/SignatureScreen.dart/Widgets/OrderDetails.dart';
import 'package:delivery_boy/Screens/TabBarScreens/TabBar/TabBarScreen.dart';
import 'package:delivery_boy/generated/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signature_pad/flutter_signature_pad.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Helper/Constant.dart';

void main() => runApp(new SignatureScreen());

class SignatureScreen extends StatefulWidget {
  final resName;
  final resAddress;
  final orderId;
  final userId;
  final paymentTYpe;
  final date;
  final deliveryAddress;

  SignatureScreen(
      {Key key,
      this.resName,
      this.resAddress,
      this.orderId,
      this.paymentTYpe,
      this.date,
      this.deliveryAddress,
      this.userId});

  @override
  _SignatureScreenState createState() => _SignatureScreenState();
}

class _SignatureScreenState extends State<SignatureScreen> {
  final _sign = GlobalKey<SignatureState>();
  bool isPaymentReceived = false;
  bool isSignature = false;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  _setSignatureView() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              setCommonText('${S.current.customer_Signature}', AppColor.black87,
                  15.0, FontWeight.w500, 1),
              new InkWell(
                onTap: () {
                  setState(() {
                    final sign = _sign.currentState;
                    sign.clear();
                    this.isSignature = false;
                  });
                },
                child: new Container(
                  child: setCommonText('${S.current.clear_signature}',
                      AppColor.red, 15.0, FontWeight.w500, 1),
                ),
              ),
            ],
          ),
        ),
        Container(
            height: 300,
            padding: new EdgeInsets.all(15),
            child: Container(
              color: Colors.grey[200],
              child: Signature(
                color: AppColor.themeColor,
                key: _sign,
                onSign: () {
                  final sign = _sign.currentState;
                  this.isSignature = true;
                  debugPrint('${sign.points.length} puntos en la firma');
                },
                strokeWidth: 3,
              ),
            )),
      ],
    );
  }

  _deliveredOrderOrCancleOrderWidgets() {
    return new Container(
      height: 50,
      padding: new EdgeInsets.only(left: 15, right: 15),
      child: new Row(
        children: <Widget>[
          new Expanded(
              child: new InkWell(
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              final driveriD = prefs.getString(DefaultKeys.userId);
              final sign = _sign.currentState;

              print("Estado de la firma:${this.isSignature}");
              if (!this.isSignature) {
                SharedManager.shared.showAlertDialog(
                    "${S.current.take_customer_signature}", context);
                return;
              }
              if (!this.isPaymentReceived) {
                SharedManager.shared.showAlertDialog(
                    "${S.current.take_payment_first}", context);
                return;
              }

              final image = await sign.getData();
              var data = await image.toByteData(format: ImageByteFormat.png);
              // sign.clear();
              // this.isSignature = false;
              final encoded = base64.encode(data.buffer.asUint8List());

              var param = {
                "latitude": "${SharedManager.shared.latitude}",
                "longitude": "${SharedManager.shared.longitude}",
                "status": "5",
                "signature": "$encoded",
                "order_id": this.widget.orderId,
                "driver_id": driveriD,
                "user_id": this.widget.userId
              };

              print("Accepr Reject Order Status:$param");

              final reqManager = Requestmanager();
              showSnackbar(
                  '${S.current.order_is_delivering}', scaffoldKey, context);
              final status =
                  await reqManager.pickuOrederFromTheRestaurant(param);
              if (status) {
                ScaffoldMessenger.of(context).removeCurrentSnackBar();
                Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => TabBarScreen()),
                    ModalRoute.withName(AppRoute.tabbar));
              } else {
                ScaffoldMessenger.of(context).removeCurrentSnackBar();
                SharedManager.shared.showAlertDialog(
                    '${S.current.try_after_sometime}', context);
              }
            },
            child: Container(
              height: 45,
              child: Material(
                color: AppColor.themeColor,
                borderRadius: BorderRadius.circular(25),
                child: new Center(
                  child: setCommonText("${S.current.delivered}", AppColor.white,
                      15.0, FontWeight.w500, 1),
                ),
              ),
            ),
          )),
          SizedBox(width: 10),
          new Expanded(
              child: Container(
            height: 45,
            child: Material(
              color: AppColor.red,
              borderRadius: BorderRadius.circular(25),
              child: new Center(
                child: setCommonText("${S.current.cancelled}", AppColor.white,
                    15.0, FontWeight.w500, 1),
              ),
            ),
          ))
        ],
      ),
    );
  }

  setSignatureView() {
    return new Row(
      children: <Widget>[
        new Checkbox(
          value: this.isPaymentReceived,
          onChanged: (value) {
            setState(() {
              this.isPaymentReceived = value;
            });
          },
        ),
        SizedBox(width: 5),
        setCommonText('${S.current.payment_receive}', AppColor.themeColor, 15.0,
            FontWeight.w500, 1)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: setCommonAppBar('${S.current.deliver_order}', false, context),
      body: new Container(
        color: AppColor.white,
        child: new ListView(
          children: <Widget>[
            RestaurantDetailsWidget(
                this.widget.resName, this.widget.resAddress, '', '', ''),
            OrderDetails(
                '#${this.widget.orderId}',
                "${this.widget.paymentTYpe}",
                "${this.widget.date}",
                "",
                "${this.widget.deliveryAddress}"),
            setSignatureView(),
            _setSignatureView(),
            _deliveredOrderOrCancleOrderWidgets(),
            SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}
