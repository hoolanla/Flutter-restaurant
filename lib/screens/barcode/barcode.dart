import 'dart:async';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:online_store/models/qrcode.dart';
import 'package:online_store/screens/Json/qrcode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:online_store/services/authService.dart';
import 'package:online_store/screens/home/CafeLine.dart';
import 'package:online_store/globals.dart' as globals;

void main() {
  runApp(new Barcode());
}

class Barcode extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<Barcode> {

  AuthService authService = AuthService();
  String barcode = "";
  Qrcode qrcode;

  @override
  initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        body: Center(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(8.0),
              ),
              Text(''),



            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: scan,
          label: Text("Scan"),
          icon: Icon(Icons.camera_alt),
          backgroundColor: Colors.deepOrange,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      qrcode = NetworkQrcode.loadQrcode(qrcode: barcode);


      bool _result;
      authService.SetRestuarant(qrcode: qrcode).then((result) {
        _result = result;

        globals.restaurantID = qrcode.restuarantID;
        globals.tableID = qrcode.tableID;

        if(_result) {
          Navigator.push(
              context, new MaterialPageRoute(builder: (context) => new Cafe_Line()));
        }


        });

      setState(() => this.barcode = barcode);




    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        // The user did not grant the camera permission.
      } else {
        // Unknown error.
      }
    } on FormatException {
      // User returned using the "back"-button before scanning anything.
    } catch (e) {
      // Unknown error.
    }
  }
}
