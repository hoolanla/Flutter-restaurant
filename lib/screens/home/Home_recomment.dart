import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:online_store/screens/login/login.dart';
import 'package:online_store/screens/map/place.dart';
import 'package:online_store/screens/barcode/barcode.dart';
import 'package:online_store/screens/splash/splash.dart';

import 'package:online_store/screens/home/CafeLine2.dart';

import 'package:online_store/screens/home/foodDetail.dart';
import 'package:online_store/screens/home/status_order.dart';
import 'package:online_store/models/foods.dart';
import 'package:online_store/screens/Json/foods.dart';
import 'package:online_store/screens/home/Showdata.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

void main() {
  runApp(Home_recomment());
}

class Home_recomment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: '',
      home: new MyStateful(),
//      initialRoute: '/',
//      routes: {
//        '/home': (context) => Home(),
//      },
    );
  }
}

class MyStateful extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _MyStatefulState();
  }
}

class _MyStatefulState extends State<MyStateful>
    with SingleTickerProviderStateMixin {
  TabController controller;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final titleString = "THE CORR";

  // final urlJSONString = "http://203.150.203.74/foods1.json";

  @override
  void initState() {
    super.initState();
    controller = new TabController(vsync: this, length: 5);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        textTheme: TextTheme(
            title: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
            )),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        title: Text('MENU'),
        actions: <Widget>[
          new Padding(
            padding: const EdgeInsets.all(10.0),
            child: new Container(
              height: 150.0,
              width: 30.0,
              child: null,
            ),
          )
        ],
        bottom: new TabBar(controller: controller, tabs: <Tab>[
          new Tab(
            icon: new Icon(
              Icons.home,
              color: Colors.black,
            ),
          ),
          new Tab(
            icon: new Icon(Icons.center_focus_strong, color: Colors.black),
          ),
          new Tab(
            icon: new Icon(Icons.map, color: Colors.white),
          ),
          new Tab(
            icon: new Icon(Icons.comment, color: Colors.white),
          ),
          new Tab(
            icon: new Icon(Icons.shopping_cart, color: Colors.white),
          ),
        ]),
      ),
      bottomNavigationBar: new BottomAppBar(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            new IconButton(
                icon: new Icon(Icons.home),
                tooltip: 'test',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home_recomment()),
                  );
                }),
            //   new IconButton(icon: new Text('SAVE'), onPressed: null),
            new IconButton(icon: new Icon(Icons.star), onPressed: null),
            new IconButton(
                icon: new Icon(Icons.list),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ShowData()),
                  );
                }),
            new IconButton(
                icon: new Icon(Icons.alarm),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Status_Order()),
                  );
                }),
          ],
        ),
      ),
      body: FutureBuilder<Menu>(
          future: NetworkFoods.loadFoodsAsset(""),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return new Container(
                child: _ListSection(menu: snapshot.data),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            return CircularProgressIndicator();
          }),
    );
  }

  List<detailFood> detailFoods = [];

  Widget _ListSection({Menu menu}) => ListView.builder(
    itemBuilder: (context, int idx) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          children: <Widget>[

            ListView.builder(
              itemBuilder: (context, index) {


                return Card(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 100.0, width: double.infinity),
                      Align(
                        alignment: Alignment(0.8, -1.0),
                        heightFactor: 0.5,
                        child: FloatingActionButton(
                          onPressed: null,
                          child: Text('รายละเอียด'),
                          backgroundColor: Colors.green,

                        ),

                      )
                    ],
                  ),
                );
              },
              itemCount: menu.data[idx].foodsItems.length,
              shrinkWrap: true,
              // todo comment this out and check the result
              physics:
              ClampingScrollPhysics(), // todo comment this out and check the result
            )
          ],
        ),
      );
    },
    itemCount: menu.data.length,
  );
}
