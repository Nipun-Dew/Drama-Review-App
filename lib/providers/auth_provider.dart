import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/http_exception.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';

import 'dart:convert';

class Auth with ChangeNotifier {
  String token = "";
  DateTime? expireTime = DateTime.now();
  String? userId = "";
  Timer? authTimer;
  String userType = "";

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

  String? get getUserId {
    if (userId != "") {
      return userId;
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
    else if (response.statusCode == 400) {
      print(response.body);
      throw HttpException("User email already exist!");
    }
    else {
      print(response.body);
      throw HttpException("Error Occurred!");
    }
  }

  //{
  //  authority: ROLE_USER},
  //  enable: true,
  //  exp: 1629515657,
  //  userID: 6117b0c49c769008745c162c,
  //  iat: 1629299657
  // }

  Future<void> login(String useremail, String password) async {
    var url = Uri.parse("https://sl-cinema.herokuapp.com/login");

    var response = await http.post(url,
        body: json.encode({"username": useremail, "password": password}),
        headers: {"content-type": "application/json"});

    print(response.statusCode);

    if (response.statusCode == 200) {
      token = json.decode(response.body)['jwt'];
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      print(decodedToken);
      userId = decodedToken["userID"];
      userType = decodedToken["role"]["authority"];
      print(userType);
      expireTime = JwtDecoder.getExpirationDate(token);
      autoLogout();
      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      String data = json.encode({
        "token": token,
        "userId": userId,
        "expireTime": expireTime!.toIso8601String(),
        "userType": userType,
      });
      prefs.setString("dramaUser", data);

    } else if (response.statusCode == 400) {
      print(response.body);
      throw HttpException("User email or Password is incorrect!");
    } else if (response.statusCode == 401) {
      print(response.body);
      throw HttpException("Email is not verified!");
    } else {
      print(response.body);
      throw HttpException("Error Occurred!");
    }
  }

  Future<void> googleSign() async {
    try{
      final result = await FlutterWebAuth.authenticate(
          url:
          "https://sl-cinema.herokuapp.com/oauth2/authorize/google?redirect_uri=myandroidapp://oauth2/redirect",
          callbackUrlScheme: "myandroidapp");

      token = Uri.parse(result).queryParameters['token']!;
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      userId = decodedToken["userID"];
      expireTime = JwtDecoder.getExpirationDate(token);
      autoLogout();
      notifyListeners();
      print(decodedToken);
      final prefs = await SharedPreferences.getInstance();
      String data = json.encode({
        "token": token,
        "userId": userId,
        "expireTime": expireTime!.toIso8601String(),
        "userType": userType,
      });
      prefs.setString("dramaUser", data);
    }
    catch(err) {
      throw HttpException("Error!");
    }
  }

  Future<void> facebookSign() async {
    try{
      final result = await FlutterWebAuth.authenticate(
          url:
          "https://sl-cinema.herokuapp.com/oauth2/authorize/facebook?redirect_uri=myandroidapp://oauth2/redirect",
          callbackUrlScheme: "myandroidapp");
      final token = Uri.parse(result).queryParameters['token']!;
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      userId = decodedToken["userID"];
      expireTime = JwtDecoder.getExpirationDate(token);
      autoLogout();
      notifyListeners();
      print(decodedToken);
      final prefs = await SharedPreferences.getInstance();
      String data = json.encode({
        "token": token,
        "userId": userId,
        "expireTime": expireTime!.toIso8601String(),
        "userType": userType,
      });
      prefs.setString("dramaUser", data);
      print(token);
    } catch(err) {

    }

  }

  Future<void> logout() async {
    token = "";
    expireTime = DateTime.now();
    userId = "";
    userType = "";
    if(authTimer != null) {
      authTimer!.cancel();
      authTimer = null;
    }
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    notifyListeners();
  }

  void autoLogout() {
    if(authTimer != null) {
      authTimer!.cancel();
    }
    var timeDuration = expireTime!.difference(DateTime.now()).inSeconds;
    print("$timeDuration  $expireTime");
    authTimer = Timer(Duration(seconds: timeDuration), logout);
  }

  Future<bool> autoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if(!prefs.containsKey("dramaUser")) {
      return false;
    }
    final fetchToken = json.decode(prefs.getString('dramaUser')!)['token'];
    final fetchUID = json.decode(prefs.getString('dramaUser')!)['userId'];
    final fetchExpTimeString = json.decode(prefs.getString('dramaUser')!)['expireTime'];
    final fetchUType = json.decode(prefs.getString('dramaUser')!)['userType'];

    final fetchExp = DateTime.parse(fetchExpTimeString);
    
    if(fetchExp.isBefore(DateTime.now())) {
      return false;
    }
    token = fetchToken;
    expireTime = fetchExp;
    userId = fetchUID;
    userType = fetchUType;
    //print(userId);
    notifyListeners();
    return true;
  }
}
