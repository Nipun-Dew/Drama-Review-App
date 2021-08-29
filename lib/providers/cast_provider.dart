import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

import 'dart:convert';

import '../models/cast.dart';

class Casts with ChangeNotifier {
  List<Cast> _items = [
    // Cast(
    //   id: "C1",
    //   name: "Sajitha Anthoney",
    //   description: "",
    //   imageUrls: ["https://www.dailynews.lk/sites/default/files/news/2020/10/05/24-In-the-dark-01.jpg"],
    // ),
    // Cast(id: "C2", name: "Kokila Pawan", description: "", imageUrls: ["https://cia.lk/wp-content/uploads/2021/02/kokila-pawan.jpg"]),
    // Cast(
    //   id: "C3",
    //   name: "Giriraj Kaushalya",
    //   description: "",
    //   imageUrls: ["https://lankainformation.lk/media/com_mtree/images/listings/s/5105.jpg"],
    // ),
    // Cast(
    //   id: "C4",
    //   name: "Senali Fonseka",
    //   description: "",
    //   imageUrls: ["http://news.starfriends.lk/wp-content/uploads/2018/04/19510250_1148843151928007_3508492931387696191_n-1-780x405.jpg"],
    // ),
    // Cast(
    //   id: "C5",
    //   name: "Praveena Disanayake",
    //   description: "",
    //   imageUrls: ["https://1.bp.blogspot.com/-l8RK9DWoquk/YDOLvIQU1II/AAAAAAAAD6U/2L8Ij9HgvE4DRvUQx27F-4j3mj3TYXvQQCLcBGAsYHQ/s320/IMG-20210217-WA0007.jpg"],
    // ),
    // Cast(
    //   id: "C6",
    //   name: "Kalani Dodantenna",
    //   description: "",
    //   imageUrls: ["https://1.bp.blogspot.com/-Yse-3Lsfexo/XqSuUgy1UrI/AAAAAAAABwU/3viZGIYZjQg1TyXyf7ATttMd_zoxmIU0QCLcBGAsYHQ/s1600/12.jpg"],
    // ),
    // Cast(
    //   id: "C7",
    //   name: "Yashoda Wimalaweera",
    //   description: "",
    //   imageUrls: ["https://1.bp.blogspot.com/-6J_odCK2IPs/XqSuKhK6jTI/AAAAAAAABv0/3VEmAYxK2Yo81LU8AtNYslmPD0LcGpLwACLcBGAsYHQ/s1600/2.JPG"],
    // ),
    // Cast(
    //   id: "C8",
    //   name: "Danuka Dilshan",
    //   description: "",
    //   imageUrls: ["https://1.bp.blogspot.com/-l4BoDEbYqPM/XqSuJlrnYhI/AAAAAAAABvw/3H0uYZL0HmY8kai04EyI5--6mcGoZtjfgCLcBGAsYHQ/s1600/1.jpg"],
    // ),
    // Cast(
    //   id: "C9",
    //   name: "Hemasiri Liyanage",
    //   description: "",
    //   imageUrls: ["https://1.bp.blogspot.com/-hG6opbeoRa0/XqSuK_NgjzI/AAAAAAAABv4/fFdH2d4L4agvA-UNIrR_pyPLi3KZgj94QCLcBGAsYHQ/s1600/3.jpg"],
    // ),
  ];

  List<Cast> get items {
    return [..._items];
  }

  bool isLoading = true;

  Future<void> getRoles() async {
    var url = Uri.parse("https://sl-cinema.herokuapp.com/cinema/stars/all");

    var response;

    try {
      response = await http.get(url);
      // print(response.body);
      // print(json.decode(response.body));

      final List<Cast> loadedRoles = [];

      final extractedRoles = json.decode(response.body);

      extractedRoles.forEach((item) {
        final List<String> urls = [];

        item['imageUrls'].forEach((url) {
          urls.add(url.toString());
        });

        loadedRoles.add(Cast(
          id: item['name'],
          name: item['name'],
          description: item['description'],
          imageUrls: urls,
        ));
      });
      isLoading = false;
      _items = loadedRoles;
      notifyListeners();
    } catch (err) {
      // print(response.body);
      throw (err);
    }
  }

  Future<dynamic> getStar(String starID) async {
    final endPoint = "https://sl-cinema.herokuapp.com/cinema/star/"+starID;
    var url = Uri.parse(endPoint);
    try{
      var response = await http.get(url);
      final starItem = json.decode(response.body);
      return starItem;
    }catch(err){
      throw err;
    }
  }

  Future<void> addRole(Cast role) {
    var url = Uri.parse("https://sl-cinema.herokuapp.com/admin/editor/cinema/add/star");

    return http
        .post(
      url,
      headers: {
        HttpHeaders.authorizationHeader:
            "Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbkBnbWFpbC5jb20iLCJyb2xlIjpbeyJhdXRob3JpdHkiOiJST0xFX0FETUlOIn1dLCJlbmFibGUiOnRydWUsImV4cCI6MTYyOTQ0NjA5MiwiaWF0IjoxNjI5MjMwMDkyfQ.FtyBRVT7nJOPRSdt85DFOPgL_rT2VGE0hAtUCfyFjHA",
        "content-type": "application/json"
      },
      body: json.encode({
        "name": role.name,
        "description": role.description,
        "imageUrls": role.imageUrls,
      }),
    )
        .then((response) {
      final newRole = Cast(
        id: DateTime.now().toString(),
        name: role.name,
        description: role.description,
        imageUrls: role.imageUrls,
      );

      print(response.statusCode);
      print(response.body);

      if (response.statusCode.toString() == "200") {
        _items.add(newRole);
        print("Role added");

        notifyListeners();
      } else {
        print("Role not added");
        throw HttpException(response.body);
      }
    }).catchError((error) {
      throw error;
    });
  }
}
