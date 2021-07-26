import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import '../models/category.dart';

class Categories with ChangeNotifier {
  bool categoryClicked = false;
  String catTitle = "";
  String catId = "";

  List<DramaCategory> _items = [
    DramaCategory(
        id: "C1",
        title: "Teledramas",
        imageUrl: "https://www.itntv.lk/wp-content/uploads/2020/06/thanamalvila-kollek-episode-40-2-407x229.jpg"),
    DramaCategory(
        id: "C2",
        title: "Web Series",
        imageUrl: "https://i.ytimg.com/vi/Jb4Z-MvRGPU/maxresdefault.jpg"),
    DramaCategory(
        id: "C3",
        title: "Movies",
        imageUrl: "https://i.ytimg.com/vi/qGeVRCI2P-0/maxresdefault.jpg"),
    DramaCategory(
        id: "C4",
        title: "Documentries",
        imageUrl: "https://www.cinnamonnaturetrails.com/wp-content/uploads/2017/12/asian-elephant-2.jpg"),
    DramaCategory(
        id: "C5",
        title: "Cartoons",
        imageUrl: "https://images.squarespace-cdn.com/content/v1/51cdafc4e4b09eb676a64e68/1618598239038-1QA2Y4IJD2G8KPFD3JB7/rat_ot1.jpg"),
    DramaCategory(
        id: "C6",
        title: "Educational",
        imageUrl: "https://i0.wp.com/www.colombotelegraph.com/wp-content/uploads/2021/01/Shukra-Munawwar.jpg?ssl=1"),
  ];

  List<DramaCategory> get items {
    return [..._items];
  }

  set setCatTitle(String title) {
    catTitle = title;
    notifyListeners();
  }

  set categoryClick(bool val) {
    categoryClicked = val;
    notifyListeners();
  }

  set setCatId(String id) {
    catId = id;
    notifyListeners();
  }
}
