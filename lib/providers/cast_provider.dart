import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import '../models/cast.dart';

class Casts with ChangeNotifier {
  List<Cast> _items = [
    Cast(id: "A1", name: "Sajitha Anthoney", imageUrl: "https://www.dailynews.lk/sites/default/files/news/2020/10/05/24-In-the-dark-01.jpg"),
    Cast(id: "A2", name: "Kokila Pawan", imageUrl: "https://cia.lk/wp-content/uploads/2021/02/kokila-pawan.jpg"),
    Cast(id: "A3", name: "Giriraj Kaushalya", imageUrl: "https://lankainformation.lk/media/com_mtree/images/listings/s/5105.jpg"),
    Cast(id: "A4", name: "Senali Fonseka", imageUrl: "http://news.starfriends.lk/wp-content/uploads/2018/04/19510250_1148843151928007_3508492931387696191_n-1-780x405.jpg"),
    Cast(id: "A5", name: "Praveena Disanayake", imageUrl: "https://1.bp.blogspot.com/-l8RK9DWoquk/YDOLvIQU1II/AAAAAAAAD6U/2L8Ij9HgvE4DRvUQx27F-4j3mj3TYXvQQCLcBGAsYHQ/s320/IMG-20210217-WA0007.jpg"),
    Cast(id: "A6", name: "Kalani Dodantenna", imageUrl: "https://1.bp.blogspot.com/-Yse-3Lsfexo/XqSuUgy1UrI/AAAAAAAABwU/3viZGIYZjQg1TyXyf7ATttMd_zoxmIU0QCLcBGAsYHQ/s1600/12.jpg"),
    Cast(id: "A7", name: "Yashoda Wimalaweera", imageUrl: "https://1.bp.blogspot.com/-6J_odCK2IPs/XqSuKhK6jTI/AAAAAAAABv0/3VEmAYxK2Yo81LU8AtNYslmPD0LcGpLwACLcBGAsYHQ/s1600/2.JPG"),
    Cast(id: "A8", name: "Danuka Dilshan", imageUrl: "https://1.bp.blogspot.com/-l4BoDEbYqPM/XqSuJlrnYhI/AAAAAAAABvw/3H0uYZL0HmY8kai04EyI5--6mcGoZtjfgCLcBGAsYHQ/s1600/1.jpg"),
    Cast(id: "A9", name: "Hemasiri Liyanage", imageUrl: "https://1.bp.blogspot.com/-hG6opbeoRa0/XqSuK_NgjzI/AAAAAAAABv4/fFdH2d4L4agvA-UNIrR_pyPLi3KZgj94QCLcBGAsYHQ/s1600/3.jpg"),
  ];

  List<Cast> get items {
    return [..._items];
  }
}
