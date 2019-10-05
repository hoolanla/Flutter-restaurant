import 'package:flutter/material.dart';
import 'package:online_store/models/order.dart';
import 'dart:async';
import 'package:online_store/screens/home/CafeLine.dart';
import 'package:online_store/screens/home/FirstPage2.dart';
import 'package:online_store/screens/home/status_order.dart';
import 'package:online_store/screens/Json/foods.dart';
import 'package:online_store/sqlite/db_helper.dart';
import 'package:online_store/services/Dialogs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:online_store/services/authService.dart';
import 'package:online_store/screens/barcode/barcode.dart';
import 'package:online_store/globals.dart' as globals;
import 'package:online_store/screens/map/place.dart';
import 'package:online_store/models/foods.dart';
import 'package:online_store/screens/home/newOrder.dart';
import 'package:online_store/models/restaurant.dart';
import 'package:online_store/screens/home/DetailRestaurant.dart';
import 'package:online_store/screens/home/history.dart';
import 'package:online_store/screens/home/CafeCommendPage.dart';
import 'package:online_store/screens/home/DetailCommendPage.dart';


//import 'package:json_serializable/json_serializable.dart';
import 'dart:convert';

int foodsID;
String foodsName;
double price;
String size;
String description;
String images;
int qty;
String taste;

String iTest = '';

String _restaurantID = globals.restaurantID;

void main() {
  runApp(FirstPage2());
}

class FirstPage2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ShowData();
  }
}

class _ShowData extends State<FirstPage2> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  _showAlertDialog() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text('คุณต้องแสกน QR CODE ก่อน'),
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

  @override
  void initState() {
    super.initState();


  }

  listRestaurant() {
    return Expanded(
      child: FutureBuilder<Restaurant>(
        future: NetworkFoods.loadRestaurant(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              return new Container(
                child: _listCard(Mrestaurant: snapshot.data),
              );
            } else {
              return Container(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        child: CircularProgressIndicator(),
                        height: 10.0,
                        width: 10.0,
                      )
                    ],
                  ),
                ),
              );
            }
          } else {
            return Container(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      child: CircularProgressIndicator(),
                      height: 10.0,
                      width: 10.0,
                    )
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _listCard({Restaurant Mrestaurant}) => ListView.builder(
      itemCount: Mrestaurant.data.length,
      itemBuilder: (context, idx) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 2, 0.0, 2),
          child: Container(
              height: 180.0,
              width: 420.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(Mrestaurant.data[idx].images),
                    fit: BoxFit.cover),
              ),
              child: Stack(
                children: <Widget>[
                  Container(
                    height: 180.0,
                    width: 420.0,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.black.withOpacity(0.1), Colors.black],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // Spacer(),
                        Text(
                          '${Mrestaurant.data[idx].restaurantName}',
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 24.0,
                              letterSpacing: 1.1),
                        ),
                        Text(
                          '${Mrestaurant.data[idx].content}',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              letterSpacing: 1.1),
                        ),
                        Spacer(),

                        ButtonTheme(
                          height: 28,
                          minWidth: 110,
                          child: FlatButton(
                            color: Colors.green,
                            textColor: Colors.white,
                            disabledColor: Colors.grey,
                            disabledTextColor: Colors.black,
                            padding: EdgeInsets.all(5.0),
                            splashColor: Colors.green,
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CafeCommendPage(
                                        restaurantID:
                                            Mrestaurant.data[idx].restaurantID,
                                        restaurantName: Mrestaurant
                                            .data[idx].restaurantName,
                                        content: Mrestaurant.data[idx].content,
                                        description:
                                            Mrestaurant.data[idx].description,
                                        images: Mrestaurant.data[idx].images,
                                      ),
                                ),
                              );
                            },
                            child: Text(
                              "รายละเอียด",
                              style: TextStyle(fontSize: 14.0),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )),
        );
      });

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(


        backgroundColor: Colors.white,
        title: new Text(
          'eMENU',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
      ),
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
                    _showAlertDialog();
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
                    _showAlertDialog();
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
      body: new Container(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            listRestaurant(),
          ],
        ),
      ),
    );
  }
}
