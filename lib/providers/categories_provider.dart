import 'package:flutter/material.dart';
import '../models/category.dart';

class Categories with ChangeNotifier {
  List<Category> _items = [
    Category(
        id: "C1",
        title: "Teledrams",
        imageUrl: "https://images.unsplash.com/reserve/bOvf94dPRxWu0u3QsPjF_tree.jpg?ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8bmF0dXJhbHxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60"),
    Category(
        id: "C2",
        title: "Web Series",
        imageUrl: "https://images.unsplash.com/reserve/bOvf94dPRxWu0u3QsPjF_tree.jpg?ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8bmF0dXJhbHxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60"),
    Category(
        id: "C3",
        title: "Movies",
        imageUrl: "https://images.unsplash.com/reserve/bOvf94dPRxWu0u3QsPjF_tree.jpg?ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8bmF0dXJhbHxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60"),
    Category(
        id: "C4",
        title: "Documentries",
        imageUrl: "https://images.unsplash.com/reserve/bOvf94dPRxWu0u3QsPjF_tree.jpg?ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8bmF0dXJhbHxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60"),
  ];

  List<Category> get items {
    return [..._items];
  }
}
