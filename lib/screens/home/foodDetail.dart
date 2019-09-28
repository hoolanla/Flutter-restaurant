import 'package:flutter/material.dart';
import 'package:online_store/screens/home/CafeLine.dart';
import 'package:cached_network_image/cached_network_image.dart';

void main() => runApp(foodDetail());

class foodDetail extends StatelessWidget {
  String foodName;
  String image;
  String description;
  double price;

  foodDetail({this.foodName, this.image, this.description, this.price});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ' Cart ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        foodName: foodName,
        image: image,
        description: description,
        price: price,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  String foodName;
  String image;
  String description;
  double price;

  MyHomePage({this.foodName, this.image, this.description, this.price});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: Text('Test'),
        actions: <Widget>[
          new Padding(
            padding: const EdgeInsets.all(10.0),
            child: new Container(
              height: 150.0,
              width: 30.0,
              child: new GestureDetector(
                onTap: () {},
                child: new Stack(
                  children: <Widget>[
                    new IconButton(
                      icon: new Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                      onPressed: null,
                    ),
                    new Positioned(
                      child: new Stack(
                        children: <Widget>[
                          new Icon(Icons.brightness_1,
                              size: 20.0, color: Colors.red[700]),
                          new Positioned(
                            top: 3.0,
                            right: 7,
                            child: new Center(
                              child: new Text(
                                '111',
                                style: new TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      body: GridView.count(
        crossAxisCount: 1,
        children: List.generate(1, (index) {
          return GestureDetector(
            onTap: () {
            },
            child: Card(
              child: Column(
                children: <Widget>[
                  _header(image: widget.image, price: widget.price.toString()),
                  _detailCafe(desc: widget.description),
                  _footer(),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

Widget _detailCafe({String desc}) => Padding(
      padding: new EdgeInsets.all(8.0),
      child: new Text(desc),
    );

Widget _header({String image, String price}) => Padding(
      padding: new EdgeInsets.all(8.0),
      child: ClipOval(
        child: Image.network(
          'https://i.ibb.co/1vXpqVs/flutter-logo.jpg',
        ),
      ),
    );

Widget _header2({String image}) => Padding(
      padding: new EdgeInsets.all(8.0),
      child: Image.network(
        image,
        fit: BoxFit.fill,
        height: 200,
      ),
    );

Widget _footer() => Padding(
      padding: new EdgeInsets.all(8.0),
      //child: new Text('   ลาตเท หรือ แลตเท (อังกฤษ: latte) คือเครื่องดื่มกาแฟที่เตรียมด้วยนมร้อน โดยเทเอสเปรสโซ 1/3 ส่วน และนมร้อนที่ตีด้วยไอน้ำจากเครื่องชง 2/3 ส่วน ลงในถ้วยพร้อม ๆ กัน'),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Radio(
            value: 0,
            groupValue: null,
            onChanged: null,
          ),
          new Text(
            'ธรรมดา',
            style: new TextStyle(fontSize: 16.0),
          ),
          new Radio(
            value: 1,
            groupValue: null,
            onChanged: null,
          ),
          new Text(
            'หวานน้อย',
            style: new TextStyle(
              fontSize: 16.0,
            ),
          ),
          new Radio(
            value: 2,
            groupValue: null,
            onChanged: null,
          ),
          new Text(
            'หวานมาก',
            style: new TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
