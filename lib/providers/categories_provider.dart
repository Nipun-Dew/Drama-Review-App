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
        title: "Teledrams",
        imageUrl: "https://images.unsplash.com/reserve/bOvf94dPRxWu0u3QsPjF_tree.jpg?ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8bmF0dXJhbHxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60"),
    DramaCategory(
        id: "C2",
        title: "Web Series",
        imageUrl: "https://images.unsplash.com/reserve/bOvf94dPRxWu0u3QsPjF_tree.jpg?ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8bmF0dXJhbHxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60"),
    DramaCategory(
        id: "C3",
        title: "Movies",
        imageUrl: "https://images.unsplash.com/reserve/bOvf94dPRxWu0u3QsPjF_tree.jpg?ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8bmF0dXJhbHxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60"),
    DramaCategory(
        id: "C4",
        title: "Documentries",
        imageUrl: "https://images.unsplash.com/reserve/bOvf94dPRxWu0u3QsPjF_tree.jpg?ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8bmF0dXJhbHxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60"),
    DramaCategory(
        id: "C5",
        title: "Cartoons",
        imageUrl: "https://images.unsplash.com/reserve/bOvf94dPRxWu0u3QsPjF_tree.jpg?ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8bmF0dXJhbHxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60"),
    DramaCategory(
        id: "C6",
        title: "Educational",
        imageUrl: "https://images.unsplash.com/reserve/bOvf94dPRxWu0u3QsPjF_tree.jpg?ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8bmF0dXJhbHxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60"),
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
