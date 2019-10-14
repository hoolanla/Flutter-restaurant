import 'dart:async';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:online_store/models/qrcode.dart';
import 'package:online_store/services/authService.dart';
import 'package:online_store/globals.dart' as globals;
import 'package:online_store/screens/home/FirstPage2.dart';
import 'package:online_store/screens/home/newOrder.dart';
import 'package:online_store/screens/Json/foods.dart';
import 'package:online_store/models/restaurant.dart';
import 'package:online_store/screens/home/history.dart';
import 'package:online_store/screens/home/DetailCommendPage.dart';
import 'package:online_store/screens/map/place.dart';

String mImage;
String mRestaurantName;
Future<Qrcode> qrcode;

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

/*   refreshRestaurant(String restaurantID) async {
    String strBody = '{"restaurantID":"${restaurantID}"}';

    var feed = await NetworkFoods.loadRestaurantByID(strBody: strBody);
    if(feed != null){
      var data = DataFeed(feed: feed);
      if (data.feed.ResultOk.toString() == "true") {
        if(data.feed.data.length > 0)
        {
          globals.imageRestaurant = data.feed.data[0].images;
          globals.restaurantName = data.feed.data[0].restaurantName;
        }
      }
    }
    else
      {
        return CircularProgressIndicator();
      }



  }*/

  _showAlertDialog({String strMessage}) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text(strMessage),
            content: Text(""),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Barcode()),
                  );
                },
                child: Text("OK"),
              )
            ],
          );
        });
  }

  Future<bool> _onBackPress() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('คุณต้องการออกแอพพลิเคชั่น ?'),
            content: Text(""),
            actions: <Widget>[
              FlatButton(
                onPressed: () {Navigator.of(context).pop(false);} ,
                child: Text("No"),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text("Yes"),
              ),
            ],
          );
        });
  }

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WillPopScope(
          child: new Scaffold(
            bottomNavigationBar: new BottomAppBar(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  new IconButton(
                      icon: new Icon(Icons.home),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => FirstPage2()),
                        );
                      }),
                  //   new IconButton(icon: new Text('SAVE'), onPressed: null),

                  new IconButton(
                      icon: new Icon(Icons.restaurant),
                      onPressed: () {
                        if (globals.restaurantID != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailCommendPage(
                                  restaurantID: globals.restaurantID,
                                )),
                          );
                        } else {
                          _showAlertDialog(
                              strMessage: 'คุณต้อง Scan QR CODE ก่อน');
                        }
                      }),

                  new IconButton(
                      icon: new Icon(Icons.list),
                      onPressed: () {
                        if (globals.restaurantID != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => newOrder()),
                          );
                        } else {
                          _showAlertDialog(
                              strMessage: 'คุณต้อง Scan QR CODE ก่อน');
                        }
                      }),

                  new IconButton(
                      icon: new Icon(Icons.history),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => History()),
                        );
                      }),
                  new IconButton(
                      icon: new Icon(Icons.map),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Mapgoogle()),
                        );
                      }),
                ],
              ),
            ),
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
              label: Text(
                'Scan',
                style: TextStyle(color: Colors.black),
              ),
              icon: Icon(
                Icons.camera_alt,
                color: Colors.black,
              ),
              backgroundColor: Colors.white,
            ),
            floatingActionButtonLocation:
            FloatingActionButtonLocation.centerFloat,
          ),
          onWillPop:  _onBackPress),
    );
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      String userID = 'userID":"${globals.userID}';
      String head = '{"QRCode":"';
      String tail = '"}';
      String strBody = head + barcode + '","' + userID + tail;

      var feed = await NetworkFoods.loadQRCode(strBody);
      if (feed != null) {
        var data = DataFeedQR(feed: feed);

        if (data.feed.ResultOk.toString() == "true") {
          globals.restaurantID = data.feed.restaurantID;
          globals.tableID = data.feed.tableID;
          if (globals.tableID != '') {
            Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (context) => new DetailCommendPage(
                  restaurantID: globals.restaurantID,
                ),
              ),
            );
          }
        } else {
          _showAlertDialog(strMessage: data.feed.ErrorMessage.toString());
        }
      } else {
        return CircularProgressIndicator();
      }

      /*  globals.restaurantID = qrcode.restuarantID;
      globals.tableID = qrcode.tableID*/

/*
      if (globals.tableID !='') {
        Navigator.push(context,
            new MaterialPageRoute(builder: (context) => new DetailCommendPage(restaurantID: qrcode.restuarantID,)));
      }*/
/*
      bool _result;
      authService.SetRestuarant(qrcode: qrcode).then((result) {
        _result = result;

      });*/

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

class DataFeed {
  Restaurant feed;

  DataFeed({this.feed});
}

class DataFeedQR {
  Qrcode feed;

  DataFeedQR({this.feed});
}
