import 'package:delivery_boy/BLoC/CommonBlocClass/BaseBloc.dart';
import 'package:delivery_boy/Model/ModelNotificationList.dart';

class NotificationListBloc extends BaseBloc<ResNotificationList>{
    Stream<ResNotificationList> get getNotificationLits => fetcher.stream;
    getAllNotificationList(String userId)async{
        ResNotificationList addNewAddress = await repository.getNotificationList(userId);
        fetcher.sink.add(addNewAddress);
    }
}


final notificationListBloc = NotificationListBloc();