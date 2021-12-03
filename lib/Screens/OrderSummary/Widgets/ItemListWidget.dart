import 'package:delivery_boy/Helper/CommonWidgets.dart';
import 'package:delivery_boy/Helper/Constant.dart';
import 'package:delivery_boy/generated/i18n.dart';
import 'package:flutter/material.dart';

class ItemListWidget extends StatelessWidget {
  final String totalPrice;
  final String tip;

  ItemListWidget(this.totalPrice, this.tip);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        new Container(
            // height: 150,
            padding: new EdgeInsets.only(left: 15, right: 15),
            color: AppColor.white,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Row(
                      children: <Widget>[
                        setCommonText(S.current.item_total, AppColor.black,
                            14.0, FontWeight.w500, 1),
                      ],
                    ),
                    new Row(
                      children: <Widget>[
                        setCommonText('\$$totalPrice', AppColor.black, 12.0,
                            FontWeight.w500, 1),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    setCommonText(S.current.tip, AppColor.black, 14.0,
                        FontWeight.w500, 1),
                    SizedBox(
                      width: 6,
                    ),
                    setCommonText('\$$tip', AppColor.themeColor, 12.0,
                        FontWeight.w500, 1),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Divider(
                  color: AppColor.grey,
                ),
                SizedBox(
                  height: 15,
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    setCommonText(S.current.grand_total, AppColor.black, 14.0,
                        FontWeight.w500, 1),
                    SizedBox(
                      width: 6,
                    ),
                    setCommonText(
                        "\$${(double.parse(tip) + double.parse(totalPrice))}",
                        AppColor.black,
                        13.0,
                        FontWeight.w500,
                        1),
                  ],
                ),
              ],
            )),
        new Divider(
          color: AppColor.grey,
        )
      ],
    );
  }

  // double _calculateTotalPrice(List<Products> itemList) {
  //   var totalPrice = 0.0;
  //   for (var list in itemList) {
  //     totalPrice = totalPrice + (double.parse(list.price));
  //   }
  //   return totalPrice;
  // }

  // _calculateDiscountedPrice(List<Products> itemList) {
  //   var discountedPrice = 0.0;
  //   for (var list in itemList) {
  //     discountedPrice = discountedPrice +
  //         ((double.parse(list.price) - (double.parse(list.discount))));
  //   }
  //   return discountedPrice;
  // }
}
