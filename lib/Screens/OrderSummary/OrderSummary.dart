import 'package:delivery_boy/BLoC/MainModelBlocClass/OrderDetailsBloC.dart';
import 'package:delivery_boy/Helper/CommonWidgets.dart';
import 'package:delivery_boy/Helper/Constant.dart';
import 'package:delivery_boy/Model/ModelOrderDetails.dart';
import 'package:delivery_boy/Screens/SignatureScreen.dart/SignatureScreen.dart';
import 'package:delivery_boy/generated/i18n.dart';
import 'package:flutter/material.dart';
import 'Widgets/ItemListWidget.dart';
import 'Widgets/OrderDetails.dart';
import 'Widgets/ProductDetailsWidget.dart';
import 'Widgets/RestaurantDetaisWidget.dart';

void main() => runApp(new OrderSummary());

class OrderSummary extends StatefulWidget {
  final orderId;
  final orderStatus;
  final userId;
  final resImage;
  OrderSummary(
      {Key key, this.orderId, this.orderStatus, this.userId, this.resImage})
      : super(key: key);
  @override
  _OrderSummaryState createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary> {
  var totalPrice = 0.0;
  var discountedPrice = 0.0;

  // bool _setUpOrderStatus(String status) {
  //   switch (status) {
  //     case "1":
  //       return false;
  //     case "2":
  //       return false;
  //     case "3":
  //       return false;
  //     case "4":
  //       return true;
  //     case "5":
  //       return true;
  //     default:
  //       return false;
  //   }
  // }
  @override
  void initState() {
    super.initState();
    orderDetailsBloc.getOrderDetails(this.widget.orderId);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: setCommonAppBar('${S.current.order_details}', false, context),
        body: StreamBuilder(
            stream: orderDetailsBloc.orderDetails,
            builder: (context, AsyncSnapshot<ResOrderDetails> snapshot) {
              if (snapshot.hasData) {
                final result = snapshot.data.orderDetails;
                print("Latitude:${result.resLatitude}");
                print("Longitude:${result.resLongitude}");
                print("Phone number:${result.phone}");
                return new Container(
                  color: AppColor.white,
                  child: Column(
                    children: <Widget>[
                      new Expanded(
                        child: new ListView(
                          children: <Widget>[
                            RestaurantDetailsWidget(
                                "${result.name}",
                                "${result.address}",
                                this.widget.resImage,
                                result.resLatitude,
                                result.resLongitude),
                            OrderDetailsWidget(result.products),
                            ItemListWidget(
                                '${result.totalPrice}', '${result.tipPrice}'),
                            OrderDetailss(
                                '#${result.orderId}',
                                result.paymentType,
                                "${result.date}",
                                "${result.phone}",
                                "${result.deliveryAddress}",
                                result.longitude,
                                result.longitude,
                                result.deliveryDate,
                                result.deliveryTime)
                          ],
                        ),
                      ),
                      (this.widget.orderStatus == "6")
                          ? new Container(
                              height: 60,
                              width: MediaQuery.of(context).size.width,
                              color: AppColor.white.withAlpha(0),
                              padding: new EdgeInsets.only(
                                  top: 0, bottom: 10, left: 35, right: 35),
                              child: new GestureDetector(
                                onTap: () {},
                                child: new Material(
                                  color: AppColor.red,
                                  borderRadius: new BorderRadius.circular(50),
                                  child: new InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SignatureScreen(
                                                    date: result.date,
                                                    deliveryAddress:
                                                        result.deliveryAddress,
                                                    orderId: result.orderId,
                                                    paymentTYpe:
                                                        result.paymentType,
                                                    resAddress: result.address,
                                                    resName: result.name,
                                                    userId: this.widget.userId,
                                                  )));
                                    },
                                    child: new Container(
                                      child: new Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          setCommonText(
                                              "${S.current.delivered}",
                                              AppColor.white,
                                              16.0,
                                              FontWeight.w500,
                                              1),
                                          // SizedBox(width:5),
                                          // Icon(Icons.check,color:AppColor.white)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : new Text(''),
                      SizedBox(height: 10)
                    ],
                  ),
                );
              } else {
                return new Center(
                  child: new CircularProgressIndicator(),
                );
              }
            }));
  }
}

//1 received
//2 accept
//3 declined
//4 preparing
//5 delivered
//1=> COD, 2=>Stripe, 3=>Paypal
