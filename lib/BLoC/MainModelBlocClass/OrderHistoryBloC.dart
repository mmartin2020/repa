import 'package:delivery_boy/BLoC/CommonBlocClass/BaseBloc.dart';
import 'package:delivery_boy/Model/ModelOrderHistory.dart';

class HistoryListBloc extends BaseBloc<ResOrderHistory>{
    Stream<ResOrderHistory> get getHistoryList => fetcher.stream;
    getAllHistoryList(String userId)async{
        ResOrderHistory addNewAddress = await repository.getAllHistoryOrderList(userId);
        fetcher.sink.add(addNewAddress);
    }
}


final historyListBloc = HistoryListBloc();