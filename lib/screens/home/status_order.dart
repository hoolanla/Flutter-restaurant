import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:online_store/screens/login/login.dart';
import 'package:online_store/screens/map/place.dart';
import 'package:online_store/screens/barcode/barcode.dart';
import 'package:online_store/screens/home/CafeLine2.dart';

import 'package:online_store/screens/home/foodDetail.dart';
import 'package:online_store/screens/home/CafeLine.dart';
import 'package:online_store/models/foods.dart';
import 'package:online_store/models/order.dart';
import 'package:online_store/models/bill.dart';
import 'package:online_store/screens/Json/foods.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:online_store/screens/home/Showdata.dart';
import 'package:online_store/services/authService.dart';

void main() {
  runApp(Status_Order());
}

class Status_Order extends StatelessWidget {
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

  String restuarantID = '';
  String tableID = '';
  String email = '';
  String userid = '';

  _loadCounter() async {
    AuthService authService = AuthService();
    if (await authService.isLogin()) {
      restuarantID = await authService.getRestuarantID();
      tableID = await authService.getTableID();
      email = await authService.getEmail();
      userid = await authService.getUserID();
    }
  }

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
    _loadCounter();

    String strBody;

    // strBody = '{"restaurantID":"${restuarantID}","tableID":"${tableID}","userID":"${userid}"}';
    strBody = '{"restaurantID":"1","tableID":"1","userID":"20"}';

    void _showAlertDialog({String strError}) async {
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
                    Navigator.pop(context);
                  },
                  child: Text("OK"),
                )
              ],
            );
          });
    }

    void SendtoJson(
        {String restaurantID, String tableID, String userID}) async {
      String strBody =
          '{"restaurantID":"${restaurantID}","tableID":"${tableID}","userID":"${userID}"}';
      //   String strBody = '{"restaurantID":"1","tableID":"1","userID":"20"}';

      var feed = await NetworkFoods.checkBill(strBody: strBody);
      var data = DataFeed(feed: feed);
      if (data.feed.ResultOk.toString() == "true") {
      } else {
//print('================================' + data.feed.ErrorMessage);
        _showAlertDialog(strError: 'กำลังเคลียร์โต๊ะ !!');
      }
    }

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
      ),

      floatingActionButton: new FloatingActionButton.extended(
        backgroundColor: Colors.deepOrangeAccent,
        label: Text('CHECK BILL'),
        onPressed: () {
          SendtoJson(
              restaurantID: restuarantID, tableID: tableID, userID: userid);
        },
      ),
      //  floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);

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
                    MaterialPageRoute(builder: (context) => Cafe_Line()),
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
      body: FutureBuilder<StatusOrder>(
          future: NetworkFoods.loadStatusOrder(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print('=========have');
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

  Widget _ListSection({StatusOrder menu}) => ListView.builder(
        itemBuilder: (context, int idx) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              children: <Widget>[
                Container(
                  child: new ListTile(
                    leading: Text(
                      '' + menu.orderList[idx].foodsName,
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    ),
                    title: Text('ราคา: ' +
                        menu.orderList[idx].price.toString() +
                        '    จำนวนวน: ' +
                        menu.orderList[idx].qty.toString()),
                    subtitle: new Column(
                      children: <Widget>[
                        new Row(
                          children: <Widget>[
                            Text('รวมราคา: ' +
                                menu.orderList[idx].totalPrice.toString())
                          ],
                        ),
                        new Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Text('CANCEL: '),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: null,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    trailing: changeIcon(status: menu.orderList[idx].status),
                  ),
                ),
              ],
            ),
          );
        },
        itemCount: menu.orderList.length,
      );
}

Widget changeIcon({String status}) {
  print(status);

  if (status == "Pending") {
    return Icon(
      //Icons.forward_5,
      Icons.restaurant,
      color: Colors.green,
    );
  } else if (status == "Complete") {
    return Icon(
      Icons.done_outline,
      color: Colors.green,
    );
  } else {
    //Close
    return Icon(
      Icons.note,
      color: Colors.green,
    );
  }
}

class DataFeed {
  RetBill feed;

  DataFeed({this.feed});
}
