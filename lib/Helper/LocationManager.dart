
import 'package:delivery_boy/Helper/SharedManaged.dart';
import 'package:location/location.dart';


class LocationManager {
  static final LocationManager shared = LocationManager._internal();

  factory LocationManager() {
    return shared;
  }

  LocationManager._internal();

   var latitude = 0.00;
   var longitude = 0.00;

getCurrentLocation()async{

var location = new Location();

// Platform messages may fail, so we use a try/catch PlatformException.
      try {
        var currentLocation = await location.getLocation();
        print("Location data:${currentLocation.longitude}");
        this.latitude = currentLocation.latitude;
        this.longitude = currentLocation.longitude;
      }  catch (e) {
        if (e.code == 'PERMISSION_DENIED') {
          print("error occured");
          return;
        }
      }

      location.onLocationChanged.listen((LocationData currentLocation) {
  // Use current location
        print("Updated Latitude--->:${currentLocation.latitude}");
        print("Updated Longitude--->:${currentLocation.longitude}");
        SharedManager.shared.latitude = currentLocation.latitude;
        SharedManager.shared.longitude = currentLocation.longitude;

      });
  }
}
