import 'package:delivery_boy/Helper/CommonWidgets.dart';
import 'package:delivery_boy/Helper/Constant.dart';
import 'package:delivery_boy/Helper/LocationManager.dart';
import 'package:delivery_boy/Helper/RequestManager.dart';
import 'package:delivery_boy/Helper/SharedManaged.dart';
import 'package:delivery_boy/Screens/TabBarScreens/TabBar/TabBarScreen.dart';
import 'package:delivery_boy/generated/i18n.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Helper/SharedManaged.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  bool validateCredential() {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);

    if (_emailController.text == "") {
      SharedManager.shared
          .showAlertDialog('${S.current.enter_emil_address}', context);
      return false;
    }
    final emalValidation = isEmail(_emailController.text);
    if (!emalValidation) {
      SharedManager.shared
          .showAlertDialog('${S.current.invalid_email}', context);
      return false;
    } else if (_passwordController.text == "") {
      SharedManager.shared
          .showAlertDialog('${S.current.enter_valid_password}', context);
      return false;
    } else if (!regExp.hasMatch(_passwordController.text)) {
      SharedManager.shared
          .showAlertDialog('${S.current.enter_valid_password}', context);
      return false;
    }

    return true;
  }

  setIconWidgets() {
    return new Container(
      height: 150,
      // color:AppColor.amber,
      child: new Align(
          alignment: Alignment.bottomCenter,
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              new Container(
                height: 80,
                width: 80,
                padding: new EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: AppColor.themeColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: new Image(
                  image: AssetImage('Assets/images/foodTruck.png'),
                ),
              ),
              SizedBox(height: 8),
              setCommonText("${S.current.food_zone}", AppColor.themeColor, 20.0,
                  FontWeight.w700, 1)
            ],
          )),
    );
  }

  setLoginWidgets() {
    return new Container(
      padding: new EdgeInsets.only(left: 25, right: 25),
      // color:AppColor.red,
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: setCommonText('${S.current.signIn}', AppColor.black, 23.0,
                FontWeight.w800, 1),
          ),
          SizedBox(height: 30),
          new Container(
            height: 80,
            // color: Colors.white,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                setCommonText('${S.current.email}', AppColor.black38, 15.0,
                    FontWeight.w500, 1),
                SizedBox(height: 5),
                new Container(
                  height: 45,
                  padding: new EdgeInsets.only(left: 8, right: 8),
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "${S.current.enter_email}"),
                    style: TextStyle(
                        fontSize: 13,
                        fontFamily: SharedManager.shared.fontFamilyName,
                        fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 15),
          new Container(
            height: 80,
            // color: Colors.white,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                setCommonText('${S.current.password}', AppColor.black38, 15.0,
                    FontWeight.w500, 1),
                SizedBox(height: 5),
                new Container(
                  height: 45,
                  padding: new EdgeInsets.only(left: 8, right: 8),
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "${S.current.enter_password}"),
                    style: TextStyle(
                        fontSize: 13,
                        fontFamily: SharedManager.shared.fontFamilyName,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5),
          new Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              new InkWell(
                onTap: () {
                  SharedManager.shared.showAlertDialog(
                      '${S.current.contact_your_admin}', context);
                },
                child: new Container(
                  child: setCommonText('${S.current.forgot_password}',
                      AppColor.black38, 15.0, FontWeight.w500, 1),
                ),
              )
            ],
          ),
          SizedBox(height: 50),
          new InkWell(
            onTap: () async {
              // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>TabBarScreen()));
              final status = validateCredential();
              if (status) {
                final param = {
                  "email": _emailController.text,
                  "password": _passwordController.text,
                  "device_token": SharedManager.shared.token,
                  "latitude": "${SharedManager.shared.latitude}",
                  "longitude": "${SharedManager.shared.longitude}"
                };
                showSnackbar("${S.current.loading}", scaffoldKey, context);
                final reqManager = Requestmanager();
                final result =
                    await reqManager.loginWithDriverCredentials(param);
                print("Driver Login Details:$result");
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                if (result.code == 1) {
                  //Store user id and all things here.
                  final userData = result.result;
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.setString(DefaultKeys.userId, userData.driverId);
                  await prefs.setString(DefaultKeys.userName, userData.name);
                  await prefs.setString(DefaultKeys.userEmail, userData.email);
                  await prefs.setString(
                      DefaultKeys.userImage, userData.profileImage);
                  await prefs.setString(DefaultKeys.userPhone, userData.phone);
                  await prefs.setString(
                      DefaultKeys.userAddress, userData.address);
                  SharedManager.shared.userID = userData.driverId;
                  //Login status
                  await SharedManager.shared.storeString("yes", "isLoogedIn");

                  Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => TabBarScreen()),
                      ModalRoute.withName(AppRoute.tabbar));
                } else {
                  SharedManager.shared
                      .showAlertDialog('${result.message}', context);
                }
              } else {
                // HapticFeedback.vibrate();

              }
            },
            child: new Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                padding: new EdgeInsets.only(left: 8, right: 8),
                decoration: BoxDecoration(
                  color: AppColor.themeColor,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Center(
                  child: setCommonText('${S.current.signIn}', AppColor.white,
                      16.0, FontWeight.w500, 1),
                )),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  getCurrentLocation() async {
    await LocationManager.shared.getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: new Container(
        color: AppColor.grey[200],
        child: new ListView(
          children: <Widget>[
            setIconWidgets(),
            SizedBox(height: 40),
            setLoginWidgets(),
          ],
        ),
      ),
    );
  }
}
