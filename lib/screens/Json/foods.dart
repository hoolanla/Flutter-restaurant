import 'dart:async' show Future;
import 'dart:convert';
import 'package:online_store/models/foods.dart';
import 'package:online_store/models/order.dart';
import 'package:online_store/models/login.dart';
import 'package:online_store/models/register.dart';
import 'package:online_store/models/bill.dart';
import 'package:online_store/models/restaurant.dart';
import 'package:online_store/models/history.dart';
import 'package:online_store/models/qrcode.dart';
import 'package:online_store/models/logout.dart';
import 'package:http/http.dart' as http;
import 'package:online_store/globals.dart' as globals;

class NetworkFoods {
  static Future<Menu> loadFoodsAsset(
      {String RestaurantID, String Recommend}) async {
//
//      String jsonPage = await  rootBundle.loadString('assets/foods2.json');
//    final jsonResponse = json.decode(jsonPage);
//    Menu _menu = new Menu.fromJson(jsonResponse);
//    return _menu;

    final String restaurantID = globals.restaurantID;
    final String tableID = globals.tableID;
    final String userID = globals.userID;
    String url = 'http://203.154.74.120/eMenuAPI/api/eMenu/geteMenu';
    String body =
        '{"restaurantID":"${RestaurantID}","recommend":"${Recommend}"}';
    var response = await http.post('$url',
        headers: {"Content-Type": "application/json"}, body: body);
    final jsonResponse = json.decode(response.body.toString());
    Menu _menu = new Menu.fromJson(jsonResponse);
    return _menu;
  }

  static Future<Restaurant> loadRestaurant() async {
    String url = 'http://203.154.74.120/eMenuAPI/api/eMenu/getFirstPage';
    String body = '';
    var response = await http.post(
      '$url',
      headers: {"Content-Type": "application/json"},
    );
    final jsonResponse = json.decode(response.body.toString());
    Restaurant _restaurant = new Restaurant.fromJson(jsonResponse);
    return _restaurant;
  }

  static Future<LogoutTable> loadLogout(String strBody) async {
    String url = 'http://203.154.74.120/eMenuAPI/api/eMenu/Logout';

    var response = await http.post(
      '$url',
      headers: {"Content-Type": "application/json"},
      body: strBody,
    );
    final jsonResponse = json.decode(response.body.toString());
    LogoutTable _logout = new LogoutTable.fromJson(jsonResponse);
    print(response.body.toString());
    return _logout;
  }

  static Future<Qrcode> loadQRCode(String strBody) async {
    String url = 'http://203.154.74.120/eMenuAPI/api/eMenu/DecodeQRTable';
    var response = await http.post(
      '$url',
      headers: {"Content-Type": "application/json"},
      body: strBody,
    );
    final jsonResponse = json.decode(response.body.toString());

    print(response.body.toString());

    Qrcode _qr = new Qrcode.fromJson(jsonResponse);
    return _qr;
  }


  static Future<retCheckBillStatus> loadRetCheckBillStatus(String strBody) async {
    String url = 'http://203.154.74.120/eMenuAPI/api/eMenu/getStatusOrderIsBillPlease';
    var response = await http.post(
      '$url',
      headers: {"Content-Type": "application/json"},
      body: strBody,
    );
    final jsonResponse = json.decode(response.body.toString());
    retCheckBillStatus _ret = new retCheckBillStatus.fromJson(jsonResponse);
    return _ret;
  }


  static Future<Restaurant> loadRestaurantByID({String strBody}) async {
    String url = 'http://203.154.74.120/eMenuAPI/api/eMenu/getFirstPageByID';
    String body = '';
    var response = await http.post(
      '$url',
      headers: {"Content-Type": "application/json"},
      body: strBody,
    );
    final jsonResponse = json.decode(response.body.toString());
    Restaurant _restaurant = new Restaurant.fromJson(jsonResponse);
    return _restaurant;
  }

  static Future<StatusOrder> loadStatusOrder(String strBody) async {
//      String jsonPage = await  rootBundle.loadString('assets/foods2.json');
//    final jsonResponse = json.decode(jsonPage);
//    Menu _menu = new Menu.fromJson(jsonResponse);
//    return _menu;
    print(strBody);

    String url = 'http://203.154.74.120/eMenuAPI/api/eMenu/getOrder';
    var response = await http.post('$url',
        headers: {"Content-Type": "application/json"}, body: strBody);
    print(response.body.toString());

    final jsonResponse = json.decode(response.body.toString());
    if (jsonResponse.toString().contains('false')) {}

//jsonResponse.
    StatusOrder _statusOrder = new StatusOrder.fromJson(jsonResponse);
    return _statusOrder;
  }



  static Future<double> loadTotalStatusOrder(String strBody) async {
    String url = 'http://203.154.74.120/eMenuAPI/api/eMenu/getOrder';
    var response = await http.post('$url',
        headers: {"Content-Type": "application/json"}, body: strBody);
    final jsonResponse = json.decode(response.body.toString());

    StatusOrder _totals = new StatusOrder.fromJson(jsonResponse);

    double total = 0;

    if(_totals.orderList.length > 0)
    {
      for (int i = 0; i < _totals.orderList.length; i++) {
        print(_totals.orderList[i].totalPrice);
        total += double.parse(_totals.orderList[i].totalPrice);
      }
      return total;
    }
    else
    {
      return 0;
    }
  }

  static Future<HistoryUser> loadHistory(String strBody) async {
//      String jsonPage = await  rootBundle.loadString('assets/foods2.json');
//    final jsonResponse = json.decode(jsonPage);
//    Menu _menu = new Menu.fromJson(jsonResponse);
//    return _menu;
    //  print(strBody);
    String url = 'http://203.154.74.120/eMenuAPI/api/eMenu/getHistoryUser';
    var response = await http.post('$url',
        headers: {"Content-Type": "application/json"}, body: strBody);
    final jsonResponse = json.decode(response.body.toString());

    HistoryUser _history = new HistoryUser.fromJson(jsonResponse);

    return _history;
  }


  static Future<double> loadTotalHistory(String strBody) async {
//      String jsonPage = await  rootBundle.loadString('assets/foods2.json');
//    final jsonResponse = json.decode(jsonPage);
//    Menu _menu = new Menu.fromJson(jsonResponse);
//    return _menu;
    //  print(strBody);
    String url = 'http://203.154.74.120/eMenuAPI/api/eMenu/getHistoryUser';
    var response = await http.post('$url',
        headers: {"Content-Type": "application/json"}, body: strBody);
    final jsonResponse = json.decode(response.body.toString());

    HistoryUser _history = new HistoryUser.fromJson(jsonResponse);

    double total = 0;

    if(_history.data.length > 0)
      {
        for (int i = 0; i < _history.data.length; i++) {
          print(_history.data[i].SumPrice);
          total += _history.data[i].SumPrice;
        }
        return total;
      }
    else
      {
        return 0;
      }
  }

  static Future<RetStatusInsertOrder> inSertOrder({String strBody}) async {
    print('inser order=====>' + strBody);
    String url = 'http://203.154.74.120/eMenuAPI/api/eMenu/insertOrder';
    var response = await http.post('$url',
        headers: {"Content-Type": "application/json"}, body: strBody);
    final jsonResponse = json.decode(response.body.toString());
    print('Ret insert order========> ' + response.body.toString());
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
    RetLogin _ret = new RetLogin.fromJson(jsonResponse);
    return _ret;
  }

  static Future<RetBill> checkBill({String strBody}) async {
    String url = 'http://203.154.74.120/eMenuAPI/api/eMenu/noticeBillOrder';
    var response = await http.post('$url',
        headers: {"Content-Type": "application/json"}, body: strBody);
    final jsonResponse = json.decode(response.body.toString());
    RetBill _ret = new RetBill.fromJson(jsonResponse);
    return _ret;
  }

  static Future<RetCancelOrder> cancelOrder({String strBody}) async {
    print(strBody);

    String url = 'http://203.154.74.120/eMenuAPI/api/eMenu/cancelOrder';
    var response = await http.post('$url',
        headers: {"Content-Type": "application/json"}, body: strBody);
    final jsonResponse = json.decode(response.body.toString());
    RetCancelOrder _ret = new RetCancelOrder.fromJson(jsonResponse);
    print(jsonResponse);
    return _ret;
  }
}
