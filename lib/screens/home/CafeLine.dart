import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:online_store/screens/home/home.dart';
import 'package:online_store/screens/home/home2.dart';
import 'package:online_store/screens/home/widgets/OrderList.dart';
import 'package:online_store/screens/cart/cart.dart';
import 'package:online_store/screens/login/login.dart';
import 'package:online_store/screens/map/place.dart';
import 'package:online_store/screens/barcode/barcode.dart';
import 'package:online_store/screens/splash/splash.dart';
import 'package:online_store/screens/home/Cart_page.dart';
import 'package:online_store/screens/home/CafeLine2.dart';
import 'package:online_store/services/foods.dart';
import 'package:online_store/models/foods.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

Menu _menu;

void main() {

loadFoods();
  runApp(Cafe_Line());
}


Future<String> _loadFoodsAsset() async {
  return await rootBundle.loadString('assets/foods.json');
}


Future loadFoods() async {
  String jsonPage = await _loadFoodsAsset();
  final jsonResponse = json.decode(jsonPage);
  _menu = new Menu.fromJson(jsonResponse);
  print(_menu.data[0].foodsList.length.toString());
}




class Cafe_Line extends StatelessWidget {

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

class _MyStatefulState extends State<MyStateful> with SingleTickerProviderStateMixin {

  TabController controller;




  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final titleString = "THE CORR";
  final urlJSONString = "http://203.150.203.74/foods1.json";

  List<Menu> myAllData = [];


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




  List<String> _dummy = List<String>.generate(9,(index) => "Row ${index}");

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          textTheme: TextTheme(
              title: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
              )
          ),
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
          title:Text('MENU'),


          actions: <Widget>[
            new Padding(
              padding: const EdgeInsets.all(10.0),
              child: new Container(
                  height: 150.0,
                  width: 30.0,
                  child:null,
                  ),
            )
          ],




          bottom: new TabBar(

              controller: controller, tabs: <Tab>[
            new Tab(icon: new Icon(Icons.home,color: Colors.black,),),
            new Tab(icon: new Icon(Icons.center_focus_strong,color: Colors.black),),
            new Tab(icon: new Icon(Icons.map,color: Colors.white),),
            new Tab(icon: new Icon(Icons.comment,color: Colors.white),),
            new Tab(icon: new Icon(Icons.shopping_cart,color: Colors.white),),
          ]),


        ),





        bottomNavigationBar: new BottomAppBar(
          child: new Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              new IconButton(icon: new Icon(Icons.home),tooltip: 'test'  , onPressed:null),
              //   new IconButton(icon: new Text('SAVE'), onPressed: null),
              new IconButton(icon: new Icon(Icons.star), onPressed:null),
              new IconButton(icon: new Icon(Icons.list), onPressed:null),
              new IconButton(icon: new Icon(Icons.alarm), onPressed:null),
            ],
          ),
        ),
        body:
           Container(
            child: _ListSection() ,
          ),

    );
  }




  Widget _ListSection() => ListView.builder(
      itemCount: _menu.data.length,
      itemBuilder: (
      context,index){

 if(index == 0){
   return _headerGroup();
 }



    return Card(child: Column(
      children: <Widget>[
        
        _headerSectionCard(index)
      ],
    ),);
  });


Widget _headerGroup() => Padding(padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
  child:Text(' กาแฟ                                                 ทั้งหมด 3',
    style: TextStyle(
        color: Colors.green[800],
        fontWeight: FontWeight.bold,
        fontSize: 16) ,
),
);


  Widget _headerGroup2() => Padding(padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
    child:Text(' ขนม ของหวาน                                    ทั้งหมด 4',
      style: TextStyle(
          color: Colors.green[800],
          fontWeight: FontWeight.bold,
          fontSize: 16) ,
    ),
  );


Widget _headerSectionCard(index) => ListTile(
  onTap: () {
    Navigator.push(
        context,
      MaterialPageRoute(
      builder: (context) => CafeLine2(),
),
);
},
  leading:
Container(
  width: 50,
    height: 50,
  child:ClipOval(
  child: Image.network("https://enjoyjava.com/wp-content/uploads/2018/01/How-to-make-strong-coffee.jpg",
  fit: BoxFit.cover,
  ),
),
),
title: Text("กาแฟร้อน"),
  subtitle:Text(''),
);

}








