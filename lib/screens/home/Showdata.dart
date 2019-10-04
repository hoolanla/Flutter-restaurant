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

//import 'package:json_serializable/json_serializable.dart';
import 'dart:convert';

String _restaurantID = globals.restaurantID;
String _tableID = globals.tableID;
String _userID = globals.userID;



Future<List<Order>> orders;
List<Order> _order;
Future<double> _totals;
Future<RetStatusInsertOrder> retInsert;
Future<List<StatusOrder>> statusOrders;

int foodsID;
String foodsName;
double price;
String size;
String description;
String images;
int qty;
String taste;

String iTest = '';

void main() {
  runApp(ShowData());
}

class ShowData extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ShowData();
  }
}

class _ShowData extends State<ShowData> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
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

//  final formKey = new GlobalKey<FormState>();
  var dbHelper;
  bool isUpdating;

  @override
  void initState() {
    super.initState();

    if (_tableID == '') {
      print('============>' + _tableID);
      Future.delayed(Duration.zero, () {
        _showAlertDialog(strError: 'คุณต้องแสกน QR CODE ก่อน');
      });
    } else {
      dbHelper = DBHelper();
      refreshList();
      refreshTotal();
    }


  }



  showSnak() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("ไม่สามารถสั่งได้ กำลงัเคลียร์โต๊ะ"),
      backgroundColor: Colors.deepOrange,
      duration: Duration(seconds: 2),
    ));
  }

  refreshList() {
    setState(() {
      orders = dbHelper.getOrders();
    });
  }

  refreshTotal() {
    setState(() {
      _totals = dbHelper.calculateTotal();
    });
  }

  void _removeQty({int foodsID}) async {
    int i;

    i = await dbHelper.removeQty(foodsID);

    refreshTotal();
    refreshList();
  }

  void _addQty({int foodsID}) async {
    int i;
    i = await dbHelper.addQty(foodsID);
    refreshTotal();
    refreshList();
  }

  list() {
    return Expanded(
      child: FutureBuilder(
        future: orders,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //  return Text('Have Data ' + snapshot.data.length.toString());

            _order = snapshot.data;

            return new Card(
              child: _ListSection(orders: snapshot.data),
            );
          }
          if (null == snapshot.data || snapshot.data.length == 0) {
            return Text("No Data Found");
          }

          //  return CircularProgressIndicator();
        },
      ),
    );
  }

  Widget _ListSection({List<Order> orders}) => ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, int idx) {
        iTest = '';
        iTest += '{"foodsID":' +
            orders[idx].foodsID.toString() +
            ',"foodsName":"' +
            orders[idx].foodsName +
            '",';
        iTest += '"price":' +
            orders[idx].price.toString() +
            ',"size":"' +
            orders[idx].size +
            '",';
        iTest += '"description":"","images":"",';

        iTest += '"qty":' +
            orders[idx].qty.toString() +
            ',"totalPrice":' +
            orders[idx].totalPrice.toString() +
            ',"taste":"' +
            orders[idx].taste +
            '"},';

        return ListTile(
          leading: ClipOval(
            child: Image.network(
              orders[idx].images,
              fit: BoxFit.cover,
              height: 70,
              width: 60,
            ),
          ),
          title: new Text(orders[idx].foodsName.toString()),
          subtitle: new Column(
            children: <Widget>[
              new Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Text('ราคา:'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Text(
                      orders[idx].price.toString(),
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 8.0, 8.0, 8.0),
                    child: Text('รวม:'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Text(
                      orders[idx].totalPrice.toString(),
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                ],
              ),
              new Column(
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Text('ขนาด: '),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Text(
                          '${orders[idx].size}    (${orders[idx].taste})',
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: IconButton(
                            icon: Icon(
                              Icons.remove_circle,
                              color: Colors.red,
                            ),
                            onPressed: () =>
                                _removeQty(foodsID: orders[idx].foodsID)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Text(
                          orders[idx].qty.toString(),
                          style: TextStyle(
                              color: Colors.deepOrange,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: IconButton(
                            icon: Icon(
                              Icons.add_circle,
                              color: Colors.green,
                            ),
                            onPressed: () =>
                                _addQty(foodsID: orders[idx].foodsID)),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
          trailing: null,
        );
      });

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
          title: new Text(
            'BASKET',
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
                  icon: new Icon(Icons.center_focus_strong),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Barcode()),
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
        body: new Container(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            children: <Widget>[
              //  form(),
              list(),
            ],
          ),
        ),

        floatingActionButton: new FloatingActionButton.extended(
          backgroundColor: Colors.white,
          label: FutureBuilder(
              future: _totals,
              builder: (context, snapshot) {
                return Text(
                  'Total  ${snapshot.data}   CHECK OUT',
                  style: TextStyle(color: Colors.black),
                );
              }),
          onPressed: () {
            /*   String _Header = '{"restaurantID":"${restuarantID}","userID":"${email}","tableID":"${tableID}","orderList":[';
            String _Tail = ']}';
            String _All = '';
            _All = _Header + iTest + _Tail;
            _showAlert(context,'');*/
            String _Header =
                '{"restaurantID":"${_restaurantID}","userID":"${_userID}","tableID":"${_tableID}","orderList":[';
            String _Tail = ']}';
            String _All = '';
            _All = _Header + iTest + _Tail;

            if (iTest == '') {

            }
            else
              {
                iTest = '';
              ttt(_All);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Status_Order()),
              );
            }
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }

  void _dialogResult(String str) {
    if (str == 'Accept') {
      print('Accept');
    } else {
      Navigator.of(context).pop();
    }
  }

  void _showAlert(BuildContext context, String value) {
    AlertDialog dialog = new AlertDialog(
      content: Text('คุณต้องการสั่งอาหาร ?'),
      actions: <Widget>[
        FlatButton(
            onPressed: () => _dialogResult('Cancel'), child: Text('Cancel')),
        FlatButton(
            onPressed: () {
              _dialogResult('Accept');
            },
            child: Text('Accept'))
      ],
    );

    showDialog(
      context: context,
      child: dialog,
      barrierDismissible: true,
    );
  }

  showAlertDialog(BuildContext context, String strJson) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Continue"),
      onPressed: () {
        ttt(strJson);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Status_Order(),
          ),
        );
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("AlertDialog"),
      content: Text(
          "Would you like to continue learning how to use Flutter alerts?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void ttt(String strAll) async {
    var feed = await NetworkFoods.inSertOrder(strBody: strAll);
    var data = DataFeed(feed: feed);
    if (data.feed.ResultOk.toString() == "true") {
      dbHelper.deleteAll();
      iTest = '';
      refreshList();
      refreshTotal();
    } else {

      showSnak();

    }
  }

  TestFuture({String strAll}) {
    return FutureBuilder<RetStatusInsertOrder>(
        future: NetworkFoods.inSertOrder(strBody: strAll),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print('Have=========');
            dbHelper.deleteAll();
            refreshList();
          } else if (snapshot.hasError) {
            print('==========Error');
          } else {
            print('==========No have');
          }
        });
  }
}

class DataFeed {
  RetStatusInsertOrder feed;

  DataFeed({this.feed});
}
