import 'package:delivery_boy/Helper/RequestManager.dart';
import 'package:delivery_boy/Model/ModelNotificationList.dart';
import 'package:delivery_boy/Model/ModelOrderDetails.dart';
import 'package:delivery_boy/Model/ModelOrderHistory.dart';
import 'package:delivery_boy/Model/ModelOrderList.dart';
import 'package:delivery_boy/Model/ModelProfileData.dart';
import 'package:delivery_boy/Model/ModelReviewList.dart';

class Repository {
  final reqManager = Requestmanager();
  //Fetch Login Data
  Future<ResOrderList> getAllOrderList(String userID) =>
      reqManager.getOrderList(userID);
  Future<ResOrderHistory> getAllHistoryOrderList(String userID) =>
      reqManager.getHistoryOrderList(userID);
  Future<ResNotificationList> getNotificationList(String userID) =>
      reqManager.getNotificationList(userID);
  Future<ResOrderDetails> getOrderDetails(String orderID) =>
      reqManager.getOrderDetails(orderID);
  Future<ResProfileData> getProfileData(String driverId) =>
      reqManager.fetchProfileData(driverId);
  //Fetch Driver Reviews
  Future<ResReviewList> fetchDriverReview(String driverId) =>
      reqManager.fetchDriverReviews(driverId);
}
