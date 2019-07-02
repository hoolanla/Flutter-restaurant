import 'dart:async';

import 'package:flutter/material.dart';
import 'package:online_store/blocs/bloc_provider.dart';
import 'package:online_store/screens/home/home.dart';
import 'package:online_store/screens/cart/cart.dart';
import 'package:online_store/screens/login/login.dart';
import 'package:online_store/screens/map/map.dart';
import 'package:online_store/screens/barcode/barcode.dart';
import 'package:online_store/screens/splash/splash.dart';
import 'package:online_store/services/authService.dart';

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
          '/': (context) => SplashScreen(),
          '/login': (context) => Login(),
          '/home': (context) => Home(),
          '/cart': (context) => Cart(),
          '/map': (context) => Mapgoogle(),
          '/barcode': (context) => Barcode(),
        },
      ),
    );
  }

}

