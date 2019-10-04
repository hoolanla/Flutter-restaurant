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
import 'package:online_store/screens/home/FirstPage2.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:online_store/screens/barcode/barcode.dart';
import 'package:online_store/screens/map/place.dart';
import 'package:online_store/screens/home/CafeLine_Recommend.dart';
import 'package:online_store/services/authService.dart';
import 'package:online_store/screens/home/newOrder.dart';
import 'package:online_store/screens/home/history.dart';
import 'package:online_store/globals.dart' as globals;
import 'package:online_store/models/restaurant.dart';
import 'package:online_store/screens/home/DetailRestaurant2.dart';
import 'package:online_store/screens/home/DetailRestaurant_Recommend.dart';

String restaurantID;
String restaurantName;
String userID;
String tableID;

String mImage;
String mRestaurantName;

Future<Restaurant> _restaurant;

void main() {
  runApp(DetailRestaurant());
}

class DetailRestaurant extends StatelessWidget {
  final String restaurantID;

  DetailRestaurant({
    this.restaurantID,
  });

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: '',
      home: new MyStateful(
        restaurantID: restaurantID,
      ),
    );
  }
}

class MyStateful extends StatefulWidget {
  final String restaurantID;

  MyStateful({
    this.restaurantID,
  });

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _MyStatefulState();
  }
}

class _MyStatefulState extends State<MyStateful>
    with SingleTickerProviderStateMixin {
  _showAlertDialog({String strError}) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text(strError),
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

  var textYellow = Color(0xFFf6c24d);
  var iconYellow = Color(0xFFf4bf47);

  var green = Color(0xFF4caf6a);
  var greenLight = Color(0xFFd8ebde);

  var red = Color(0xFFf36169);
  var redLight = Color(0xFFf2dcdf);

  var blue = Color(0xFF398bcf);
  var blueLight = Color(0xFFc1dbee);

  TabController controller;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final titleString = "";

  void refreshRestaurant() async {
    String strBody = '{"restaurantID":"${globals.restaurantID}"}';

    var feed = await NetworkFoods.loadRestaurantByID(strBody: strBody);
    var data = DataFeed(feed: feed);
    if (data.feed.ResultOk.toString() == "true") {
      if (data.feed.data.length > 0) {
        mImage = data.feed.data[0].images;
        mRestaurantName = data.feed.data[0].restaurantName;
      }
    } else {}
  }

  @override
  void initState() {
    super.initState();
    controller = new TabController(vsync: this, length: 2);
    refreshRestaurant();
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
        title: Text(
          'MENU',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
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
        bottom: new TabBar(controller: controller, tabs: [
          GestureDetector(
            child: Tab(
              icon: Icon(
                Icons.home,
                color: Colors.black54,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailRestaurant(
                          restaurantID: widget.restaurantID,
                        )),
              );
            },
          ),
          GestureDetector(
            child: Tab(
                icon: Icon(
              Icons.restaurant,
              color: Colors.black54,
            )),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailRestaurant_Recommend(
                          restaurantID: widget.restaurantID,
                        )),
              );
            },
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
                          builder: (context) => DetailRestaurant(
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
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 100,
            pinned: true,
            floating: false,
            flexibleSpace: new FlexibleSpaceBar(
                title: FutureBuilder<Restaurant>(
                    future: NetworkFoods.loadRestaurantByID(
                        strBody: '{"restaurantID":"${globals.restaurantID}"}'),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return new Text(
                          snapshot.data.data[0].restaurantName,
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        );
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
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
                    }),
                background: Container(
                  height: 100.0,
                  width: 420.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.black.withOpacity(0.1), Colors.black],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter),
                  ),
                  child: FutureBuilder<Restaurant>(
                      future: NetworkFoods.loadRestaurantByID(
                          strBody:
                              '{"restaurantID":"${globals.restaurantID}"}'),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return new Image.network(
                            snapshot.data.data[0].images,
                            fit: BoxFit.cover,
                          );
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }
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
                      }),
                )),
          ),
          SliverFillRemaining(
            child: FutureBuilder<Menu>(
                future: NetworkFoods.loadFoodsAsset(
                    RestaurantID: widget.restaurantID, Recommend: '0'),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data != null) {
                      return new Container(
                        child: _ListSection(menu: snapshot.data),
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
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
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
                }),
          )
        ],
      ),
    );
  }

  List<detailFood> detailFoods = [];

  Widget _ListSection({Menu menu}) => ListView.builder(
        itemBuilder: (context, int idx) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              children: <Widget>[
                Container(
                  child: new ListTile(
                    leading: Text(menu.data[idx].foodsTypeNameLevel2,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold)),

                    // title: Text(menu.data[idx].foodsTypeNameLevel2),
                    trailing: Text(
                      'ทั้งหมด (${menu.data[idx].foodsItems.length})',
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      child: ListTile(
                        leading: Container(
                          height: 50,
                          width: 50,
                          child: ClipOval(
                            child: Image.network(
                              menu.data[idx].foodsItems[index].images,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        title: Text(menu.data[idx].foodsItems[index].foodName),
                        subtitle: Text(
                          menu.data[idx].foodsItems[index].price.toString(),
                        ),
                        onTap: () {
                          setState(() {});
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailRestaurant2(
                                    restaurantID: widget.restaurantID,
                                    restaurantName: '',
                                    content: '',
                                    descriptionRest: '',
                                    imagesRest: '',
                                    foodsID:
                                        menu.data[idx].foodsItems[index].foodID,
                                    foodName: menu
                                        .data[idx].foodsItems[index].foodName,
                                    price:
                                        menu.data[idx].foodsItems[index].price,
                                    priceS:
                                        menu.data[idx].foodsItems[index].priceS,
                                    priceM:
                                        menu.data[idx].foodsItems[index].priceM,
                                    priceL:
                                        menu.data[idx].foodsItems[index].priceL,
                                    size: "size",
                                    description: menu.data[idx]
                                        .foodsItems[index].description,
                                    image:
                                        menu.data[idx].foodsItems[index].images,
                                    foodType: menu.data[idx].foodsTypeIDLevel2,
                                  ),
                            ),
                          );
                        },
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

class DataFeed {
  Restaurant feed;

  DataFeed({this.feed});
}
