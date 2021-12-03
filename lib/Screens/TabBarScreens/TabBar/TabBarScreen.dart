import 'package:delivery_boy/Helper/Constant.dart';
import 'package:delivery_boy/Helper/SharedManaged.dart';
import 'package:delivery_boy/Screens/TabBarScreens/DashboardScreen/DashboardScreen.dart';
import 'package:delivery_boy/Screens/TabBarScreens/OrderHistoryScreen/OrderHistroy.dart';
import 'package:delivery_boy/Screens/TabBarScreens/ProfileScreen/ProfileScreen.dart';
import 'package:flutter/material.dart';

void main() => runApp(new TabBarScreen());

class TabBarScreen extends StatefulWidget {
  @override
  _TabBarScreenState createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  final List<Widget> _children = [
    OrderHistroy(),
    DashboardScreen(),
    ProfileScreen()
  ];

  _onTapped(int index) {
    setState(() {
      print("index $index");
      SharedManager.shared.isFromTab = true;
      SharedManager.shared.currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: _children[SharedManager.shared.currentIndex],
      bottomNavigationBar: new BottomNavigationBar(
        backgroundColor: AppColor.white,
        type: BottomNavigationBarType
            .fixed, //if you remove this tab bar will white.
        currentIndex: SharedManager.shared.currentIndex,
        onTap: _onTapped,
        items: [
          BottomNavigationBarItem(
              icon: new Icon(Icons.local_shipping, size: 25),
              activeIcon: new Icon(Icons.local_shipping,
                  color: AppColor.themeColor, size: 25),
              label: ''
              // title: setCommonText(
              //     '',
              //     (SharedManager.shared.currentIndex == 0)
              //         ? AppColor.themeColor
              //         : null,
              //     1.0,
              //     FontWeight.w500,
              //     1)
              ),
          BottomNavigationBarItem(
              icon: new Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.grey[400],
                        blurRadius:
                            10.0, // has the effect of softening the shadow
                        spreadRadius:
                            3.0, // has the effect of extending the shadow
                        offset: Offset(
                          0.0, // horizontal, move right 10
                          0.0, // vertical, move down 10
                        ),
                      )
                    ],
                    color: AppColor.themeColor,
                    borderRadius: new BorderRadius.circular(20),
                  ),
                  child: new Center(
                    child: new Icon(Icons.home, color: AppColor.white),
                  )),
              label: ''
              // title: setCommonText(
              //     '',
              //     (SharedManager.shared.currentIndex == 2)
              //         ? AppColor.themeColor
              //         : null,
              //     1.0,
              //     FontWeight.w500,
              //     1)
              ),
          BottomNavigationBarItem(
              icon: new Icon(Icons.person, size: 25),
              activeIcon:
                  new Icon(Icons.person, color: AppColor.themeColor, size: 25),
              label: ''
              // title: setCommonText(
              //     '',
              //     (SharedManager.shared.currentIndex == 3)
              //         ? AppColor.themeColor
              //         : null,
              //     1.0,
              //     FontWeight.w500,
              //     1)
              ),
        ],
      ),
    );
  }
}
