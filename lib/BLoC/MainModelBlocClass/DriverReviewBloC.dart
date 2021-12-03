//
import 'package:delivery_boy/BLoC/CommonBlocClass/BaseBloc.dart';
import 'package:delivery_boy/Model/ModelReviewList.dart';

class DriverReviewBloC extends BaseBloc<ResReviewList> {
  Stream<ResReviewList> get driverReview => fetcher.stream;
  fetchAllReview(String driverID) async {
    ResReviewList addNewAddress = await repository.fetchDriverReview(driverID);
    fetcher.sink.add(addNewAddress);
  }
}

final driverReviewBloc = DriverReviewBloC();
