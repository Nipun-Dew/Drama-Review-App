import 'package:drama_app/models/item.dart';
import 'package:flutter/material.dart';

class Items with ChangeNotifier {
  List<Item> _items = [
    Item(
        id: "I1",
        category: "C1",
        title: "Nadagamkarayo",
        imageUrl: " ",
        description:
            "Nadagamkarayo is a drama based on a village life. Sara, Kiriputha, Kawadiya, Sudda are four young boys who sell toddy for living. Master is the musician in that village. First half of the story goes with the Vesak drama which is produced by the Master. Kukula lakuna is the rowdy of that village who is determined to be a politician",
        cast: ["Sara - Sajith Anthoney", "Patali - Senali Fonseka", "Master - Prasannajith Abeysuriya", "Malan - Kokila Pawan Jayasooriya", "Kukula Lakuna - Giriraj Kaushalya"],
        director: "Director",
        producer: "Producer",
        genre: Genre.Drama),
    Item(id: "I2", category: "C1", title: "Thnamalvila Kollek", imageUrl: " ", description: "Thnamalvila kollek is a.....", cast: [], director: "Director", producer: "Producer", genre: Genre.Drama),
    Item(id: "I3", category: "C2", title: "Agoha", imageUrl: " ", description: "Agohsa is a.....", cast: [], director: "Director", producer: "Producer", genre: Genre.Thriller),
    Item(id: "I4", category: "C3", title: "Suriya arana", imageUrl: " ", description: "Suriya arana is a.....", cast: [], director: "Director", producer: "Producer", genre: Genre.Thriller),
  ];

  List<Item> get items {
    return [..._items];
  }
}
