import 'package:auto_size_text/auto_size_text.dart';
import 'package:delivery_boy/Helper/Constant.dart';
import 'package:delivery_boy/Helper/SharedManaged.dart';
import 'package:delivery_boy/Screens/NotificationList/NotificationList.dart';
import 'package:flutter/material.dart';

class EmptyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  Size get preferredSize => Size(0.0, 0.0);
}

//This is the common function which works whole application, which set Text with different font and color.
setCommonText(String title, dynamic color, dynamic fontSize, dynamic fontweight,
    dynamic noOfLine) {
  return new AutoSizeText(
    title,
    textDirection: SharedManager.shared.direction,
    style: new TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontweight,
      fontFamily: SharedManager.shared.fontFamilyName,
    ),
    maxLines: noOfLine,
    overflow: TextOverflow.ellipsis,
    wrapWords: true,
  );
}

setCommonAppBar(String title, bool isNotificationShow, BuildContext context) {
  return new AppBar(
    title: setCommonText(title, AppColor.white, 22.0, FontWeight.w500, 1),
    backgroundColor: AppColor.themeColor,
    elevation: 0.0,
    actions: <Widget>[
      isNotificationShow
          ? IconButton(
              icon: Icon(
                Icons.notifications,
                color: AppColor.white,
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => NotificationList()));
              })
          : new Text('')
    ],
  );
}

showSnackbar(
    String value, GlobalKey<ScaffoldState> scaffoldKey, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
      duration: Duration(seconds: 15),
      content: new Row(
        children: <Widget>[
          SizedBox(
            child: CircularProgressIndicator(),
            height: 25.0,
            width: 25.0,
          ),
          SizedBox(width: 15),
          new Expanded(
              child: setCommonText(
                  value, AppColor.white, 17.0, FontWeight.w500, 2))
        ],
      )));
}

bool isEmail(String em) {
  String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(p);
  return regExp.hasMatch(em);
}

orderIsNotAvailable(String stringMessage, String image, BuildContext context) {
  return Container(
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    padding: new EdgeInsets.all(25),
    color: AppColor.white,
    child: new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new AutoSizeText(
          stringMessage,
          textDirection: SharedManager.shared.direction,
          style: new TextStyle(
            color: AppColor.black,
            fontSize: 17.0,
            fontWeight: FontWeight.w500,
            fontFamily: SharedManager.shared.fontFamilyName,
          ),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          wrapWords: true,
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('Assets/groceryProduct.png'))),
        )
        // setCommonText(stringMessage, AppColor.red, 17.0, FontWeight.w500, 2)
      ],
    ),
  );
}
