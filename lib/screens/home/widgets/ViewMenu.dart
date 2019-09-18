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
import 'package:online_store/models/foods.dart';

void main() {
  runApp(ViewMenu());
}

class ViewMenu extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: '',
      home: new MyStateful(),
      initialRoute: '/',
      routes: {
        '/home': (context) => Home(),
      },
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

class _MyStatefulState extends State<MyStateful> {


  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final titleString = "THE CORR";
  final urlJSONString = "http://203.150.203.74/foods1.json";

  List<Menu> myAllData = [];

  @override
  void initState() {
   // loadData(urlJSONString);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(

        backgroundColor: Colors.green,
        title: new Image.network('http://203.150.203.74/rest_front.jpg',fit: BoxFit.cover,),

        leading: IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/home');
          },
        ),
      ),

      bottomNavigationBar: new BottomAppBar(
        child: new Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
//            new IconButton(icon: new Icon(Icons.fastfood),tooltip: 'test'  , onPressed: () => loadData("http://203.150.203.74/foods1.json")),
//        //   new IconButton(icon: new Text('SAVE'), onPressed: null),
//            new IconButton(icon: new Icon(Icons.fastfood), onPressed: () => loadData("http://203.150.203.74/foods2.json")),
//            new IconButton(icon: new Icon(Icons.fastfood), onPressed: () => loadData("http://203.150.203.74/foods3.json")),
//            new IconButton(icon: new Icon(Icons.fastfood), onPressed: () => loadData("http://203.150.203.74/foods4.json")),
          ],
        ),
      ),
      body: myAllData.length == 0
          ? new Center(
        child: new CircularProgressIndicator(),
      )
          : showListView(),
    );
  }

//  void loadData(String uri) async {
//    var respense = await http.get(uri, headers: {"Accept": "application/json"});
//
//    print(respense.statusCode);
//    if (respense.statusCode == 200) {
//      String responseBodyString = respense.body;
//      print('responseBodyString ==> ' + responseBodyString);
//      var jsonBody = json.decode(responseBodyString);
//      myAllData.clear();
//      for (var data in jsonBody) {
//        myAllData.add(new Menu(
//         //   data['MenuID'], data['MenuName'], data['Price'], data['PathImage']));
//      }
//      setState(() {
//        myAllData.forEach((nameData) {
//          print('name ==> ${nameData.MenuName}');
//        });
//      });
//    } else {
//      print('Somethaing Wrong');
//    }
//  }

  showListView() {
    return new ListView.builder(
        itemCount: myAllData.length,
        itemBuilder: (_, index) {
          return new Container(
            child: new Card(
              color: Colors.green,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(9.0))),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,

                children: <Widget>[
//                  new ListTile(
//                    title: new Text(myAllData[index].MenuName),
//                    subtitle:
//                    new Text('Price ${myAllData[index].Price}'),
//                    trailing:
//
//                   Icon(Icons.add,color: Colors.white,),
//
//                  ),
//
//             //     new Image.network(myAllData[index].PathImage,fit: BoxFit.fitWidth,),
                  //  new Text('Price ${myAllData[index].Price}')
                ],
              ),
            ),
          );
        });
  } // loadDate
}

       




          

