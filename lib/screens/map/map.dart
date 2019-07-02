import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



void main() => runApp(Mapgoogle());

class Mapgoogle extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Mapgoogle> {
  Completer<GoogleMapController> _controller = Completer();



  Map<String, double> currentLocation;


  static const LatLng _center = const LatLng(14.521563, 100.677433);



  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
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






}

