import 'package:flutter/material.dart';
import 'package:online_store/models/order.dart';
import 'dart:async';
import 'db_helper.dart';

class ShowData extends StatefulWidget {
  final String title;

  ShowData({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ShowData();
  }
}

class _ShowData extends State<ShowData> {
  Future<List<Order>> orders;

  int foodsID;

  String foodsName;
  double price;
  String size;
  String description;
  String images;
  int qty;

  double _totalPrice;
  double _totalAll = 0;

  final formKey = new GlobalKey<FormState>();
  var dbHelper;
  bool isUpdating;

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    refreshList();
  }

  refreshList() {
    setState(() {
      orders = dbHelper.getOrders();

    });
  }

  list() {
    return Expanded(
      child: FutureBuilder(
        future: orders,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
         //   return Text('Have Data ' + snapshot.data.length.toString());

            return new Container(
              child: _ListSection(orders: snapshot.data),
            );
          }

          if (null == snapshot.data || snapshot.data.length == 0) {
            return Text("No Data Found");
          }

          return CircularProgressIndicator();
        },
      ),
    );
  }

  Widget _ListSection({List<Order> orders}) => ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, int idx) {
        int _itemCount = 0;
     //   _totalPrice = orders[idx].price * orders[idx].qty;


        print('========>   totalAll' + _totalAll.toString());


        void _incrementCounter() {
          setState(() {
            // This call to setState tells the Flutter framework that something has
            // changed in this State, which causes it to rerun the build method below
            // so that the display can reflect the updated values. If we changed
            // _counter without calling setState(), then the build method would not be
            // called again, and so nothing would appear to happen.
            _totalAll = _totalAll + orders[idx].totalPrice;
          });
        }

     //   _incrementCounter();

        return ListTile(
          leading: Container(
            width: 50,
            height: 50,
            child: ClipOval(
              child: Image.network(
                orders[idx].images,
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(orders[idx].foodsName.toString()),
          subtitle: Text(
              '[${orders[idx].price}] ${orders[idx].qty}  qty. Total: ${orders[idx].totalPrice.toString()}'),
          trailing:
            Icon(Icons.delete) ,
          onTap: () {

            dbHelper.delete(orders[idx].foodsID);
            refreshList();
          },
        );
      });

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('BASKET'),
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
       // icon: Icon(Icons.add),
        label: Text('Total ' + _totalAll.toString() + "   CHECK OUT."),
        onPressed: () {},
      ),
    );
  }
}
