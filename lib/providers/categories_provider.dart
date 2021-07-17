import 'package:flutter/material.dart';
import '../models/category.dart';

class Categories with ChangeNotifier {
  List<Category> _items = [
    Category(id: "C1", title: "Teledrams", imageUrl: " "),
    Category(id: "C2", title: "Web Series", imageUrl: " "),
    Category(id: "C3", title: "Movies", imageUrl: " "),
    Category(id: "C4", title: "Documentries", imageUrl: " "),
  ];

  List<Category> get items {
    return [..._items];
  }
}
