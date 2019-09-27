import 'package:flutter/material.dart';
import 'package:online_store/models/order.dart';
import 'dart:async';
import 'package:online_store/screens/home/CafeLine.dart';
import 'package:online_store/screens/home/status_order.dart';
import 'package:online_store/screens/Json/foods.dart';
import 'package:online_store/sqlite/db_helper.dart';
import 'package:online_store/services/Dialogs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:online_store/services/authService.dart';

//import 'package:json_serializable/json_serializable.dart';
import 'dart:convert';

String restuarantID = '';
String tableID = '';
String email = '';
String userid = '';




class ShowData extends StatefulWidget {
  final String title;

  ShowData({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ShowData();
  }
}

class _ShowData extends State<ShowData> {

  _loadCounter() async {
    AuthService authService = AuthService();
    if(await authService.isLogin()){
      restuarantID = await authService.getRestuarantID();
      tableID = await authService.getTableID();
      email = await authService.getEmail();
      userid = await authService.getUserID();
    }
  }



  Future<List<Order>> orders;
  List<Order> _order;

  Future<double> _totals;
  Future<RetStatusInsertOrder> retInsert;

  int foodsID;
  String foodsName;
  double price;
  String size;
  String description;
  String images;
  int qty;
  String taste;

  String iTest = '';

  final formKey = new GlobalKey<FormState>();
  var dbHelper;
  bool isUpdating;

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    refreshList();
    refreshTotal();
  }


  Timer _Timer;

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
            ',"taste":"' + orders[idx].taste + '"},';

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
                    child: Text(orders[idx].price.toString(),
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
                        child: Text('${orders[idx].size}    (${orders[idx].taste})',
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
                          style: TextStyle(color: Colors.deepOrange,fontWeight: FontWeight.bold,fontSize: 16),
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
    _loadCounter();

    return new Scaffold(
        appBar: new AppBar(
          title: new Text('BASKET'),
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
        /*   bottomNavigationBar: BottomAppBar(
      child: Text('ccc'),
        color: Colors.deepOrange,

      ),*/
        floatingActionButton: new FloatingActionButton.extended(
          backgroundColor: Colors.deepOrangeAccent,
          label: FutureBuilder(
              future: _totals,
              builder: (context, snapshot) {
                return Text('Total  ${snapshot.data}   CHECK OUT');
              }),
          onPressed: () {
            /*   String _Header = '{"restaurantID":"${restuarantID}","userID":"${email}","tableID":"${tableID}","orderList":[';
            String _Tail = ']}';
            String _All = '';
            _All = _Header + iTest + _Tail;
            _showAlert(context,'');*/

            String _Header =    '{"restaurantID":"${restuarantID}","userID":"${userid}","tableID":"${tableID}","orderList":[';
            String _Tail = ']}';
            String _All = '';
            _All = _Header + iTest + _Tail;

            print(_All);

            if (iTest == '') {
            } else {
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
    } else {}
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
