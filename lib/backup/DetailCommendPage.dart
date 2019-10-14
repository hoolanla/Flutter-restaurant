import 'package:flutter/material.dart';
import 'package:online_store/screens/map/place.dart';
import 'package:online_store/screens/barcode/barcode.dart';
import 'package:online_store/models/foods.dart';
import 'package:online_store/models/order.dart';
import 'package:online_store/screens/Json/foods.dart';
import 'package:online_store/screens/home/FirstPage2.dart';
import 'package:online_store/screens/home/newOrder.dart';
import 'package:online_store/screens/home/history.dart';
import 'package:online_store/globals.dart' as globals;
import 'package:online_store/models/restaurant.dart';
import 'package:online_store/screens/home/DetailRestaurant2.dart';
import 'package:online_store/models/logout.dart';



String _mImage;
String _mRestaurantName;

void main() {
  runApp(DetailCommendPage());
}

class DetailCommendPage extends StatelessWidget {
  final String restaurantID;

  DetailCommendPage({
    this.restaurantID,
  });

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "DETAIL",
      debugShowCheckedModeBanner: false,
      home: new HomePage(
        restaurantID: restaurantID,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final String restaurantID;

  HomePage({
    this.restaurantID,
  });

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
  _showAlertLogout(String strLogOut) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text('ยังไม่สามารถ Logout ได้ ' + strLogOut),
            content: Text(""),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => newOrder()),
                  );
                },
                child: Text("OK"),
              )
            ],
          );
        });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final titleString = "";

  void refreshRestaurant() async {
    String strBody = '{"restaurantID":"${globals.restaurantID}"}';

    var feed = await NetworkFoods.loadRestaurantByID(strBody: strBody);
    var data = DataFeed(feed: feed);
    if (data.feed.ResultOk.toString() == "true") {
      if (data.feed.data.length > 0) {
        _mImage = data.feed.data[0].images;
        _mRestaurantName = data.feed.data[0].restaurantName;
      }
    } else {}
  }

  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this);
    super.initState();
    refreshRestaurant();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(

        backgroundColor: Colors.white,
        title: Text(
          'โต๊ะที่  ${globals.tableID}',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: TabBar(
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(width: 1.0),
            insets: EdgeInsets.only(left: 0.0, right: 8.0, bottom: 4.0),
          ),
          //  isScrollable: true,
          labelPadding: EdgeInsets.only(left: 0, right: 0),

          tabs: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: new Tab(
                child: Text('ALL',style: TextStyle(color: Colors.black),),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: new Tab(
                child: Text('RECOMMEND',style: TextStyle(color: Colors.black),),
              ),
            ),
          ],
          controller: _tabController,
//          indicatorColor: Colors.white,
//          indicatorSize: TabBarIndicatorSize.tab,
        ),
        bottomOpacity: 1,
      ),
      body: TabBarView(
        children: [Page1(), Page2()],
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
                    if (globals.restaurantID != '') {
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
                  } else {
                    _showAlertDialog();
                  }
                }),

            new IconButton(
                icon: new Icon(Icons.list),
                onPressed: () {
                  if (globals.restaurantID != null) {
                    if (globals.restaurantID != '') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => newOrder()),
                      );
                    } else {
                      _showAlertDialog();
                    }
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
            new IconButton(
                icon: new Icon(Icons.exit_to_app),
                onPressed: () {
                  _LogOut();
                }),
          ],
        ),
      ),
    );
  }

  // ALL WIDGET

  void _LogOut() async {
    if (globals.tableID != null && globals.tableID != '') {
      String strBody =
          '{"userID":"${globals.userID}","tableID":"${globals.tableID}"}';
      var feed = await NetworkFoods.loadLogout(strBody);
      var data = DataFeedLogout(feed: feed);
      if (data.feed.ResultOk == "false") {
        _showAlertLogout(data.feed.ErrorMessage);
      } else {
        globals.tableID = '';
        globals.restaurantID = '';
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FirstPage2()),
        );
      }
    } else {
      globals.tableID = '';
      globals.restaurantID = '';
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FirstPage2()),
      );
    }
  }

  List<detailFood> detailFoods = [];

  Widget Page1() {
    return CustomScrollView(
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
                        strBody: '{"restaurantID":"${globals.restaurantID}"}'),
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
                        strBody: '{"restaurantID":"${globals.restaurantID}"}'),
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
//                      subtitle: Text(menu.data[idx].foodsItems[index].price.toString(),
//                      ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailRestaurant2(
                          restaurantID: globals.restaurantID,
                          restaurantName: '',
                          content: '',
                          descriptionRest: '',
                          imagesRest: '',
                          foodsID:
                          menu.data[idx].foodsItems[index].foodID,
                          foodName:
                          menu.data[idx].foodsItems[index].foodName,
                          price: menu.data[idx].foodsItems[index].price,
                          priceS:
                          menu.data[idx].foodsItems[index].priceS,
                          priceM:
                          menu.data[idx].foodsItems[index].priceM,
                          priceL:
                          menu.data[idx].foodsItems[index].priceL,
                          size: "size",
                          description: menu
                              .data[idx].foodsItems[index].description,
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

class DataFeedLogout {
  LogoutTable feed;

  DataFeedLogout({this.feed});
}

class DataFeed {
  Restaurant feed;

  DataFeed({this.feed});
}
