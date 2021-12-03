import 'package:delivery_boy/Helper/CommonWidgets.dart';
import 'package:delivery_boy/Helper/Constant.dart';
import 'package:delivery_boy/Model/ModelOrderDetails.dart';
import 'package:delivery_boy/generated/i18n.dart';
import 'package:flutter/material.dart';

class OrderDetailsWidget extends StatelessWidget {
  final List<Products> orderlist;
  OrderDetailsWidget(this.orderlist);
  @override
  Widget build(BuildContext context) {
    return new Container(
      // color: AppColor.red,
      // height: (itemList.length * 95.0) + 20,
      padding: new EdgeInsets.only(left: 10, right: 10),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            // height: 45,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                setCommonText(S.current.your_orders, AppColor.themeColor, 15.0,
                    FontWeight.w500, 1),
                Divider(
                  color: AppColor.grey[400],
                ),
              ],
            ),
          ),
          new Container(
            height: (orderlist.length * 80.0),
            // color: AppColor.purple,
            child: new ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: orderlist.length,
              itemBuilder: (context, index) {
                return new Container(
                  // height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Row(
                        children: <Widget>[
                          new Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: '1' == "1"
                                        ? AssetImage(
                                            'Assets/RestaurantDetails/veg.png')
                                        : AssetImage(
                                            'Assets/RestaurantDetails/nonVeg.png'))),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          setCommonText('${orderlist[index].productName}',
                              AppColor.black, 14.0, FontWeight.w500, 2),
                        ],
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      setCommonText(orderlist[index].description,
                          AppColor.grey[500], 12.0, FontWeight.w400, 2),
                      SizedBox(
                        height: 5,
                      ),
                      // new Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: <Widget>[
                      //     new Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       children: <Widget>[
                      //         setCommonText('2', AppColor.black, 13.0, FontWeight.w500,1),
                      //         SizedBox(width: 3,),
                      //         setCommonText('x', AppColor.black, 13.0, FontWeight.w500,1),
                      //         SizedBox(width: 3,),
                      //         setCommonText('\$"320"', AppColor.black, 13.0, FontWeight.w500,1),
                      //       ],
                      //     ),
                      //     setCommonText('\$320', AppColor.black, 13.0, FontWeight.w500,1),
                      //   ],
                      // ),
                      Divider(
                        color: AppColor.grey,
                      )
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
