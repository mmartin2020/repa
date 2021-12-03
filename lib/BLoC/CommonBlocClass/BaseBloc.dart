
import 'package:delivery_boy/BLoC/CommonBlocClass/BaseMode.dart';
import 'package:delivery_boy/BLoC/CommonBlocClass/Repository.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseBloc<T extends BaseModel> {
  final repository = Repository();
  final fetcher = PublishSubject<T>();

  dispose() {
    fetcher.close();
  }
}