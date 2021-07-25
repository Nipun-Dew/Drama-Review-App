import 'package:drama_app/models/item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class Items with ChangeNotifier {
  List<Item> _items = [
    Item(
        id: "I1",
        category: "C1",
        title: "Nadagamkarayo",
        imageUrl: "https://i.ytimg.com/vi/9ggS9gZdk0E/maxresdefault.jpg",
        description:
            "Nadagamkarayo is a drama based on a village life. Sara, Kiriputha, Kawadiya, Sudda are four young boys who sell toddy for living. Master is the musician in that village. First half of the story goes with the Vesak drama which is produced by the Master. Kukula lakuna is the rowdy of that village who is determined to be a politician",
        cast: [
          "Sara - Sajith Anthoney",
          "Patali - Senali Fonseka",
          "Master - Prasannajith Abeysuriya",
          "Malan - Kokila Pawan Jayasooriya",
          "Kukula Lakuna - Giriraj Kaushalya"
        ],
        director: "Jayaprakash Sivagurunadan",
        producer: "Chamara Samarawickrama  Saddhamangala Sooriyabandara",
        genre: Genre.Drama),
    Item(
        id: "I2",
        category: "C1",
        title: "Thnamalvila Kollek",
        imageUrl: "https://i.ytimg.com/vi/nSe4hW60FNI/maxresdefault.jpg",
        description:
            "Thnamalvila kollek a life story of a village boy who is struggeling with many problems as a person in a rural area. This teledrama shows how win his life and make a succefull artist. THis teledrama shows calm and peacefullnes of the village as well as the dark side of the village life as poverty and how people are strugling to win their lives",
        cast: [
          "Deeptha - Dhanuka Dilshan",
          "kithula - Xavier Kanishka",
          "koora - Nilanka Sepala Dahanayake",
          "Yashodhara - Yashoda Wimaladharma"
        ],
        director: "Roshan Ravindra",
        producer: "Fahim Maujude",
        genre: Genre.Drama),
    Item(
        id: "I3",
        category: "C2",
        title: "Agoha",
        imageUrl: "https://i.ytimg.com/vi/Jb4Z-MvRGPU/maxresdefault.jpg",
        description: "Agohsa is a.....",
        cast: [],
        director: "Director",
        producer: "Producer",
        genre: Genre.Thriller),
    Item(
        id: "I4",
        category: "C3",
        title: "Suriya arana",
        imageUrl: "https://alchetron.com/cdn/sooriya-arana-a7d4802e-fdba-4295-a481-245833fb71b-resize-750.jpg",
        description: "Suriya arana is a.....",
        cast: [],
        director: "Director",
        producer: "Producer",
        genre: Genre.Thriller),
  ];

  List<Item> get items {
    return [..._items];
  }

  List<Item> _favItems = [];

  set addFavItems(Item i) {
    _favItems.add(i);
    notifyListeners();
  }

  set delFavItems(Item i) {
    _favItems.remove(i);
    notifyListeners();
  }

  List<Item> get getFavItems {
    return [..._favItems];
  }
}