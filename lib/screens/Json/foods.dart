import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:online_store/models/foods.dart';
import 'package:http/http.dart' as http;

class NetworkFoods {
  static Future<Menu> loadFoodsAsset() async {

//
//      String jsonPage = await  rootBundle.loadString('assets/foods2.json');
//    final jsonResponse = json.decode(jsonPage);
//    Menu _menu = new Menu.fromJson(jsonResponse);
//    return _menu;




    String url = 'http://203.154.74.120/eMenuAPI/api/eMenu/geteMenu';
    var response = await http.post('$url',body: {'restuarant': '1'});

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

    final jsonResponse = json.decode(response.body.toString());
    Menu _menu = new Menu.fromJson(jsonResponse);

    return _menu;


  }
}
