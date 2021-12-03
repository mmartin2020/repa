import 'package:delivery_boy/BLoC/CommonBlocClass/BaseBloc.dart';
import 'package:delivery_boy/Model/ModelOrderList.dart';

class OrderListBloc extends BaseBloc<ResOrderList>{
    Stream<ResOrderList> get getOrderList => fetcher.stream;
    getAllOrderList(String userId)async{
        ResOrderList addNewAddress = await repository.getAllOrderList(userId);
        fetcher.sink.add(addNewAddress);
    }
}


final orderListBloc = OrderListBloc();