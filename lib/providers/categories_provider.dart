import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import '../models/category.dart';

class Categories with ChangeNotifier {
  bool categoryClicked = false;
  String catTitle = "";
  String catId = "";

  List<DramaCategory> _items = [
    DramaCategory(id: "teledrama", title: "Teledramas", imageUrl: "https://www.itntv.lk/wp-content/uploads/2020/06/thanamalvila-kollek-episode-40-2-407x229.jpg"),
    DramaCategory(id: "web-series", title: "Web Series", imageUrl: "https://i.ytimg.com/vi/Jb4Z-MvRGPU/maxresdefault.jpg"),
    DramaCategory(id: "movie", title: "Movies", imageUrl: "https://i.ytimg.com/vi/qGeVRCI2P-0/maxresdefault.jpg"),
    DramaCategory(id: "short-movie", title: "Short Movies", imageUrl: "https://d3dz4rogqkqh6r.cloudfront.net/uploads/files/2016/12/yimg_YPYLnM.png"),
    DramaCategory(id: "mini-series", title: "Mini Series", imageUrl: "http://www.derana.lk/image/cache/data/Podu/1609070027thumb_podu_e10-362x132.jpg"),
    // DramaCategory(id: "old-hits", title: "Old Hits", imageUrl: "https://images.mubicdn.net/images/film/276178/cache-577198-1597510846/image-w1280.jpg?size=740x"),
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
