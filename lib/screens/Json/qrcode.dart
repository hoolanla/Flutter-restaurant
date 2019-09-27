import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:online_store/models/qrcode.dart';

import 'package:http/http.dart' as http;


class NetworkQrcode{

  static Qrcode loadQrcode({String qrcode})  {
    final jsonResponse = json.decode(qrcode);
    Qrcode _qrcode = new Qrcode.fromJson(jsonResponse);
    return _qrcode;
  }
}