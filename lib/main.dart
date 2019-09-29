import 'dart:async';

import 'package:flutter/material.dart';

import 'package:online_store/screens/login/login.dart';
import 'package:online_store/screens/map/place.dart';
import 'package:online_store/screens/barcode/barcode.dart';
import 'package:online_store/screens/splash/splash.dart';
import 'package:online_store/services/authService.dart';
import 'package:online_store/screens/home/CafeLine.dart';
import 'package:online_store/screens/home/FirstPage.dart';
import 'package:online_store/screens/home/FirstPage2.dart';
import 'package:online_store/screens/home/DetailFirstPage.dart';
import 'package:online_store/screens/home/Showdata.dart';
import 'package:online_store/screens/home/status_order.dart';



main()  {
  runApp(new App());
}

class App extends StatefulWidget {

  @override
  _AppState createState() => _AppState();
}
class _AppState extends State<App> {

  final ThemeData androidTheme = new ThemeData(
      accentColor: Colors.black45,
      primaryColor: Colors.green);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'ti',
      theme: androidTheme,
      initialRoute: '/',
      routes: <String, Widget Function(BuildContext)>{
        //  '/': (context) => SplashScreen(),
        '/login': (context) => Login(),
        '/firstpage2': (context) => FirstPage2(),
        '/cafeline': (context) => Cafe_Line(),
        '/map': (context) => Mapgoogle(),
        '/barcode': (context) => Barcode(),
        '/': (context) => Login(),
      }
    );
  }
}




