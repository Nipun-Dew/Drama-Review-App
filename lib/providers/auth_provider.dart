import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/http_exception.dart';

import 'dart:convert';

class Auth with ChangeNotifier {
  String token = "";
  String expireDate = "";
  String userId = "";

  Future<void> signup(
      String username, String useremail, String password) async {
    var url = Uri.parse("https://sl-cinema.herokuapp.com/user/signup");
    var responce = await http.post(url,
        body: json.encode(
          {
            "username": username,
            "email": useremail,
            "password": password
          }
        ), headers: {"content-type" : "application/json"});
    if (responce.statusCode == 200) {
      print(responce.body);
    } else if (responce.statusCode == 400) {
      print(responce.body);
      throw HttpException(responce.body);
    } else {
      print(responce.body);
      throw HttpException(responce.body);
    }
  }

  Future<void> login(String useremail, String password) async {
    var url = Uri.parse("https://sl-cinema.herokuapp.com/login");
    var responce = await http.post(url,
        body: json.encode(
          {
            "username": useremail,
            "password": password
          }
        ), headers: {"content-type" : "application/json"});
    if (responce.statusCode == 200) {
      token = json.decode(responce.body)['jwt'];
      print(token);
    } else if (responce.statusCode == 400) {
      print(responce.body);
      throw HttpException(responce.body);
    } else {
      print(responce.body);
      throw HttpException(responce.body);
    }
  }
}
