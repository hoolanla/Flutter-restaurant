import 'package:flutter/material.dart';
import 'package:online_store/screens/home/CafeLine.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:online_store/services/foods.dart';
import 'package:online_store/models/order.dart';
import 'package:online_store/sqlite/db_helper.dart';
import 'package:online_store/screens/home/Showdata.dart';
import 'package:online_store/screens/home/FirstPage2.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:online_store/screens/barcode/barcode.dart';
import 'package:online_store/main.dart';
import 'package:online_store/globals.dart' as globals;
import 'package:online_store/screens/home/DetailRestaurant.dart';

String _tableID = globals.tableID;
String _restaurantID = globals.restaurantID;
String _userID = globals.userID;

void main() => runApp(DetailRestaurant2());

class DetailRestaurant2 extends StatelessWidget {
  final String restaurantID;
  final String restaurantName;
  final String content;
  final String descriptionRest;
  final String imagesRest;

  final int foodsID;
  final String foodName;
  final double price;
  final double priceS;
  final double priceM;
  final double priceL;
  final String size;
  final String description;
  final String image;
  final String foodType;

  DetailRestaurant2(
      {this.restaurantID,
        this.restaurantName,
        this.content,
        this.descriptionRest,
        this.imagesRest,
        this.foodsID,
        this.foodName,
        this.price,
        this.priceS,
        this.priceM,
        this.priceL,
        this.size,
        this.description,
        this.image,
        this.foodType})
      : super(key: null);

  // CafeLine2({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ' Cart ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        restaurantID: restaurantID,
        restaurantName: restaurantName,
        content: content,
        descriptionRest: descriptionRest,
        imagesRest: imagesRest,
        foodsID: foodsID,
        foodName: foodName,
        price: price,
        priceS: priceS,
        priceM: priceM,
        priceL: priceL,
        size: size,
        description: description,
        image: image,
        foodType: foodType,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String restaurantID;
  final String restaurantName;
  final String content;
  final String descriptionRest;
  final String imagesRest;
  final int foodsID;
  final String foodName;
  final double price;
  final double priceS;
  final double priceM;
  final double priceL;
  final String size;
  final String description;
  final String image;
  final String foodType;

  MyHomePage({
    this.restaurantID,
    this.restaurantName,
    this.content,
    this.descriptionRest,
    this.imagesRest,
    this.foodsID,
    this.foodName,
    this.price,
    this.priceS,
    this.priceM,
    this.priceL,
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
  double priceS;
  double priceM;
  double priceL;
  String size;
  String description;
  String images;
  int qty;
  double totalPrice;
  String taste;
  String comment = '';

  List<Order> HaveData;

  final formKey = new GlobalKey<FormState>();
  var dbHelper;
  int _radioValueSML = 0;
  int _radioValueDrink = 1; // ธรมดา หวาน
  int _radioValueGrill = 1; // ธรรมดา สุก
  String _taste = 'ธรรมดา';
  String _size = 'S';

  double priceSml = 0;

  void _handleRadioValueChangeSML(int value) {
    setState(() {
      _radioValueSML = value;
      switch (_radioValueSML) {
        case 0:
          priceSml = widget.priceS;
          _size = 'S';
          //   Fluttertoast.showToast(msg: taste, toastLength: Toast.LENGTH_SHORT);
          break;
        case 1:
          priceSml = widget.priceM;
          _size = 'M';
          //   Fluttertoast.showToast(msg: taste, toastLength: Toast.LENGTH_SHORT);
          break;
        case 2:
          priceSml = widget.priceL;
          _size = 'L';
          //  Fluttertoast.showToast(msg: 'หวาน', toastLength: Toast.LENGTH_SHORT);
          break;
      }
    });
  }

  void _handleRadioValueChangeDrink(int value) {
    setState(() {
      _radioValueDrink = value;
      switch (_radioValueDrink) {
        case 0:
          _taste = 'หวานน้อย';
          //   Fluttertoast.showToast(msg: taste, toastLength: Toast.LENGTH_SHORT);
          break;
        case 1:
          _taste = 'ปกติ';
          //    Fluttertoast.showToast(msg: taste, toastLength: Toast.LENGTH_SHORT);
          break;
        case 2:
          _taste = 'หวานมาก';
          //   Fluttertoast.showToast(msg: 'หวาน', toastLength: Toast.LENGTH_SHORT);
          break;
      }
    });
  }

  void _handleRadioValueChangeGrill(int value) {
    setState(() {
      _radioValueGrill = value;
      switch (_radioValueGrill) {
        case 0:
          _taste = 'ธรรมดา';
          //    Fluttertoast.showToast(msg: taste, toastLength: Toast.LENGTH_SHORT);
          break;
        case 1:
          _taste = 'สุกปกติ';
          //   Fluttertoast.showToast(msg: taste, toastLength: Toast.LENGTH_SHORT);
          break;
        case 2:
          _taste = 'สุกมาก';
          //    Fluttertoast.showToast(msg: taste, toastLength: Toast.LENGTH_SHORT);
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
      content: Text("Order success."),
      backgroundColor: Colors.deepOrange,
      duration: Duration(seconds: 2),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailRestaurant(
                    restaurantID: globals.restaurantID,
                  )),
            );
          },
        ),
        title: Text(
          'Detail2',
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
          ),
        ],
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(1.0),
          children: <Widget>[
            new Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _header(
                      image: widget.image,
                      price: widget.price.toString(),
                      foodName: widget.foodName),
                  _header2(image: widget.image),
                  _detailCafe(desc: widget.description),
                  _textSML(priceM: widget.priceM),
                  _radioSML(
                      priceS: widget.priceS,
                      priceM: widget.priceM,
                      priceL: widget.priceL),
                  _textTaste(foodsTyp: widget.foodType),
                  _radioTaste(foodsTyp: widget.foodType),
                  txtComment(),
                  ButtonAddCart(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
          margin: EdgeInsets.only(bottom: 0.0),
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

  void _foo() async {
    if (globals.tableID != null) {
      foodID = widget.foodsID;
      HaveData = await dbHelper.getByID(foodID);

      if (HaveData.length == 0) {
        foodID = widget.foodsID;
        foodsName = widget.foodName;
        if (priceSml < 1) {
          price = widget.priceS;
        } else {
          price = priceSml;
        }

        size = _size;
        description = widget.description;
        images = widget.image;
        qty = 1;
        totalPrice = qty * price;
        taste = _taste;

        Order e = Order(foodID, foodsName, price, size, description, images,
            qty, totalPrice, taste, comment);

        dbHelper.save(e);
        showSnak();
      } else {
        foodID = widget.foodsID;
        dbHelper.updateBySQL(foodsID: foodID);
        showSnak();
      }

      if (priceSml < 1) {
        priceSml = widget.priceS;
      }
    } else {
      _showAlertDialog(strError: 'คุณต้องแสกน QR CODE ก่อน');
    }

//      dbHelper.deleteAll();
//      refreshList();
  }

  RaisedButton _ButtonAdd() {
    return new RaisedButton(
      onPressed: () => _foo(),
      color: Colors.green,
      child: Text(
        'ADD TO ORDER',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  //CODE HERE
  Widget ButtonAddCart() {
    return new RaisedButton(
        child: Text(
          'ADD TO ORDER',
          style: TextStyle(color: Colors.white),
        ),
        color: Colors.green,
        onPressed: () => _foo());
  }

  Widget txtComment() {
    return TextFormField(
        decoration: InputDecoration(
          //  border: InputBorder.none,
          hintText: "Comment",
          icon: Icon(Icons.note),
        ),
        onSaved: (String value) {
          comment = value;
          print('=========== on save' + comment);
        },
        onFieldSubmitted: (String value) {});
  }

  Widget _textSML({double priceM}) {
    if (priceM > 0) {
      return Text('เลือกขนาด');
    } else {
      return Text('');
    }
  }

  Widget _textTaste({String foodsTyp}) {
    if (foodsTyp == "7" || foodsTyp == "8") {
      return Text('เลือกความหวาน');
    } else if (foodsTyp == "1") {
      return Text('เลือกความสุก');
    } else {
      return Text('');
    }
  }

  Widget _radioSML({double priceS, double priceM, double priceL}) {
    if (priceM > 0) {
      return new Padding(
        padding: new EdgeInsets.all(8.0),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Radio(
              value: 0,
              groupValue: _radioValueSML,
              onChanged: _handleRadioValueChangeSML,
            ),
            new Text(
              'S ' + priceS.toString(),
              style: new TextStyle(fontSize: 14.0),
            ),
            new Radio(
              value: 1,
              groupValue: _radioValueSML,
              onChanged: _handleRadioValueChangeSML,
            ),
            new Text(
              'M ' + priceM.toString(),
              style: new TextStyle(
                fontSize: 14.0,
              ),
            ),
            new Radio(
              value: 2,
              groupValue: _radioValueSML,
              onChanged: _handleRadioValueChangeSML,
            ),
            new Text(
              'L ' + priceL.toString(),
              style: new TextStyle(fontSize: 14.0),
            ),
          ],
        ),
      );
    } else {
      return Text('');
    }
  }

  Widget _radioTaste({String foodsTyp}) {
    if (foodsTyp == "7" || foodsTyp == "8") {
      return new Padding(
        padding: new EdgeInsets.all(8.0),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Radio(
              value: 0,
              groupValue: _radioValueDrink,
              onChanged: _handleRadioValueChangeDrink,
            ),
            new Text(
              'น้อย',
              style: new TextStyle(fontSize: 14.0),
            ),
            new Radio(
              value: 1,
              groupValue: _radioValueDrink,
              onChanged: _handleRadioValueChangeDrink,
            ),
            new Text(
              'ปกติ',
              style: new TextStyle(
                fontSize: 14.0,
              ),
            ),
            new Radio(
              value: 2,
              groupValue: _radioValueDrink,
              onChanged: _handleRadioValueChangeDrink,
            ),
            new Text(
              'มาก',
              style: new TextStyle(fontSize: 14.0),
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
              groupValue: _radioValueGrill,
              onChanged: _handleRadioValueChangeGrill,
            ),
            new Text(
              'น้อย',
              style: new TextStyle(fontSize: 16.0),
            ),
            new Radio(
              value: 1,
              groupValue: _radioValueGrill,
              onChanged: _handleRadioValueChangeGrill,
            ),
            new Text(
              'ปกติ',
              style: new TextStyle(
                fontSize: 16.0,
              ),
            ),
            new Radio(
              value: 2,
              groupValue: _radioValueGrill,
              onChanged: _handleRadioValueChangeGrill,
            ),
            new Text(
              'มาก',
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
