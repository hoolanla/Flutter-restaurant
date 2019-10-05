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
import 'package:online_store/globals.dart' as globals;
import 'package:online_store/screens/home/DetailRestaurant.dart';
import 'package:online_store/screens/home/history.dart';
import 'package:online_store/screens/home/DetailCommendPage.dart';

void main() {
  runApp(CafeCommendPage());
}

class CafeCommendPage extends StatelessWidget {
  final String restaurantID;
  final String restaurantName;
  final String content;
  final String description;
  final String images;

  CafeCommendPage(
      {this.restaurantID,
      this.restaurantName,
      this.content,
      this.description,
      this.images});

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "DETAIL",
      debugShowCheckedModeBanner: false,
      home: new HomePage(
        restaurantID: restaurantID,
        restaurantName: restaurantName,
        content: content,
        description: description,
        images: images,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final String restaurantID;
  final String restaurantName;
  final String content;
  final String description;
  final String images;

  HomePage(
      {this.restaurantID,
      this.restaurantName,
      this.content,
      this.description,
      this.images});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

////// ALL FUNCTION
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
    _tabController = new TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        textTheme: TextTheme(
          title: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
          ),
        ),
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
        bottom: TabBar(
          unselectedLabelColor: Colors.white,
          labelColor: Colors.amber,
          tabs: [
            new Tab(
                icon: Icon(
              Icons.home,
              color: Colors.black54,
            )),
            new Tab(
              icon: new Icon(
                Icons.restaurant,
                color: Colors.black54,
              ),
            ),
          ],
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.tab,
        ),
        bottomOpacity: 1,
      ),
      body: TabBarView(
        children: [
          Page1(),
          Page2(),
        ],
        controller: _tabController,
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
    );
  }

  // ALL WIDGET

  List<detailFood> detailFoods = [];

  Widget Page1() {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          expandedHeight: 100,
          pinned: true,
          floating: false,
          flexibleSpace: new FlexibleSpaceBar(
              title: Text(
                '${widget.restaurantName}',
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0),
              ),
              background: Container(
                height: 100.0,
                width: 420.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.black.withOpacity(0.1), Colors.black],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter),
                ),
                child: Image.network(
                  widget.images,
                  fit: BoxFit.cover,
                ),
              )),
        ),
        SliverFillRemaining(
          child: FutureBuilder<Menu>(
              future: NetworkFoods.loadFoodsAsset(
                  RestaurantID: widget.restaurantID, Recommend: '0'),
              builder: (context, snapshot) {
                print('Step==========1');

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
    );
  }

  Widget Page2() {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          expandedHeight: 100,
          pinned: true,
          floating: false,
          flexibleSpace: new FlexibleSpaceBar(
              title: Text(
                '${widget.restaurantName}',
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0),
              ),
              background: Container(
                height: 100.0,
                width: 420.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.black.withOpacity(0.1), Colors.black],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter),
                ),
                child: Image.network(
                  widget.images,
                  fit: BoxFit.cover,
                ),
              )),
        ),
        SliverFillRemaining(
          child: FutureBuilder<Menu>(
              future: NetworkFoods.loadFoodsAsset(
                  RestaurantID: widget.restaurantID, Recommend: '1'),
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
    );
  }

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
                              builder: (context) => CafeLine2(
                                    restaurantID: widget.restaurantID,
                                    restaurantName: widget.restaurantName,
                                    content: widget.content,
                                    descriptionRest: widget.description,
                                    imagesRest: widget.images,
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
  Menu feed;

  DataFeed({this.feed});
}
