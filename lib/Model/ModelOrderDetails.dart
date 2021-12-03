import 'package:delivery_boy/BLoC/CommonBlocClass/BaseMode.dart';

class ResOrderDetails extends BaseModel {
  int code;
  String message;
  OrderDetails orderDetails;

  ResOrderDetails({this.code, this.message, this.orderDetails});

  ResOrderDetails.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    orderDetails = json['result'] != null
        ? new OrderDetails.fromJson(json['result'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.orderDetails != null) {
      data['result'] = this.orderDetails.toJson();
    }
    return data;
  }
}

class OrderDetails {
  String orderId;
  String name;
  String bannerImage;
  String address;
  String date;
  String totalPrice;
  String tipPrice;
  String discountPrice;
  String paymentType;
  String orderStatus;
  String deliveryAddress;
  String latitude;
  String longitude;
  String resLatitude;
  String resLongitude;
  String phone;
  String deliveryDate;
  String deliveryTime;
  List<Products> products;

  OrderDetails(
      {this.orderId,
      this.name,
      this.bannerImage,
      this.address,
      this.date,
      this.totalPrice,
      this.tipPrice,
      this.discountPrice,
      this.paymentType,
      this.orderStatus,
      this.deliveryAddress,
      this.latitude,
      this.longitude,
      this.phone,
      this.resLatitude,
      this.resLongitude,
      this.deliveryDate,
      this.deliveryTime,
      this.products});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    name = json['name'];
    bannerImage = json['banner_image'];
    address = json['address'];
    date = json['date'];
    totalPrice = json['total_price'];
    tipPrice = json['tip_price'];
    discountPrice = json['discount_price'];
    paymentType = json['payment_type'];
    orderStatus = json['order_status'];
    deliveryAddress = json['delivery_address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    phone = json['phone'];
    resLatitude = json['r_latitude'];
    resLongitude = json['r_longitude'];
    deliveryDate = json['delivery_date'];
    deliveryTime = json['delivery_time'];
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['name'] = this.name;
    data['banner_image'] = this.bannerImage;
    data['address'] = this.address;
    data['date'] = this.date;
    data['total_price'] = this.totalPrice;
    data['tip_price'] = this.tipPrice;
    data['discount_price'] = this.discountPrice;
    data['payment_type'] = this.paymentType;
    data['order_status'] = this.orderStatus;
    data['delivery_address'] = this.deliveryAddress;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['phone'] = this.phone;
    data['r_latitude'] = this.latitude;
    data['r_longitude'] = this.longitude;
    data['delivery_date'] = this.deliveryDate;
    data['delivery_time'] = this.deliveryTime;
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  String productName;
  String productPrice;
  String extraNote;
  String productQuantity;
  String productId;
  String type;
  String discount;
  String price;
  String description;
  String image;

  Products(
      {this.productName,
      this.productPrice,
      this.extraNote,
      this.productQuantity,
      this.productId,
      this.type,
      this.discount,
      this.price,
      this.description,
      this.image});

  Products.fromJson(Map<String, dynamic> json) {
    productName = json['product_name'];
    productPrice = json['product_price'];
    extraNote = json['extra_note'];
    productQuantity = json['product_quantity'];
    productId = json['product_id'];
    type = json['type'];
    discount = json['discount'];
    price = json['price'];
    description = json['description'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_name'] = this.productName;
    data['product_price'] = this.productPrice;
    data['extra_note'] = this.extraNote;
    data['product_quantity'] = this.productQuantity;
    data['product_id'] = this.productId;
    data['type'] = this.type;
    data['discount'] = this.discount;
    data['price'] = this.price;
    data['description'] = this.description;
    data['image'] = this.image;
    return data;
  }
}
