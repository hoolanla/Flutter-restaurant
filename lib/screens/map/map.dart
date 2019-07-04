import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';




void main() => runApp(Mapgoogle());

class Mapgoogle extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Mapgoogle> {
  Completer<GoogleMapController> _controller = Completer();
 // Map<String, double> currentLocation;
   LatLng _center;// =  LatLng(14.521563, 100.677433);

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  Map<String,double> currentLocation = new Map();
  StreamSubscription<Map<String,double>> locationSubscription;

  Location location = new Location();


  @override
  void initState() {
    super.initState();

    currentLocation['latitude'] = 0.0;
    currentLocation['longitude'] = 0.0;

    initPlatformState();
    locationSubscription = location.onLocationChanged().listen((Map<String, double> result){
      setState(() {
        currentLocation = result;

        _center = LatLng(currentLocation['latitude'], currentLocation['longitude']);
      });

    });
  }






  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Scaffold(

        body: GoogleMap(
          myLocationEnabled: true,
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
        ),
      ),
    );
  }


  void initPlatformState() async{
    Map<String,double> Mylocation = new Map();


    Mylocation = await location.getLocation();





  }



}
