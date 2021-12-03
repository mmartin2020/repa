import 'package:delivery_boy/BLoC/CommonBlocClass/BaseBloc.dart';
import 'package:delivery_boy/Model/ModelProfileData.dart';

class ProfileDataBLoc extends BaseBloc<ResProfileData>{
    Stream<ResProfileData> get profileData => fetcher.stream;
    getProfileData(String userId)async{
        ResProfileData addNewAddress = await repository.getProfileData(userId);
        fetcher.sink.add(addNewAddress);
    }
}


final profileDataBloc = ProfileDataBLoc();