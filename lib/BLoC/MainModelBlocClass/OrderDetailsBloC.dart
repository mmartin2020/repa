import 'package:delivery_boy/BLoC/CommonBlocClass/BaseBloc.dart';
import 'package:delivery_boy/Model/ModelOrderDetails.dart';

class OrderDetailsBloc extends BaseBloc<ResOrderDetails>{
    Stream<ResOrderDetails> get orderDetails => fetcher.stream;
    getOrderDetails(String orderId)async{
        ResOrderDetails addNewAddress = await repository.getOrderDetails(orderId);
        fetcher.sink.add(addNewAddress);
    }
}


final orderDetailsBloc = OrderDetailsBloc();