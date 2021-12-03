import 'package:delivery_boy/Helper/CommonWidgets.dart';
import 'package:delivery_boy/Helper/Constant.dart';
import 'package:delivery_boy/generated/i18n.dart';
import 'package:flutter/material.dart';

void main() => runApp(new IdentityCard());

class IdentityCard extends StatefulWidget {
  final String age;
  final String gender;
  final String address;
  final String identity;
  final String drivingLicence;
  final String driverNo;
  final String email;
  final String profile;
  final String name;
  IdentityCard(
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
  _IdentityCardState createState() => _IdentityCardState();
}

class _IdentityCardState extends State<IdentityCard> {
  identityCardView() {
    return new Container(
      padding: new EdgeInsets.all(15),
      child: new Material(
        color: AppColor.white,
        elevation: 1.0,
        borderRadius: BorderRadius.circular(5),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  setCommonText('${S.current.food_zone}', AppColor.red, 30.0,
                      FontWeight.w800, 1),
                  setCommonText('${S.current.multivendor_res}', AppColor.grey,
                      16.0, FontWeight.w500, 1),
                  SizedBox(height: 20),
                  new CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(this.widget.profile)),
                  SizedBox(height: 10),
                  setCommonText('${this.widget.name}', AppColor.black54, 20.0,
                      FontWeight.w500, 1),
                  SizedBox(height: 5),
                  setCommonText(
                      '${S.current.age}: ${this.widget.age} ${S.current.years}',
                      AppColor.black54,
                      16.0,
                      FontWeight.w400,
                      1),
                  SizedBox(height: 5),
                  setCommonText('${S.current.hom_pin}: ${this.widget.identity}',
                      AppColor.black54, 16.0, FontWeight.w400, 1),
                  SizedBox(height: 5),
                  setCommonText('${this.widget.address}', AppColor.black54,
                      16.0, FontWeight.w400, 1),
                  SizedBox(height: 5),
                  setCommonText('Flashliver S.A', AppColor.black54, 16.0,
                      FontWeight.w400, 1),
                  SizedBox(height: 5),
                ],
              ),
            ),
            new Container(
              color: AppColor.amber[800],
              width: MediaQuery.of(context).size.width,
              // height: 100,
              child: new Padding(
                padding: new EdgeInsets.all(10.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        setCommonText('${this.widget.driverNo}', AppColor.white,
                            12.0, FontWeight.w400, 1),
                        SizedBox(width: 6),
                        setCommonText(
                            '${S.current.email} - ${this.widget.email}',
                            AppColor.white,
                            12.0,
                            FontWeight.w400,
                            2),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setCommonAppBar('${S.current.identity_card}', false, context),
      body: new Container(
        color: AppColor.grey[100],
        child: new ListView(
          children: <Widget>[identityCardView()],
        ),
      ),
    );
  }
}
