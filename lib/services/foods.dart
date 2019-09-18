import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:online_store/models/foods.dart';


Future<String> _loadFoodsAsset() async {
  return await rootBundle.loadString('assets/foods.json');
}


Future loadFoods() async {
  String jsonPage = await _loadFoodsAsset();
  final jsonResponse = json.decode(jsonPage);
  Menu _menu = new Menu.fromJson(jsonResponse);
 // print(_menu.data[0].foodsList.length.toString());
}