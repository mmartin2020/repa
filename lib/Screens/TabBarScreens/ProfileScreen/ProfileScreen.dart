import 'package:delivery_boy/BLoC/MainModelBlocClass/ProfileDataBLoC.dart';
import 'package:delivery_boy/Helper/CommonWidgets.dart';
import 'package:delivery_boy/Helper/Constant.dart';
import 'package:delivery_boy/Helper/RequestManager.dart';
import 'package:delivery_boy/Helper/SharedManaged.dart';
import 'package:delivery_boy/Model/ModelProfileData.dart';
import 'package:delivery_boy/Screens/DriverPersonalInfo/DriverPersonalInfo.dart';
import 'package:delivery_boy/Screens/DriverReviewScreen.dart/DriverReview.dart';
import 'package:delivery_boy/Screens/LanguageScreen/LanguageScreen.dart';
import 'package:delivery_boy/Screens/LoginScreen/LoginScreen.dart';
import 'package:delivery_boy/generated/i18n.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(new ProfileScreen());

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isAvailable = true;
  String userId = '';
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  profileView(
      String image, String name, String tip, Profile result, String review) {
    return Container(
      // height: 180,
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Padding(
            padding: new EdgeInsets.only(left: 15, right: 15, top: 15),
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new CircleAvatar(
                  radius: 35,
                  backgroundImage: NetworkImage('$image'),
                  // backgroundImage: AssetImage('Assets/RestaurantDetails/profileImage.jpg'),
                ),
                SizedBox(width: 15),
                Expanded(
                    child: new Container(
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      setCommonText(
                          '$name', AppColor.black, 16.0, FontWeight.w500, 1),
                      SizedBox(
                        height: 5,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context, rootNavigator: true).push(
                              MaterialPageRoute(
                                  builder: (context) => ReviewListScreen()));
                        },
                        child: new Container(
                          height: 20,
                          width: 40,
                          color: AppColor.themeColor,
                          child: new Center(
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                setCommonText(
                                    (review == null) ? '0.0' : '$review',
                                    AppColor.white,
                                    12.0,
                                    FontWeight.w600,
                                    1),
                                Icon(Icons.star, color: Colors.white, size: 13)
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      new InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => DriverPersonalInfo(
                                  age: result.age,
                                  address: result.permenentAddress,
                                  gender: result.gender,
                                  identity: result.identityNumber,
                                  drivingLicence: result.licenseNumber,
                                  driverNo: result.phone,
                                  email: result.email,
                                  profile: result.profileImage,
                                  name: result.name)));
                        },
                        child: new Container(
                          child: setCommonText(
                              '${S.current.view_personal_info}',
                              AppColor.amber,
                              14.0,
                              FontWeight.w500,
                              1),
                        ),
                      )
                    ],
                  ),
                ))
              ],
            ),
          ),
          SizedBox(height: 23),
          new Container(height: 1, color: AppColor.grey[300]),
          new Row(
            children: <Widget>[
              new Expanded(
                  child: new Container(
                height: 50,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    setCommonText('${S.current.total_tip}', AppColor.black87,
                        15.0, FontWeight.w500, 1),
                    SizedBox(height: 3),
                    setCommonText((tip == null) ? '\$0.0' : '\$$tip',
                        AppColor.grey, 12.0, FontWeight.w400, 1)
                  ],
                ),
              )),
              new Container(height: 50, width: 1, color: AppColor.grey[300]),
              new Expanded(
                  child: new Container(
                height: 50,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    setCommonText('${S.current.safety_Badge}', AppColor.black87,
                        14.0, FontWeight.w500, 1),
                    SizedBox(height: 3),
                    setCommonText('35', AppColor.grey, 12.0, FontWeight.w500, 1)
                  ],
                ),
              )),
            ],
          ),
          new Container(height: 1, color: AppColor.grey[300]),
        ],
      ),
    );
  }

  performanceWidgete(String orderDeliveried, String orderRejected) {
    return new Container(
      color: AppColor.grey[100],
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Padding(
            padding: new EdgeInsets.all(10),
            child: setCommonText('${S.current.orders}', AppColor.black87, 14.0,
                FontWeight.w500, 1),
          ),
          new Container(
            height: 130,
            color: AppColor.white,
            padding: new EdgeInsets.only(left: 15, right: 15),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    setCommonText('${S.current.delivered_order}', AppColor.grey,
                        14.0, FontWeight.w600, 1),
                    setCommonText('$orderDeliveried', AppColor.grey, 12.0,
                        FontWeight.w400, 1),
                  ],
                ),
                Divider(color: AppColor.grey),
                new Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    setCommonText('${S.current.canceled_order}', AppColor.grey,
                        14.0, FontWeight.w600, 1),
                    setCommonText('3', AppColor.grey, 12.0, FontWeight.w600, 1),
                  ],
                ),
                Divider(color: AppColor.grey),
                new Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    setCommonText('${S.current.rejected_order}', AppColor.grey,
                        14.0, FontWeight.w600, 1),
                    setCommonText('$orderRejected', AppColor.grey, 12.0,
                        FontWeight.w600, 1),
                  ],
                )
              ],
            ),
          ),
          new Container(
            height: 1,
            color: AppColor.grey[300],
          )
        ],
      ),
    );
  }

  availabilityWidget() {
    return new Container(
      color: AppColor.grey[100],
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Padding(
            padding: new EdgeInsets.all(15),
            child: setCommonText('${S.current.availability}', AppColor.black87,
                15.0, FontWeight.w500, 1),
          ),
          new Container(
            height: 50,
            color: AppColor.white,
            padding: new EdgeInsets.only(left: 10, right: 10),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Row(
                      children: <Widget>[
                        new Container(
                          height: 8,
                          width: 8,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: this.isAvailable
                                  ? AppColor.themeColor
                                  : AppColor.red),
                        ),
                        SizedBox(width: 5),
                        setCommonText('${S.current.available}', AppColor.grey,
                            13.0, FontWeight.w600, 1),
                      ],
                    ),
                    new Switch(
                        value: this.isAvailable,
                        onChanged: (value) async {
                          setState(() {
                            this.isAvailable = value;
                            print(value);
                          });
                          final reqManager = Requestmanager();
                          showSnackbar(
                              '${S.current.loading}', scaffoldKey, context);
                          final param = {
                            "driver_id": this.userId,
                            "status": (value) ? "1" : "0"
                          };
                          final status =
                              await reqManager.driverAvailability(param);
                          if (status) {
                            await SharedManager.shared.storeString(
                                value ? "yes" : "no", "isDriverAvailable");
                            ScaffoldMessenger.of(context)
                                .removeCurrentSnackBar();
                            SharedManager.shared.showAlertDialog(
                                '${S.current.driver_availibility_change}',
                                context);
                          } else {
                            ScaffoldMessenger.of(context)
                                .removeCurrentSnackBar();
                            SharedManager.shared.showAlertDialog(
                                "${S.current.try_after_sometime}", context);
                          }
                        })
                  ],
                ),
              ],
            ),
          ),
          new Container(
            height: 1,
            color: AppColor.grey[300],
          ),
          SizedBox(height: 30),
          new InkWell(
            onTap: () async {
              print("Accept Button Tapped");
              final status = await logoutUser();
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              print(status);
              if (SharedManager.shared.timer != null) {
                SharedManager.shared.timer.cancel();
              }
              if (status) {
                SharedManager.shared.currentIndex = 1;
                //Login status
                await SharedManager.shared.storeString("no", "isLoogedIn");
                Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    ModalRoute.withName(AppRoute.login));
              } else {
                SharedManager.shared.showAlertDialog(
                    "${S.current.try_after_sometime}", context);
              }
            },
            child: new Container(
              child: new Center(
                child: setCommonText('${S.current.logout}', AppColor.red, 16.0,
                    FontWeight.w600, 1),
              ),
            ),
          )
        ],
      ),
    );
  }

  logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userID = prefs.getString(DefaultKeys.userId);
    var param = {"user_id": userID};
    print("Accepr Reject Order Status:$param");
    showSnackbar('${S.current.loading}', scaffoldKey, context);
    final reqManager = Requestmanager();
    final status = await reqManager.logoutDriver(param);
    return status;
  }

  setLanguageWidget() {
    return new Container(
      color: AppColor.grey[100],
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Padding(
            padding: new EdgeInsets.all(15),
            child: setCommonText('${S.current.languages}', AppColor.black87,
                14.0, FontWeight.w500, 1),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => LanguageScreen()));
            },
            child: new Container(
              height: 50,
              color: AppColor.white,
              padding: new EdgeInsets.only(left: 10, right: 10),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Row(
                        children: <Widget>[
                          setCommonText('${S.current.change_language}',
                              AppColor.grey, 14.0, FontWeight.w600, 1),
                        ],
                      ),
                      new Icon(Icons.arrow_forward_ios,
                          color: AppColor.grey[400], size: 16)
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getUserId();
  }

  getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this.userId = prefs.getString(DefaultKeys.userId);
    profileDataBloc.getProfileData(SharedManager.shared.userID);

    final driverStatus = prefs.getString('isDriverAvailable');
    setState(() {
      if (driverStatus == "no") {
        this.isAvailable = false;
      } else {
        this.isAvailable = true;
      }
    });
    print(this.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: setCommonAppBar('${S.current.profile}', true, context),
      body: StreamBuilder(
          stream: profileDataBloc.profileData,
          builder: (context, AsyncSnapshot<ResProfileData> snapshot) {
            if (snapshot.hasData) {
              final result = snapshot.data.result;
              return new Container(
                color: AppColor.grey[100],
                child: new ListView(
                  children: <Widget>[
                    profileView(result.profileImage, result.name,
                        result.totalTip, result, result.averageReview),
                    SizedBox(height: 20),
                    performanceWidgete(result.totalDeliveredOrders,
                        result.totalRejectedOrders),
                    SizedBox(height: 20),
                    setLanguageWidget(),
                    SizedBox(height: 20),
                    availabilityWidget(),
                    SizedBox(height: 30),
                  ],
                ),
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
