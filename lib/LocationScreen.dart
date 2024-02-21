import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travelbillapp/Utils/shared_preferences.dart';
import 'package:travelbillapp/api/apiProvider.dart';
import 'package:travelbillapp/api/model/ExpensisLatLngtModel.dart';
import 'package:travelbillapp/common_widget/progress_dialog.dart';
import 'package:travelbillapp/constant/app_colors.dart';
import 'package:travelbillapp/main.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  MapType _currentMapType = MapType.normal;
  GoogleMapController? _mapController;

  static List<ExpensisDatalatitute> latlongDataList = [];
  final List<LatLng> _latLen = <LatLng>[];

  Set<Marker> _markers = {};
/*   void addMarker() {
    for (final data in latlongDataList ?? []) {
      final marker = Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        markerId: MarkerId(data.id.toString()), // Assuming 'id' is the unique identifier for the marker
        position: LatLng(
          double.parse(data.latitude.toString()),
          double.parse(data.longitude.toString()),
        ),
        infoWindow: InfoWindow(
          title: "Village:",
          snippet: "Land Area Acres",
        ),
      );
      _markers.add(marker);
    }
    setState(() {
      // Call setState after adding all the markers
    });
  }*/
  void addMarker() {
    for (final data in latlongDataList ?? []) {
      final marker = Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        markerId: MarkerId(data.id.toString()), // Assuming 'id' is the unique identifier for the marker
        position: LatLng(
          double.parse(data.latitude.toString()),
          double.parse(data.longitude.toString()),
        ),
        infoWindow: InfoWindow(
          title: "trip:${data.tripName}",
          snippet: "Bill:${data.amount} ${data.currency}",
        ),
      );
      _markers.add(marker);
    }
    setState(() {
      // Call setState after adding all the markers
    });
  }


  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  @override
  void initState() {
    Future.delayed(Duration(seconds: 1), () {

      latlongList();
      // addMarker();

    });
    super.initState();
  }

  @override
  void dispose() {
//_mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      // backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
          child: Column(children: [

            Container(
              //margin:EdgeInsets.symmetric(horizontal:8),
                height:MediaQuery.of(context).size.height,
                child:
                SafeArea(
                  // on below line creating google maps
                  child:  GoogleMap(
                    mapType: _currentMapType,

                    initialCameraPosition: CameraPosition(
                      target: latlongDataList.length > 0
                          ? LatLng(double.parse(latlongDataList[0].latitude.toString()),
                          double.parse(latlongDataList[0].longitude.toString()))
                          : LatLng(26.9124, 75.7873),
                      zoom: 15,
                    ),

                    markers: Set<Marker>.from(_markers),
                    onMapCreated: (GoogleMapController controller) {
                      _mapController = controller;
                    },

                  ),)),
          ])),
    );
  }

  void latlongList() async {
    final body = {
      "user_id": sp?.getString(SpUtil.USER_ID.toString()),
    };

    {
      showLoder(context);
      print("latlongDataList: ${body.toString()}");
      var response = await apiProvider.getlatlongAPI(body, context);
      Navigator.pop(context);
      var success = ApiProvider.returnResponse(response.status.toString());
      print("list of states: ${success.toString()}");

      if (success) {
        setState(() {
          latlongDataList.clear();
          latlongDataList = response.data!;

          for (var latlongData in latlongDataList) {
            // print("latlongData: ${latlongData.latitude.toString()}");
            if (latlongData.latitude != null &&
                latlongData.longitude != null) {
              double lat = double.parse(latlongData.latitude.toString());
              double lng = double.parse(latlongData.longitude.toString());
              _latLen.add(LatLng(lat, lng));
              print(" tripName: ${latlongData.tripName.toString()}");
              print("lat longData: ${lat.toString()},${lng.toString()}");
            }
          }
        });

        // print("category ListName: $latlongListName");
        addMarker();
      };
    }
  }

}
