import 'package:delivery_boy/Helper/CommonWidgets.dart';
import 'package:delivery_boy/Helper/Constant.dart';
import 'package:delivery_boy/Helper/Languages.dart';
import 'package:delivery_boy/Helper/SharedManaged.dart';
import 'package:delivery_boy/Screens/TabBarScreens/TabBar/TabBarScreen.dart';
import 'package:delivery_boy/generated/i18n.dart';
import 'package:flutter/material.dart';

void main() => runApp(new LanguageScreen());

class LanguageScreen extends StatefulWidget {
  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  LanguagesList languagesList;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    languagesList = new LanguagesList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColor.themeColor,
        centerTitle: true,
        title: setCommonText(
            S.current.languages, AppColor.white, 20.0, FontWeight.w500, 1),
      ),
      body: new Container(
          child: Column(
        children: <Widget>[
          new Container(
            height: 50,
            padding: new EdgeInsets.only(left: 25, right: 15),
            child: new Row(
              children: <Widget>[
                Icon(Icons.language, color: AppColor.grey),
                SizedBox(width: 10),
                new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    setCommonText(S.current.languages, AppColor.grey, 16.0,
                        FontWeight.w700, 1),
                    setCommonText(S.current.select_your_preferred_languages,
                        AppColor.grey, 13.0, FontWeight.w400, 1),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 25),
          new Expanded(
              child: new Container(
            child: new ListView.builder(
                itemCount: languagesList.languages.length,
                itemBuilder: (context, index) {
                  return new Container(
                    // height: 70,
                    padding: new EdgeInsets.only(
                        left: 15, right: 15, top: 2, bottom: 2),
                    child: new InkWell(
                      onTap: () {
                        setState(() async {
                          SharedManager.shared.locale.value =
                              Locale(languagesList.languages[index].code, '');
                          ScaffoldMessenger.of(context).removeCurrentSnackBar();
                          Navigator.of(context, rootNavigator: true)
                              .pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => TabBarScreen()),
                                  ModalRoute.withName(AppRoute.tabbar));
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: 10),
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                            image: AssetImage(languagesList
                                                .languages[index].flag))),
                                  ),
                                  SizedBox(width: 15),
                                  setCommonText(
                                      languagesList.languages[index].localName,
                                      AppColor.black87,
                                      18.0,
                                      FontWeight.w400,
                                      1)
                                ],
                              ),
                              Icon(Icons.arrow_forward_ios,
                                  size: 17, color: AppColor.black87)
                            ],
                          ),
                          SizedBox(height: 10),
                          Divider()
                        ],
                      ),
                    ),
                  );
                }),
          ))
        ],
      )),
    );
  }
}
