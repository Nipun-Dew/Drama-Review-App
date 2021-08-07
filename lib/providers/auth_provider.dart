import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

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
            "useremail": useremail,
            "password": password,
          },
        ), headers: {"content-type" : "application/json"});
    print(json.decode(responce.body));
  }
}
