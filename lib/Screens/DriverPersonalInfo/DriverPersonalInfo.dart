import 'package:delivery_boy/Helper/CommonWidgets.dart';
import 'package:delivery_boy/Helper/Constant.dart';
import 'package:delivery_boy/Screens/IdentityCard/IdentityCard.dart';
import 'package:delivery_boy/generated/i18n.dart';
import 'package:flutter/material.dart';

void main() => runApp(new DriverPersonalInfo());

class DriverPersonalInfo extends StatefulWidget {
  final String age;
  final String gender;
  final String address;
  final String identity;
  final String drivingLicence;
  final String driverNo;
  final String email;
  final String profile;
  final String name;

  DriverPersonalInfo(
      {this.age,
      this.address,
      this.gender,
      this.identity,
      this.drivingLicence,
      this.driverNo,
      this.email,
      this.profile,
      this.name});
  @override
  _DriverPersonalInfoState createState() => _DriverPersonalInfoState();
}

class _DriverPersonalInfoState extends State<DriverPersonalInfo> {
  setPersonalInfoWidget() {
    return new Container(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Padding(
            padding: new EdgeInsets.only(left: 15, right: 15),
            child: setCommonText(S.current.personal_info, AppColor.black87,
                14.0, FontWeight.w500, 1),
          ),
          SizedBox(height: 5),
          new Container(
            color: AppColor.white,
            padding: new EdgeInsets.only(left: 25, right: 25),
            child: new Column(
              children: <Widget>[
                SizedBox(height: 25),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        setCommonText('${S.current.age}', AppColor.grey, 14.0,
                            FontWeight.w500, 1),
                        setCommonText('${this.widget.age} ${S.current.years}',
                            AppColor.black87, 12.0, FontWeight.w500, 1),
                      ],
                    ),
                    new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        setCommonText('${S.current.gender}', AppColor.grey,
                            14.0, FontWeight.w500, 1),
                        setCommonText('${this.widget.gender}', AppColor.black87,
                            12.0, FontWeight.w500, 1),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 20),
                new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    setCommonText('${S.current.address}', AppColor.grey, 14.0,
                        FontWeight.w500, 1),
                    setCommonText('${this.widget.address}', AppColor.black87,
                        12.0, FontWeight.w400, 2),
                  ],
                ),
              ],
            ),
          ),
          new Container(
            height: 70,
            color: AppColor.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Divider(color: AppColor.grey),
                Padding(
                  padding: new EdgeInsets.only(left: 25, right: 25),
                  child: new InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => IdentityCard(
                              age: this.widget.age,
                              address: this.widget.address,
                              gender: this.widget.gender,
                              identity: this.widget.identity,
                              drivingLicence: this.widget.drivingLicence,
                              driverNo: this.widget.driverNo,
                              email: this.widget.email,
                              profile: this.widget.profile,
                              name: this.widget.name)));
                    },
                    child: new Container(
                      child: setCommonText('${S.current.view_id_card}',
                          AppColor.red, 14.0, FontWeight.w500, 1),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  documentWidget() {
    return new Container(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Padding(
            padding: new EdgeInsets.only(left: 15, right: 15),
            child: setCommonText('${S.current.document}', AppColor.black87,
                14.0, FontWeight.w500, 1),
          ),
          SizedBox(height: 5),
          new Container(
            color: AppColor.white,
            padding: new EdgeInsets.only(left: 25, right: 25),
            child: new Column(
              children: <Widget>[
                SizedBox(height: 15),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        setCommonText('${S.current.pan}', AppColor.grey, 14.0,
                            FontWeight.w500, 1),
                        setCommonText('${this.widget.identity}',
                            AppColor.black87, 12.0, FontWeight.w400, 1),
                      ],
                    ),
                    new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        setCommonText('${S.current.driving_license}',
                            AppColor.grey, 14.0, FontWeight.w500, 1),
                        setCommonText('${this.widget.drivingLicence}',
                            AppColor.black87, 12.0, FontWeight.w500, 1),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 15),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setCommonAppBar('${S.current.personal_info}', false, context),
      body: new Container(
        color: AppColor.grey[100],
        child: new ListView(
          children: <Widget>[
            SizedBox(height: 25),
            setPersonalInfoWidget(),
            SizedBox(height: 25),
            documentWidget()
          ],
        ),
      ),
    );
  }
}
