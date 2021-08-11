import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import '../models/http_exception.dart';

import 'dart:convert';

class Auth with ChangeNotifier {
  String token = "";
  DateTime expireTime = DateTime.now();
  String userId = "";
  Timer? authTimer;

  bool get isAuth {
    if (token != "" && !JwtDecoder.isExpired(token)) {
      return true;
    }
    return false;
  }

  String? get getToken {
    if (token != "" && !JwtDecoder.isExpired(token)) {
      return token;
    }
    return null;
  }

  Future<void> signup(
      String username, String useremail, String password) async {
    var url = Uri.parse("https://sl-cinema.herokuapp.com/user/signup");
    var response = await http.post(url,
        body: json.encode(
            {"username": username, "email": useremail, "password": password}),
        headers: {"content-type": "application/json"});
    if (response.statusCode == 200) {
      print(response.body);
    }
    else {
      print(response.body);
      throw HttpException("Error Occurred!");
    }
  }

  Future<void> login(String useremail, String password) async {
    var url = Uri.parse("https://sl-cinema.herokuapp.com/login");
    var response = await http.post(url,
        body: json.encode({"username": useremail, "password": password}),
        headers: {"content-type": "application/json"});
    if (response.statusCode == 200) {
      token = json.decode(response.body)['jwt'];
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      expireTime = JwtDecoder.getExpirationDate(token);
      print(expireTime.toString());
      notifyListeners();
    } else if (response.statusCode == 400) {
      print(response.body);
      throw HttpException(response.body);
    } else {
      print(response.body);
      throw HttpException(response.body);
    }
  }

  void logout() {
    token = "";
    expireTime = DateTime.now();
    userId = "";
    notifyListeners();
  }

  void autoLogout() {
    if(authTimer != null) {
      authTimer!.cancel();
    }
    var timeDuration = expireTime.difference(DateTime.now()).inSeconds;
    authTimer = Timer(Duration(seconds: 3), logout);
  }
}
