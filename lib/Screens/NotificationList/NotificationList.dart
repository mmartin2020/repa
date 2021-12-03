import 'package:delivery_boy/BLoC/MainModelBlocClass/NotificationBloc.dart';
import 'package:delivery_boy/Helper/CommonWidgets.dart';
import 'package:delivery_boy/Helper/Constant.dart';
import 'package:delivery_boy/Model/ModelNotificationList.dart';
import 'package:delivery_boy/generated/i18n.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(new NotificationList());

class NotificationList extends StatefulWidget {
  @override
  _NotificationListState createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  String userId = "";

  @override
  void initState() {
    super.initState();
    getUserId();
  }

  getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this.userId = prefs.getString(DefaultKeys.userId);
    print(this.userId);
    notificationListBloc.getAllNotificationList(this.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: setCommonAppBar('${S.current.notification}', false, context),
        body: StreamBuilder(
            stream: notificationListBloc.getNotificationLits,
            builder: (context, AsyncSnapshot<ResNotificationList> snapshot) {
              if (snapshot.hasData) {
                final result = snapshot.data.notificationList;
                return new Container(
                  child: ListView.builder(
                      itemCount: result.length,
                      itemBuilder: (context, index) {
                        return new Container(
                          padding: new EdgeInsets.only(
                              left: 10, right: 10, top: 5, bottom: 5),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              new Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'Assets/images/foodTruck.png'),
                                        fit: BoxFit.fill)),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              new Expanded(
                                  child: new Container(
                                padding: new EdgeInsets.only(
                                    left: 10, right: 10, top: 5, bottom: 5),
                                child: new Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    setCommonText(
                                        '${S.current.order} #${result[index].typeId} ${S.current.assigned_to_you}',
                                        AppColor.black,
                                        16.0,
                                        FontWeight.w500,
                                        1),
                                    SizedBox(height: 2),
                                    setCommonText(
                                        '${result[index].date}',
                                        AppColor.grey,
                                        14.0,
                                        FontWeight.w400,
                                        1),
                                    SizedBox(height: 2),
                                    Row(
                                      children: <Widget>[
                                        setCommonText(
                                            '${S.current.order_ID}:',
                                            AppColor.grey[800],
                                            14.0,
                                            FontWeight.w400,
                                            1),
                                        SizedBox(width: 2),
                                        setCommonText(
                                            "#${result[index].typeId}",
                                            AppColor.grey[700],
                                            14.0,
                                            FontWeight.w400,
                                            1),
                                      ],
                                    ),
                                    Divider()
                                  ],
                                ),
                              ))
                            ],
                          ),
                        );
                      }),
                );
              } else {
                return new Center(
                  child: new CircularProgressIndicator(),
                );
              }
            }));
  }
}
