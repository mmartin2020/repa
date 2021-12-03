import 'package:delivery_boy/BLoC/MainModelBlocClass/OrderListBloc.dart';
import 'package:delivery_boy/Helper/CommonWidgets.dart';
import 'package:delivery_boy/Helper/Constant.dart';
import 'package:delivery_boy/Helper/LocationManager.dart';
import 'package:delivery_boy/Helper/RequestManager.dart';
import 'package:delivery_boy/Helper/SharedManaged.dart';
import 'package:delivery_boy/Model/ModelOrderList.dart';
import 'package:delivery_boy/Screens/OrderSummary/OrderSummary.dart';
import 'package:delivery_boy/generated/i18n.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(new DashboardScreen());

class DashboardScreen extends StatefulWidget {
  method() => createState().updateOrderListData();

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var userID = "";
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  _setOrderList(List<Order> orderList) {
    return new ListView.builder(
        itemCount: orderList.length,
        itemBuilder: (context, index) {
          return new InkWell(
            onTap: () async {
              if (orderList[index].driverStatus != "0") {
                if (orderList[index].name != null) {
                  final status =
                      await Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => OrderSummary(
                                orderId: orderList[index].orderId,
                                orderStatus: orderList[index].orderStatus,
                                userId: orderList[index].userId,
                                resImage: orderList[index].bannerImage,
                              )));

                  if (status == null || status == true) {
                    setState(() {});
                  }
                }
              } else {
                SharedManager.shared.showAlertDialog(
                    "${S.current.before_accept_order}", context);
              }
            },
            child: new Container(
              height: 180,
              padding:
                  new EdgeInsets.only(left: 15, right: 15, top: 7, bottom: 7),
              child: Container(
                  decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: new BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 1,
                            spreadRadius: 0,
                            color: AppColor.grey,
                            offset: Offset(0, 0))
                      ]),
                  child: new Column(
                    children: <Widget>[
                      new Expanded(
                          flex: 5,
                          child: new Container(
                            padding: new EdgeInsets.only(
                                left: 10, right: 15, top: 10, bottom: 5),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              orderList[index].bannerImage),
                                          // AssetImage(
                                          //     'Assets/RestaurantDetails/RestaurantApp.jpg'),
                                          fit: BoxFit.cover),
                                      borderRadius: BorderRadius.circular(8)),
                                ),
                                SizedBox(width: 8),
                                new Expanded(
                                    child: new Container(
                                  child: new Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      setCommonText(
                                          (orderList[index].name == null)
                                              ? "${S.current.dummy_name}"
                                              : orderList[index].name,
                                          AppColor.black,
                                          14.0,
                                          FontWeight.w500,
                                          2),
                                      SizedBox(height: 3),
                                      setCommonText(
                                          (orderList[index].address == null)
                                              ? "${S.current.dummy_Address}"
                                              : orderList[index].address,
                                          AppColor.grey[600],
                                          12.0,
                                          FontWeight.w400,
                                          2),
                                      // SizedBox(height: 10),
                                      Divider(
                                        color: AppColor.black38,
                                      ),
                                      new Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              setCommonText(
                                                  "${S.current.order_ID} : ",
                                                  AppColor.themeColor,
                                                  13.0,
                                                  FontWeight.w400,
                                                  2),
                                              setCommonText(
                                                  "#${orderList[index].orderId}",
                                                  AppColor.grey[800],
                                                  12.0,
                                                  FontWeight.w400,
                                                  2),
                                            ],
                                          ),
                                          setCommonText(
                                              "\$${orderList[index].totalPrice}",
                                              AppColor.black,
                                              12.0,
                                              FontWeight.w400,
                                              2),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: <Widget>[
                                          setCommonText(
                                              "Entrega en: ",
                                              AppColor.red,
                                              13.0,
                                              FontWeight.w600,
                                              2),
                                          setCommonText(
                                              "${orderList[index].deliveryDate} at ${orderList[index].deliveryTime}",
                                              AppColor.grey[800],
                                              12.0,
                                              FontWeight.w400,
                                              2),
                                        ],
                                      ),
                                    ],
                                  ),
                                )),
                              ],
                            ),
                          )),
                      new Container(
                        padding: new EdgeInsets.only(left: 15, right: 15),
                        // color: Colors.green
                        child: (orderList[index].driverStatus == "0")
                            ? new Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  new InkWell(
                                    onTap: () async {
                                      print("Accept Button Tapped");
                                      await acceptRejectOrder(
                                              '1', orderList[index].orderId)
                                          .then((value) {
                                        ScaffoldMessenger.of(context)
                                            .hideCurrentSnackBar();
                                        print(value);
                                        setState(() {
                                          orderListBloc
                                              .getAllOrderList(this.userID);
                                        });
                                      });
                                    },
                                    child: new Container(
                                      height: 26,
                                      decoration: BoxDecoration(
                                          color: AppColor.themeColor,
                                          borderRadius:
                                              BorderRadius.circular(13)),
                                      child: new Center(
                                          child: setCommonText(
                                              "    ${S.current.accept}    ",
                                              AppColor.white,
                                              12.0,
                                              FontWeight.w400,
                                              1)),
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  InkWell(
                                    onTap: () async {
                                      print("Reject Button Tapped");
                                      await acceptRejectOrder(
                                              '2', orderList[index].orderId)
                                          .then((value) {
                                        ScaffoldMessenger.of(context)
                                            .hideCurrentSnackBar();
                                        print(value);
                                        setState(() {
                                          orderListBloc
                                              .getAllOrderList(this.userID);
                                        });
                                      });
                                    },
                                    child: new Container(
                                      height: 26,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(13),
                                          border:
                                              Border.all(color: AppColor.red)),
                                      child: new Center(
                                          child: setCommonText(
                                              "    ${S.current.reject}    ",
                                              AppColor.red,
                                              12.0,
                                              FontWeight.w400,
                                              1)),
                                    ),
                                  ),
                                ],
                              )
                            : (orderList[index].orderStatus != "6")
                                ? new Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      new InkWell(
                                        onTap: () async {
                                          print("Accept Button Tapped");
                                          await pickedUpFromTheRestaurant(
                                                  orderList[index].orderId,
                                                  orderList[index].orderId)
                                              .then((value) {
                                            ScaffoldMessenger.of(context)
                                                .hideCurrentSnackBar();
                                            print(value);
                                            setState(() {
                                              orderListBloc
                                                  .getAllOrderList(this.userID);
                                            });
                                          });
                                        },
                                        child: new Container(
                                          height: 30,
                                          decoration: BoxDecoration(
                                              color: AppColor.themeColor,
                                              borderRadius:
                                                  BorderRadius.circular(16)),
                                          child: new Center(
                                              child: setCommonText(
                                                  "   ${S.current.pickup_order}   ",
                                                  AppColor.white,
                                                  12.0,
                                                  FontWeight.w500,
                                                  1)),
                                        ),
                                      ),
                                    ],
                                  )
                                : new Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      new InkWell(
                                        onTap: () async {},
                                        child: new Container(
                                          height: 30,
                                          decoration: BoxDecoration(
                                              color: AppColor.red,
                                              borderRadius:
                                                  BorderRadius.circular(16)),
                                          child: new Center(
                                              child: setCommonText(
                                                  "   ${S.current.order_picked_up}  ",
                                                  AppColor.white,
                                                  12.0,
                                                  FontWeight.w500,
                                                  1)),
                                        ),
                                      ),
                                    ],
                                  ),
                      ),
                      SizedBox(height: 10),
                    ],
                  )),
            ),
          );
        });
  }

//1:- Accept
//2:- reject

  Future<bool> acceptRejectOrder(String orderStatus, String orderId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userID = prefs.getString(DefaultKeys.userId);

    var param = {"status": orderStatus, "order_id": orderId, "user_id": userID};
    print("Accepr Reject Order Status:$param");

    showSnackbar('${S.current.loading}', scaffoldKey, context);
    final reqManager = Requestmanager();
    bool status = false;
    await reqManager.acceptRejectOrderStatus(param).then((value) {
      status = value;
    });
    return status;
  }

  Future<bool> pickedUpFromTheRestaurant(String orderId, String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final driveriD = prefs.getString(DefaultKeys.userId);

    var param = {
      "latitude": "${SharedManager.shared.latitude}",
      "longitude": "${SharedManager.shared.longitude}",
      "status": "6",
      "signature": "",
      "order_id": orderId,
      "driver_id": driveriD,
      "user_id": userId
    };
    print("Accepr Reject Order Status:$param");

    showSnackbar('${S.current.loading}', scaffoldKey, context);
    final reqManager = Requestmanager();
    bool status = false;
    await reqManager.pickuOrederFromTheRestaurant(param).then((value) {
      status = value;
    });
    return status;
  }

  @override
  void initState() {
    super.initState();
    getUserID();
    if (SharedManager.shared.timer != null) {
      SharedManager.shared.timer.cancel();
    }
    SharedManager.shared.setTimerMethod();
  }

  getUserID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this.userID = prefs.getString(DefaultKeys.userId);
    SharedManager.shared.userID = this.userID;
    orderListBloc.getAllOrderList(this.userID);
    await LocationManager.shared.getCurrentLocation();
  }

//This is callback function
  updateOrderListData() =>
      orderListBloc.getAllOrderList(SharedManager.shared.userID);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: setCommonAppBar("${S.current.orders}", true, context),
      body: StreamBuilder(
          stream: orderListBloc.getOrderList,
          builder: (context, AsyncSnapshot<ResOrderList> snapshot) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            SharedManager.shared.isNotificationComes = false;
            if (snapshot.hasData) {
              final result = snapshot.data.orderList;
              return new Container(
                color: AppColor.white,
                child: result.length > 0
                    ? _setOrderList(result)
                    : orderIsNotAvailable(
                        "${S.current.newOrder_not_assigned}", "", context),
              );
            } else {
              return new Center(
                child: new CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
