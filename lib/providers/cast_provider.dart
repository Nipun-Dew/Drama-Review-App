import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import '../models/cast.dart';

class Casts with ChangeNotifier {
  List<Cast> _items = [
    Cast(id: "C1", name: "Sajitha Anthoney", description: "", imageUrls: ["https://www.dailynews.lk/sites/default/files/news/2020/10/05/24-In-the-dark-01.jpg"]),
    Cast(id: "C2", name: "Kokila Pawan", description: "", imageUrls: ["https://cia.lk/wp-content/uploads/2021/02/kokila-pawan.jpg"]),
    Cast(id: "C3", name: "Giriraj Kaushalya", description: "", imageUrls: ["https://lankainformation.lk/media/com_mtree/images/listings/s/5105.jpg"]),
    Cast(id: "C4", name: "Senali Fonseka", description: "", imageUrls: ["http://news.starfriends.lk/wp-content/uploads/2018/04/19510250_1148843151928007_3508492931387696191_n-1-780x405.jpg"]),
    Cast(
        id: "C5",
        name: "Praveena Disanayake",
        description: "",
        imageUrls: ["https://1.bp.blogspot.com/-l8RK9DWoquk/YDOLvIQU1II/AAAAAAAAD6U/2L8Ij9HgvE4DRvUQx27F-4j3mj3TYXvQQCLcBGAsYHQ/s320/IMG-20210217-WA0007.jpg"]),
    Cast(id: "C6", name: "Kalani Dodantenna", description: "", imageUrls: ["https://1.bp.blogspot.com/-Yse-3Lsfexo/XqSuUgy1UrI/AAAAAAAABwU/3viZGIYZjQg1TyXyf7ATttMd_zoxmIU0QCLcBGAsYHQ/s1600/12.jpg"]),
    Cast(id: "C7", name: "Yashoda Wimalaweera", description: "", imageUrls: ["https://1.bp.blogspot.com/-6J_odCK2IPs/XqSuKhK6jTI/AAAAAAAABv0/3VEmAYxK2Yo81LU8AtNYslmPD0LcGpLwACLcBGAsYHQ/s1600/2.JPG"]),
    Cast(id: "C8", name: "Danuka Dilshan", description: "", imageUrls: ["https://1.bp.blogspot.com/-l4BoDEbYqPM/XqSuJlrnYhI/AAAAAAAABvw/3H0uYZL0HmY8kai04EyI5--6mcGoZtjfgCLcBGAsYHQ/s1600/1.jpg"]),
    Cast(id: "C9", name: "Hemasiri Liyanage", description: "", imageUrls: ["https://1.bp.blogspot.com/-hG6opbeoRa0/XqSuK_NgjzI/AAAAAAAABv4/fFdH2d4L4agvA-UNIrR_pyPLi3KZgj94QCLcBGAsYHQ/s1600/3.jpg"]),
  ];

  List<Cast> get items {
    return [..._items];
  }

  void addRole(Cast role) {
    final newRole = Cast(
      id: DateTime.now().toString(),
      name: role.name,
      description: role.description,
      imageUrls: role.imageUrls,
    );
    _items.add(newRole);
    notifyListeners();

    // print(newRole.name);
    // print(newRole.description);
    // print(newRole.imageUrls);
  }
}
