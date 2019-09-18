/*
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
  LatLng _center = LatLng(14.521563, 100.677433);

  ////////////////////////////////////
  final Set<Marker> _markers = {};
  MapType _currentMapType = MapType.normal;
  LatLng _lastMapPosition;

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  void _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_lastMapPosition.toString()),
        position: _lastMapPosition,
        infoWindow: InfoWindow(
          title: 'Really cool place',
          snippet: '5 Star Rating',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  //////////////////////////////////////

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  Map<String, double> currentLocation = new Map();
  StreamSubscription<Map<String, double>> locationSubscription;

  Location location = new Location();

  @override
  void initState() {
    super.initState();

    currentLocation['latitude'] = 0.0;
    currentLocation['longitude'] = 0.0;

    initPlatformState();
    locationSubscription =
        location.onLocationChanged().listen((Map<String, double> result) {
      setState(() {
        currentLocation = result;

        _center =
            LatLng(currentLocation['latitude'], currentLocation['longitude']);

        _lastMapPosition = _center;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: Text('eMENU'),
            backgroundColor: Colors.green[700],
          ),
          body: Stack(
            children: <Widget>[
              GoogleMap(

                myLocationEnabled: true,
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 11.0,

                ),
                compassEnabled: true,
                cameraTargetBounds: CameraTargetBounds.unbounded,
                minMaxZoomPreference: MinMaxZoomPreference.unbounded,
                rotateGesturesEnabled: false,
                scrollGesturesEnabled: true,
                zoomGesturesEnabled: true,
                tiltGesturesEnabled: true,
                mapType: _currentMapType,
                markers: _markers,
                onCameraMove: _onCameraMove,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                    alignment: Alignment.bottomRight,
                    child: Column(
                      children: <Widget>[
                  */
/*      FloatingActionButton(
                          onPressed: _onMapTypeButtonPressed,
                          materialTapTargetSize: MaterialTapTargetSize.padded,
                          backgroundColor: Colors.green,
                          child: const Icon(
                            Icons.map,
                            size: 15.0),
                        ),
                        SizedBox(
                          height: 16.0,
                        ),*//*

                        FloatingActionButton(
                          onPressed: _onAddMarkerButtonPressed,
                          materialTapTargetSize: MaterialTapTargetSize.padded,
                          backgroundColor: Colors.green,
                          child: const Icon(
                            Icons.add_location,
                            size: 15.0),
                        ),
                      ],
                    )),
              )
            ],
          )),
    );
  }

  void initPlatformState() async {
    Map<String, double> Mylocation = new Map();
    Mylocation = await location.getLocation();
  }
}
*/
