import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import '../models/roles.dart';

class Roles with ChangeNotifier {
  List<Role> _items = [
    ///////////////////////////////////////////////Directors/////////////////////////////////////////////////////////////////
    Role(id: "D1", name: "Jayaprakash Sivagurunadan", imageUrl: "https://www.dailynews.lk/sites/default/files/news/2020/10/05/24-In-the-dark-01.jpg"),
    Role(id: "D2", name: "Kokila Pawan", imageUrl: "https://cia.lk/wp-content/uploads/2021/02/kokila-pawan.jpg"),
    Role(id: "D3", name: "Giriraj Kaushalya", imageUrl: "https://lankainformation.lk/media/com_mtree/images/listings/s/5105.jpg"),

    ///////////////////////////////////////////////Producers/////////////////////////////////////////////////////////////////
    Role(id: "P1", name: "Chamara Samarawickrama", imageUrl: "http://news.starfriends.lk/wp-content/uploads/2018/04/19510250_1148843151928007_3508492931387696191_n-1-780x405.jpg"),
    Role(
        id: "P2",
        name: "Saddhamangala Sooriyabandara",
        imageUrl: "https://1.bp.blogspot.com/-l8RK9DWoquk/YDOLvIQU1II/AAAAAAAAD6U/2L8Ij9HgvE4DRvUQx27F-4j3mj3TYXvQQCLcBGAsYHQ/s320/IMG-20210217-WA0007.jpg"),
    Role(id: "P3", name: "Kalani Dodantenna", imageUrl: "https://1.bp.blogspot.com/-Yse-3Lsfexo/XqSuUgy1UrI/AAAAAAAABwU/3viZGIYZjQg1TyXyf7ATttMd_zoxmIU0QCLcBGAsYHQ/s1600/12.jpg"),
  ];

  List<Role> get items {
    return [..._items];
  }
}
