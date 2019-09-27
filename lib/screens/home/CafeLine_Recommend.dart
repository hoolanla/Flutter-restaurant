import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:online_store/screens/home/home.dart';
import 'package:online_store/screens/home/home2.dart';

import 'package:online_store/screens/cart/cart.dart';
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
import 'package:shared_preferences/shared_preferences.dart';
import 'package:online_store/screens/barcode/barcode.dart';
import 'package:online_store/screens/map/place.dart';
import 'package:online_store/screens/home/CafeLine.dart';
import 'package:online_store/services/authService.dart';



void main() {
  runApp(CafeLine_Recommend());
}

class CafeLine_Recommend extends StatelessWidget {
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
  final titleString = "";
  String restaurantID;
  String strBody;


  _loadCounter() async {
    AuthService authService = AuthService();
    if(await authService.isLogin()){
      restaurantID = await authService.getRestuarantID();
    }
  }

  // final urlJSONString = "http://203.150.203.74/foods1.json";

  @override
  void initState() {
    super.initState();
    controller = new TabController(vsync: this, length: 2);
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
        title: Text('Recommend'),
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
        bottom: new TabBar(controller: controller,
            tabs:[
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
                    MaterialPageRoute(builder: (context) => Cafe_Line()),
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
                    MaterialPageRoute(builder: (context) => CafeLine_Recommend()),
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
                    MaterialPageRoute(builder: (context) => Cafe_Line()),
                  );
                }),
            //   new IconButton(icon: new Text('SAVE'), onPressed: null),
            new IconButton(icon: new Icon(Icons.center_focus_strong), onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Barcode()),
              );
            }),


            new IconButton(icon: new Icon(Icons.map), onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Mapgoogle()),
              );
            }),

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
          future: NetworkFoods.loadFoodsAsset('1'),
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
                /*    detailFoods.add(detailFood(
                        menu.data[idx].foodsList[index].foodsID,
                        menu.data[idx].foodsList[index].foodsName,
                        menu.data[idx].foodsList[index].price,
                        menu.data[idx].foodsList[index].size,
                        menu.data[idx].foodsList[index].description,
                        menu.data[idx].foodsList[index].images));

                    print(
                        "${idx}  ${detailFoods[index].foodsName}   ${detailFoods.length.toString()}");*/

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
                            foodsID:
                            menu.data[idx].foodsItems[index].foodID,
                            foodName: menu
                                .data[idx].foodsItems[index].foodName,
                            price:
                            menu.data[idx].foodsItems[index].price,
                            size: "size",
                            description: menu.data[idx]
                                .foodsItems[index].description,
                            image:
                            menu.data[idx].foodsItems[index].images,
                            foodType:
                            menu.data[idx].foodsTypeIDLevel2,
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
