import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:online_store/models/foods.dart';
import 'package:online_store/models/order.dart';
import 'package:online_store/models/login.dart';
import 'package:online_store/models/register.dart';
import 'package:online_store/models/bill.dart';
import 'package:online_store/models/restaurant.dart';
import 'package:online_store/models/restaurant.dart';
import 'package:http/http.dart' as http;
import 'package:online_store/services/authService.dart';
import 'package:online_store/globals.dart' as globals;

class NetworkFoods {
  static Future<Menu> loadFoodsAsset(String Recommend) async {
//
//      String jsonPage = await  rootBundle.loadString('assets/foods2.json');
//    final jsonResponse = json.decode(jsonPage);
//    Menu _menu = new Menu.fromJson(jsonResponse);
//    return _menu;


   final String restaurantID = globals.restaurantID;
   final String tableID = globals.tableID;
   final String userID = globals.userID;
      String url = 'http://203.154.74.120/eMenuAPI/api/eMenu/geteMenu';
      String body = '{"restaurantID":"${globals.restaurantID}","recommend":"${Recommend}"}';
      var response = await http.post('$url',
          headers: {"Content-Type": "application/json"},
          body: body);

      final jsonResponse = json.decode(response.body.toString());
      Menu _menu = new Menu.fromJson(jsonResponse);
      return _menu;
  }

  static Future<Restaurant> loadRestaurant() async {

      String jsonPage = await  rootBundle.loadString('assets/firstpage.json');
    final jsonResponse = json.decode(jsonPage);
    Restaurant _restaurant = new Restaurant.fromJson(jsonResponse);

    print(_restaurant.data.length.toString());

    return _restaurant;
  }

  static Future<StatusOrder> loadStatusOrder() async {
//      String jsonPage = await  rootBundle.loadString('assets/foods2.json');
//    final jsonResponse = json.decode(jsonPage);
//    Menu _menu = new Menu.fromJson(jsonResponse);
//    return _menu;


   String strBody = '{"restaurantID":"${globals.restaurantID}","tableID":"${globals.tableID}","userID":"${globals.userID}"}';

    String url = 'http://203.154.74.120/eMenuAPI/api/eMenu/getOrder';
    var response = await http.post('$url',
        headers: {"Content-Type": "application/json"}, body: strBody);

    final jsonResponse = json.decode(response.body.toString());

    print(jsonResponse.toString());

    if (jsonResponse.toString().contains('false')) {}

//jsonResponse.
    StatusOrder _statusOrder = new StatusOrder.fromJson(jsonResponse);
    return _statusOrder;
  }

  static Future<RetStatusInsertOrder> inSertOrder({String strBody}) async {
    String url = 'http://203.154.74.120/eMenuAPI/api/eMenu/insertOrder';
    var response = await http.post('$url',
        headers: {"Content-Type": "application/json"}, body: strBody);
    final jsonResponse = json.decode(response.body.toString());

    print(response.body.toString());
    RetStatusInsertOrder _retStatusInsertOrder =
        new RetStatusInsertOrder.fromJson(jsonResponse);
    return _retStatusInsertOrder;
  }

  static Future<RetRegister> insertRegister({String strBody}) async {
    String url = 'http://203.154.74.120/eMenuAPI/api/eMenu/register';
    var response = await http.post('$url',
        headers: {"Content-Type": "application/json"}, body: strBody);
    final jsonResponse = json.decode(response.body.toString());
    RetRegister _retStatusReg = new RetRegister.fromJson(jsonResponse);
    return _retStatusReg;
  }

  static Future<RetLogin> login({String strBody}) async {
    String url = 'http://203.154.74.120/eMenuAPI/api/eMenu/login';
    var response = await http.post('$url',
        headers: {"Content-Type": "application/json"}, body: strBody);
    final jsonResponse = json.decode(response.body.toString());
    print(jsonResponse.toString());
    RetLogin _ret = new RetLogin.fromJson(jsonResponse);
    return _ret;
  }

  static Future<RetBill> checkBill({String strBody}) async {
    String url = 'http://203.154.74.120/eMenuAPI/api/eMenu/noticeBillOrder';
    var response = await http.post('$url',
        headers: {"Content-Type": "application/json"}, body: strBody);
    final jsonResponse = json.decode(response.body.toString());
    print(jsonResponse.toString());
    RetBill _ret = new RetBill.fromJson(jsonResponse);
    return _ret;
  }
}
