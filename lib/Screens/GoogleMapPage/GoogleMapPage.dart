import 'dart:async';
import 'package:delivery_boy/Helper/CommonWidgets.dart';
import 'package:delivery_boy/Helper/Constant.dart';
import 'package:delivery_boy/Helper/SharedManaged.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

// class GoogleMapPage extends StatelessWidget {
//   final String resName;
//   final String resImage;
//   final String resAddress;
//   final double resLatitude;
//   final double resLongitude;

//   GoogleMapPage(
//       {this.resName,
//       this.resImage,
//       this.resAddress,
//       this.resLatitude,
//       this.resLongitude});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: MapSample(),
//     );
//   }
// }

class GoogleMapPage extends StatefulWidget {
  final String resName;
  final String resImage;
  final String resAddress;
  final double resLatitude;
  final double resLongitude;

  GoogleMapPage(
      {this.resName,
      this.resImage,
      this.resAddress,
      this.resLatitude,
      this.resLongitude});
  @override
  State<GoogleMapPage> createState() => GoogleMapPageState();
}

class GoogleMapPageState extends State<GoogleMapPage> {
  bool loading = true;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polyLines = {};
  GoogleMapsServices _googleMapsServices = GoogleMapsServices();
  Set<Polyline> get polyLines => _polyLines;
  Completer<GoogleMapController> _controller = Completer();
  static LatLng latLng;
  LocationData currentLocation;
  BitmapDescriptor pinLocationIcon;
  BitmapDescriptor destinationLocationIcon;

  var count = 0;
  double lat = 21.052452;
  double lng = 70.292930;
  var time = "12kms";
  var distance = "19min";

  @override
  void initState() {
    setState(() {
      // getLocation();
      latLng =
          LatLng(SharedManager.shared.latitude, SharedManager.shared.longitude);
      _onAddMarkerButtonPressed();
      sendRequest();
    });

    // _setupTimer();
    // loading = true;
    super.initState();
  }

  void _onAddMarkerButtonPressed() {
    setState(() {
      setCustomMapPin();
      setDriverMapPin();
      // _modalBottomSheetMenu();
      _markers.add(Marker(
          markerId: MarkerId("111"),
          position: latLng,
          icon: destinationLocationIcon));
    });
  }

  _setCommonView(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        setCommonText('$title', AppColor.black54, 14.0, FontWeight.bold, 1),
        setCommonText('$value', AppColor.black87, 14.0, FontWeight.w500, 1),
      ],
    );
  }

  void onCameraMove(CameraPosition position) {
    latLng = position.target;
  }

  List<LatLng> _convertToLatLng(List points) {
    List<LatLng> result = <LatLng>[];
    for (int i = 0; i < points.length; i++) {
      if (i % 2 != 0) {
        result.add(LatLng(points[i - 1], points[i]));
      }
    }
    return result;
  }

  void setCustomMapPin() async {
    destinationLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 10.1),
        'Assets/TrackOrder/destination_map.png');
  }

  void setDriverMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 10.1),
        'Assets/TrackOrder/car.png');
  }

  void sendRequest() async {
    LatLng destination =
        LatLng(this.widget.resLatitude, this.widget.resLongitude);
    String route =
        await _googleMapsServices.getRouteCoordinates(latLng, destination);
    createRoute(route);
    _addMarker(destination, "Rahul Mishra");
    setState(() {});
  }

  void createRoute(String encondedPoly) {
    _polyLines.add(Polyline(
        polylineId: PolylineId(latLng.toString()),
        width: 4,
        points: _convertToLatLng(_decodePoly(encondedPoly)),
        color: Colors.red));
  }

  void _addMarker(LatLng location, String address) {
    _markers.add(Marker(
        markerId: MarkerId("112"),
        position: location,
        infoWindow: InfoWindow(title: address, snippet: "Average Time: 15min"),
        icon: pinLocationIcon));
  }

  List _decodePoly(String poly) {
    var list = poly.codeUnits;
    var lList = [];
    int index = 0;
    int len = poly.length;
    int c = 0;
    do {
      var shift = 0;
      int result = 0;

      do {
        c = list[index] - 63;
        result |= (c & 0x1F) << (shift * 5);
        index++;
        shift++;
      } while (c >= 32);
      if (result & 1 == 1) {
        result = ~result;
      }
      var result1 = (result >> 1) * 0.00001;
      lList.add(result1);
    } while (index < len);

    for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];

    print(lList.toString());

    return lList;
  }

  @override
  Widget build(BuildContext context) {
//    print("getLocation111:$latLng");
    return Scaffold(
        appBar: AppBar(
          title: setCommonText(
              'Dirección de la tienda', AppColor.white, 20.0, FontWeight.w600, 1),
          backgroundColor: AppColor.themeColor,
          elevation: 0.0,
        ),
        body: Container(
            child: Column(
          children: <Widget>[
            Expanded(
              child: GoogleMap(
                  polylines: polyLines,
                  markers: _markers,
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: latLng,
                    zoom: 13,
                  ),
                  onCameraMove: onCameraMove,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  gestureRecognizers: Set()
                    ..add(Factory<PanGestureRecognizer>(
                        () => PanGestureRecognizer()))
                    ..add(Factory<ScaleGestureRecognizer>(
                        () => ScaleGestureRecognizer()))
                    ..add(Factory<TapGestureRecognizer>(
                        () => TapGestureRecognizer()))
                    ..add(Factory<VerticalDragGestureRecognizer>(
                        () => VerticalDragGestureRecognizer()))),
            ),
            Container(
              height: 180,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: Container(
                            // color: AppColor.red,
                            child:
                                _setCommonView('DISTANCIA', '${this.distance}'),
                          )),
                          Container(
                            height: 30,
                            width: 1,
                            color: AppColor.grey,
                          ),
                          Expanded(
                              child: Container(
                            child: _setCommonView('TIEMPO', '${this.time}'),
                          )),
                          Container(
                            height: 30,
                            width: 1,
                            color: AppColor.grey,
                          ),
                          Expanded(
                              child: Container(
                            child: Center(
                              child: IconButton(
                                  icon: Icon(
                                    Icons.call,
                                    color: AppColor.black,
                                  ),
                                  onPressed: () {}),
                            ),
                          )),
                        ],
                      ),
                    ),
                    flex: 2,
                  ),
                  Divider(
                    color: AppColor.black54,
                  ),
                  Expanded(
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              child: Center(
                                  child: Container(
                                height: 50,
                                width: 70,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            this.widget.resImage))),
                              )),
                            ),
                            flex: 2,
                          ),
                          Container(
                            height: 50,
                            width: 1,
                            color: AppColor.grey,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  setCommonText(
                                      '${this.widget.resName}',
                                      AppColor.black87,
                                      15.0,
                                      FontWeight.bold,
                                      1),
                                  Expanded(
                                      child: setCommonText(
                                          '${this.widget.resAddress}',
                                          AppColor.black54,
                                          14.0,
                                          FontWeight.w600,
                                          3))
                                ],
                              ),
                            ),
                            flex: 5,
                          ),
                        ],
                      ),
                    ),
                    flex: 3,
                  ),
                  SizedBox(
                    height: 15,
                  )
                ],
              ),
            ),
          ],
        )));
  }
}
