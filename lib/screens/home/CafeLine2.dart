import 'package:flutter/material.dart';
import 'package:online_store/screens/home/CafeLine.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:online_store/services/foods.dart';
import 'package:online_store/models/order.dart';
import 'package:online_store/sqlite/db_helper.dart';
import 'package:online_store/screens/home/Showdata.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(CafeLine2());

class CafeLine2 extends StatelessWidget {
  final int foodsID;
  final String foodName;
  final double price;
  final String size;
  final String description;
  final String image;
  final String foodType;

  CafeLine2({this.foodsID,
    this.foodName,
    this.price,
    this.size,
    this.description,
    this.image,
    this.foodType})
      : super(key: null);

  // CafeLine2({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: ' Cart ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        foodsID: foodsID,
        foodName: foodName,
        price: price,
        size: size,
        description: description,
        image: image,
        foodType: foodType,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final int foodsID;
  final String foodName;
  final double price;
  final String size;
  final String description;
  final String image;
  final String foodType;

  MyHomePage({
    this.foodsID,
    this.foodName,
    this.price,
    this.size,
    this.description,
    this.image,
    this.foodType,
  }) : super(key: null);

  // MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Future<List<Order>> orders;
  int foodID;

  String foodsName;
  double price;
  String size;
  String description;
  String images;
  int qty;
  double totalPrice;

  List<Order> HaveData;

  final formKey = new GlobalKey<FormState>();
  var dbHelper;

  int _radioValue1 = 0;
  int _radioValue2 = 0;
  String taste = "";

  void _handleRadioValueChange1(int value) {
    setState(() {
      _radioValue1 = value;
      switch (_radioValue1) {
        case 0:
          taste = 'ธรรมดา';
          Fluttertoast.showToast(msg: taste, toastLength: Toast.LENGTH_SHORT);
          break;
        case 1:
          taste = 'ปานกลาง';
          Fluttertoast.showToast(msg: taste, toastLength: Toast.LENGTH_SHORT);
          break;
        case 2:
          taste = 'หวาน';
          Fluttertoast.showToast(msg: 'หวาน', toastLength: Toast.LENGTH_SHORT);
          break;
      }
    });
  }

  void _handleRadioValueChange2(int value) {
    setState(() {
      _radioValue2 = value;
      switch (_radioValue2) {
        case 0:
          taste = 'ธรรมดา';
          Fluttertoast.showToast(msg: taste, toastLength: Toast.LENGTH_SHORT);
          break;
        case 1:
          taste = 'ปานกลาง';
          Fluttertoast.showToast(msg: taste, toastLength: Toast.LENGTH_SHORT);
          break;
        case 2:
          taste = 'สุกน้อย';
          Fluttertoast.showToast(msg: taste, toastLength: Toast.LENGTH_SHORT);
          break;
      }
    });
  }

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

  showSnak() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Add to cart success."),
      backgroundColor: Colors.deepOrange,
      duration: Duration(seconds: 2),
    ));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Cafe_Line()),
            );
          },
        ),
        title: Text('Detail'),
        actions: <Widget>[
          new Padding(
            padding: const EdgeInsets.all(10.0),
            child: new Container(
              height: 150.0,
              width: 30.0,
              child: null,
            ),
          ),
          new IconButton(
            icon: new Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ShowData()),
              );
            },
          ),
        ],
      ),
      body: new Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _header(
                image: widget.image,
                price: widget.price.toString(),
                foodName: widget.foodName),
            _header2(image: widget.image),
            _detailCafe(desc: widget.description),
            _footerCoffee(foodsTyp: widget.foodType),
          ],
        ),
      ),
      bottomNavigationBar: Container(
          margin: EdgeInsets.only(bottom: 18.0),
          height: 60.0,
          decoration: BoxDecoration(
              color: Colors.white,
              border:
                  Border(top: BorderSide(color: Colors.grey[300], width: 1.0))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[_ButtonAdd()],
                ),
              ),
            ],
          )),
    );
  }

  void _foo() async {
    foodID = widget.foodsID;
    HaveData = await dbHelper.getByID(foodID);

    if (HaveData.length == 0) {
      foodID = widget.foodsID;
      foodsName = widget.foodName;
      price = widget.price;
      size = widget.size;
      description = widget.description;
      images = widget.image;
      qty = 1;
      totalPrice = qty * price;

      Order e = Order(
          foodID, foodsName, price, size, description, images, qty, totalPrice);
      dbHelper.save(e);
      showSnak();
    } else {
      foodID = widget.foodsID;
      dbHelper.updateBySQL(foodsID: foodID);
      showSnak();
    }

    //  dbHelper.deleteAll();
    //  refreshList();
  }

  RaisedButton _ButtonAdd() {
    return new RaisedButton(
      onPressed: () => _foo(),
      color: Colors.deepOrange,
      child: Text(
        'ADD TO CART',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _footerCoffee({String foodsTyp}) {
    if (foodsTyp == "7" || foodsTyp == "8") {
      return new Padding(
        padding: new EdgeInsets.all(8.0),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Radio(
              value: 0,
              groupValue: _radioValue1,
              onChanged: _handleRadioValueChange1,
            ),
            new Text(
              'ธรรมดา',
              style: new TextStyle(fontSize: 16.0),
            ),
            new Radio(
              value: 1,
              groupValue: _radioValue1,
              onChanged: _handleRadioValueChange1,
            ),
            new Text(
              'ปานกลาง',
              style: new TextStyle(
                fontSize: 16.0,
              ),
            ),
            new Radio(
              value: 2,
              groupValue: _radioValue1,
              onChanged: _handleRadioValueChange1,
            ),
            new Text(
              'หวาน',
              style: new TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      );
    } else if (foodsTyp == "1") {
      return new Padding(
        padding: new EdgeInsets.all(8.0),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Radio(
              value: 0,
              groupValue: _radioValue2,
              onChanged: _handleRadioValueChange2,
            ),
            new Text(
              'ธรรมดา',
              style: new TextStyle(fontSize: 16.0),
            ),
            new Radio(
              value: 1,
              groupValue: _radioValue2,
              onChanged: _handleRadioValueChange2,
            ),
            new Text(
              'ปานกลาง',
              style: new TextStyle(
                fontSize: 16.0,
              ),
            ),
            new Radio(
              value: 2,
              groupValue: _radioValue2,
              onChanged: _handleRadioValueChange2,
            ),
            new Text(
              'สุกน้อย',
              style: new TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      );
    } else {
      return new Padding(
        padding: new EdgeInsets.all(8.0),
        child: new Text(''),
      );
    }
  }
}

Widget _header({String image, String price, String foodName}) {
  return new ListTile(
    leading: ClipOval(
      child: Image.network(
        image,
        width: 60,
        height: 60,
        fit: BoxFit.cover,
      ),
    ),
    title: Text(foodName),
    subtitle: Text(price),
  );
}

Widget _detailCafe({String desc}) => Padding(
      padding: new EdgeInsets.all(8.0),
      child: new Text(desc),
    );

Widget _header2({String image}) => Padding(
      padding: new EdgeInsets.all(8.0),
      child: Image.network(
        image,
        fit: BoxFit.fill,
        height: 300,
      ),
    );

//              Container(
//                height: 100,
//                width: 100,
//                child:  Image.network("https://enjoyjava.com/wp-content/uploads/2018/01/How-to-make-strong-coffee.jpg"),
