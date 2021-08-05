import 'package:drama_app/models/item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class Items with ChangeNotifier {
  List<Item> _items = [
    Item(
        id: "I1",
        category: "C1",
        title: "Nadagamkarayo",
        imageUrls: [
          "https://steemitimages.com/p/TZjG7hXReeVoAvXt2X6pMxYAb3q65xMju8wryWxKrsghkLoEqpouqCt7QGaJSv8qX8FaMW8RPeeL3tyhpXaTGBZSDLGft3WXaxBBR9fFksjUiNZH9wsBe3nTQye4TPJHqPiCs7bCHDF2W2?format=match&mode=fit&width=800",
          "https://i2.wp.com/nadagamkarayo.com/wp-content/uploads/2021/07/Epi-130.jpg?fit=300%2C171&ssl=1",
          "https://i0.wp.com/nadagamkarayo.com/wp-content/uploads/2021/07/Epi-129.jpg?fit=300%2C171&ssl=1",
          "https://i0.wp.com/nadagamkarayo.com/wp-content/uploads/2021/07/Epi-131.jpg?fit=300%2C172&ssl=1"
        ],
        description:
            "Nadagamkarayo is a drama based on a village life. Sara, Kiriputha, Kawadiya, Sudda are four young boys who sell toddy for living. Master is the musician in that village. First half of the story goes with the Vesak drama which is produced by the Master. Kukula lakuna is the rowdy of that village who is determined to be a politician",
        // cast: [
        //   "Sara - Sajith Anthoney",
        //   "Patali - Senali Fonseka",
        //   "Master - Prasannajith Abeysuriya",
        //   "Malan - Kokila Pawan Jayasooriya",
        //   "Kukula Lakuna - Giriraj Kaushalya"
        // ],
        cast: [
          "Sajitha Anthoney",
          "Kokila Pawan",
          "Giriraj Kaushalya",
          "Senali Fonseka",
          "Praveena Disanayake"
        ],
        // director: "Jayaprakash Sivagurunadan",
        directors: ["D1"],
        producers: ["P1", "P2"],
        // producer: "Chamara Samarawickrama  Saddhamangala Sooriyabandara",
        genres: ["Drama"],
        reviews: {
          "userId1": "Great Teledrama ❤️",
          "userId2": "Best Acting 🔥",
          "userId3": "kukulai kikili patiyai 😂😂😂",
          "userId4": "කැකුලා සරාගෙන් කනවා බලන්න ආස අය කෝ.. 😡",
          "userId5": "Amboo ape Malan aiyya dena athal nm..."
        },
        ratingValues: [],
        rateMap: {},
        ratings: 0,
        youtubeURL:
            "https://www.youtube.com/watch?v=gMv_QGTX7OQ&list=RDgMv_QGTX7OQ&start_radio=1"),
    Item(
        id: "I2",
        category: "C1",
        title: "Thnamalvila Kollek",
        imageUrls: [
          "https://i.ytimg.com/vi/nSe4hW60FNI/maxresdefault.jpg",
          "https://m.media-amazon.com/images/M/MV5BZDMzMGRlMmYtNmU1YS00Y2Y5LWEzMmItZjNjYjQ5ZjFhNzM2XkEyXkFqcGdeQXVyMTE3MTI4NTI2._V1_.jpg",
          "https://www.itntv.lk/wp-content/uploads/2020/04/thanamalvila-kollek-episode-28-2.jpg",
          "https://www.itntv.lk/wp-content/uploads/2020/04/thanamalvila-kollek-episode-26-2.jpg",
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQKwtNQ7JWzugWVx__wcBa97phJ4TuAQV3K2nyU79s-UhrGigAz5Bhq471hHR70V_BFi34&usqp=CAU",
          "https://www.itntv.lk/wp-content/uploads/2020/04/thanamalvila-kollek-episode-28-2.jpg"
        ],
        description:
            "Thnamalvila kollek a life story of a village boy who is struggeling with many problems as a person in a rural area. This teledrama shows how win his life and make a succefull artist. THis teledrama shows calm and peacefullnes of the village as well as the dark side of the village life as poverty and how people are strugling to win their lives",
        // cast: ["Deeptha - Dhanuka Dilshan", "kithula - Xavier Kanishka", "koora - Nilanka Sepala Dahanayake", "Yashodhara - Yashoda Wimaladharma"],
        cast: [
          "Kalani Dodantenna",
          "Yashoda Wimalaweera",
          "Danuka Dilshan",
          "Hemasiri Liyanage"
        ],
        // director: "Roshan Ravindra",
        // producer: "Fahim Maujude",
        directors: ["D1"],
        producers: ["P2"],
        genres: ["Drama"],
        reviews: {"userId1": "Great story", "userId2": "Superb camera shots"},
        ratingValues: [],
        rateMap: {},
        ratings: 1,
        youtubeURL: "https://www.youtube.com/watch?v=L4DRwfjjnCw"),
    Item(
        id: "I3",
        category: "C2",
        title: "Agoha",
        imageUrls: ["https://i.ytimg.com/vi/Jb4Z-MvRGPU/maxresdefault.jpg"],
        description: "Agohsa is a.....",
        cast: [],
        // director: "Director",
        // producer: "Producer",
        directors: ["D1"],
        producers: ["P2"],
        genres: ["Thriller"],
        reviews: {
          "userId1": "Waiting for Episode2",
          "userId2": "Good initiative"
        },
        ratingValues: [],
        rateMap: {},
        ratings: 1,
        youtubeURL: "https://www.youtube.com/watch?v=esU2KhThkzc"),
    Item(
        id: "I4",
        category: "C3",
        title: "Machan",
        imageUrls: [
          "https://m.media-amazon.com/images/M/MV5BMzZhN2YxYWEtMjY0Mi00NWRhLWE0ZjktMDM1ZWI5ZTA4MTE5XkEyXkFqcGdeQXVyNTA3MDM5MTM@._V1_.jpg"
        ],
        description: "Machan is a movie.....",
        cast: [],
        //
        directors: ["D1"],
        producers: ["P2"],
        genres: ["Drama"],
        reviews: {"userId1": "hahahaaaa", "userId2": "mara dial tikk neh mun"},
        ratingValues: [],
        rateMap: {},
        ratings: 1,
        youtubeURL: "https://www.youtube.com/watch?v=kW9ijxpZc-0"),
  ];

  List<Item> get items {
    return [..._items];
  }

  // List<String> get comments {
  //   return [...comments];
  // }

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
