import 'dart:async';

import 'package:flutter/material.dart';
import 'package:online_store/blocs/bloc_provider.dart';
import 'package:online_store/screens/home/home.dart';
import 'package:online_store/screens/home/home2.dart';
import 'package:online_store/screens/home/widgets/ViewMenu.dart';
import 'package:online_store/screens/cart/cart.dart';
import 'package:online_store/screens/login/login.dart';
import 'package:online_store/screens/map/place.dart';
import 'package:online_store/screens/barcode/barcode.dart';
import 'package:online_store/screens/splash/splash.dart';
import 'package:online_store/services/authService.dart';
import 'package:online_store/screens/home/CafeLine.dart';
import 'package:online_store/screens/home/TestPage.dart';
import 'package:online_store/sqlite/GridSqlite.dart';
import 'package:online_store/sqlite/ShowData.dart';

main()  {

/*
  AuthService authService = AuthService();
  Widget page = Login();
  if(await authService.isLogin()){
page = Home();
  }
*/



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
    return new BlocProvider(
      child: new MaterialApp(
        title: 'ti',
        theme: androidTheme,
        initialRoute: '/',
        routes: <String, Widget Function(BuildContext)>{
        //  '/': (context) => SplashScreen(),
          '/login': (context) => Login(),
         '/home': (context) => Home(),
          '/home2': (context) => Home2(),
          '/cart': (context) => Cart(),
          '/map': (context) => Mapgoogle(),
          '/barcode': (context) => Barcode(),
          '/ViewMenu': (context) => ViewMenu(),
          '/TestPage': (context) => TestPage(),
          '/': (context) => Cafe_Line(),
        },
      ),
    );
  }

}

