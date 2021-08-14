import 'dart:io';

import 'package:drama_app/models/item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class Items with ChangeNotifier {
  List<Item> _items = [
    // Item(
    //     id: "I1",
    //     category: "C1",
    //     title: "Nadagamkarayo",
    //     imageUrls: [
    //       "https://steemitimages.com/p/TZjG7hXReeVoAvXt2X6pMxYAb3q65xMju8wryWxKrsghkLoEqpouqCt7QGaJSv8qX8FaMW8RPeeL3tyhpXaTGBZSDLGft3WXaxBBR9fFksjUiNZH9wsBe3nTQye4TPJHqPiCs7bCHDF2W2?format=match&mode=fit&width=800",
    //       "https://i2.wp.com/nadagamkarayo.com/wp-content/uploads/2021/07/Epi-130.jpg?fit=300%2C171&ssl=1",
    //       "https://i0.wp.com/nadagamkarayo.com/wp-content/uploads/2021/07/Epi-129.jpg?fit=300%2C171&ssl=1",
    //       "https://i0.wp.com/nadagamkarayo.com/wp-content/uploads/2021/07/Epi-131.jpg?fit=300%2C172&ssl=1"
    //     ],
    //     description:
    //         "Nadagamkarayo is a drama based on a village life. Sara, Kiriputha, Kawadiya, Sudda are four young boys who sell toddy for living. Master is the musician in that village. First half of the story goes with the Vesak drama which is produced by the Master. Kukula lakuna is the rowdy of that village who is determined to be a politician",
    //     cast: [
    //       {"role": "Sara", "starID": "Sajitha Anthoney"},
    //       {"role": "Malan", "starID": "Kokila Pawan"},
    //       {"role": "Kabral", "starID": "Giriraj Kaushalya"},
    //       {"role": "Patali", "starID": "Senali Fonseka"},
    //       {"role": "Geethika", "starID": "Praveena Disanayake"}
    //     ],
    //     directors: [
    //       {"role": "director", "starID": "Kokila Pawan"}
    //     ],
    //     producers: [
    //       {"role": "producer", "starID": "Giriraj Kaushalya"},
    //       {"role": "producer", "starID": "Sajitha Anthoney"}
    //     ],
    //     genres: ["Drama"],
    //     reviews: {
    //       "userId1": "Great Teledrama ❤️",
    //       "userId2": "Best Acting 🔥",
    //       "userId3": "kukulai kikili patiyai 😂😂😂",
    //       "userId4": "කැකුලා සරාගෙන් කනවා බලන්න ආස අය කෝ.. 😡",
    //       "userId5": "Amboo ape Malan aiyya dena athal nm..."
    //     },
    //     ratingValues: [],
    //     rateMap: {},
    //     ratings: 0,
    //     youtubeURL: "https://www.youtube.com/watch?v=gMv_QGTX7OQ&list=RDgMv_QGTX7OQ&start_radio=1"),
    // Item(
    //     id: "I2",
    //     category: "C1",
    //     title: "Thnamalvila Kollek",
    //     imageUrls: [
    //       "https://i.ytimg.com/vi/nSe4hW60FNI/maxresdefault.jpg",
    //       "https://m.media-amazon.com/images/M/MV5BZDMzMGRlMmYtNmU1YS00Y2Y5LWEzMmItZjNjYjQ5ZjFhNzM2XkEyXkFqcGdeQXVyMTE3MTI4NTI2._V1_.jpg",
    //       "https://www.itntv.lk/wp-content/uploads/2020/04/thanamalvila-kollek-episode-28-2.jpg",
    //       "https://www.itntv.lk/wp-content/uploads/2020/04/thanamalvila-kollek-episode-26-2.jpg",
    //       "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQKwtNQ7JWzugWVx__wcBa97phJ4TuAQV3K2nyU79s-UhrGigAz5Bhq471hHR70V_BFi34&usqp=CAU",
    //       "https://www.itntv.lk/wp-content/uploads/2020/04/thanamalvila-kollek-episode-28-2.jpg"
    //     ],
    //     description:
    //         "Thnamalvila kollek a life story of a village boy who is struggeling with many problems as a person in a rural area. This teledrama shows how win his life and make a succefull artist. THis teledrama shows calm and peacefullnes of the village as well as the dark side of the village life as poverty and how people are strugling to win their lives",
    //     // cast: ["Deeptha - Dhanuka Dilshan", "kithula - Xavier Kanishka", "koora - Nilanka Sepala Dahanayake", "Yashodhara - Yashoda Wimaladharma"],
    //     cast: [
    //       {"role": "Amasha", "starID": "Kalani Dodantenna"},
    //       {"role": "Yashoda", "starID": "Yashoda Wimalaweera"},
    //       {"role": "Deeptha", "starID": "Danuka Dilshan"},
    //       {"role": "Deepthas Father", "starID": "Hemasiri Liyanage"}
    //     ],
    //     // director: "Roshan Ravindra",
    //     // producer: "Fahim Maujude",
    //     directors: [
    //       {"role": "director", "starID": "Sajitha Anthoney"}
    //     ],
    //     producers: [
    //       {"role": "producer", "starID": "Kokila Pawan"}
    //     ],
    //     genres: ["Drama"],
    //     reviews: {"userId1": "Great story", "userId2": "Superb camera shots"},
    //     ratingValues: [],
    //     rateMap: {},
    //     ratings: 1,
    //     youtubeURL: "https://www.youtube.com/watch?v=L4DRwfjjnCw"),
    // Item(
    //     id: "I3",
    //     category: "C2",
    //     title: "Agoha",
    //     imageUrls: ["https://i.ytimg.com/vi/Jb4Z-MvRGPU/maxresdefault.jpg"],
    //     description: "Agohsa is a.....",
    //     cast: [],
    //     // director: "Director",
    //     // producer: "Producer",
    //     directors: [
    //       {"role": "director", "starID": "Jayaprakash Sivagurunadan"}
    //     ],
    //     producers: [
    //       {"role": "producer", "starID": "Chamara Samarawickrama"}
    //     ],
    //     genres: ["Thriller"],
    //     reviews: {"userId1": "Waiting for Episode2", "userId2": "Good initiative"},
    //     ratingValues: [],
    //     rateMap: {},
    //     ratings: 1,
    //     youtubeURL: "https://www.youtube.com/watch?v=esU2KhThkzc"),
    // Item(
    //     id: "I4",
    //     category: "C3",
    //     title: "Machan",
    //     imageUrls: ["https://m.media-amazon.com/images/M/MV5BMzZhN2YxYWEtMjY0Mi00NWRhLWE0ZjktMDM1ZWI5ZTA4MTE5XkEyXkFqcGdeQXVyNTA3MDM5MTM@._V1_.jpg"],
    //     description: "Machan is a movie.....",
    //     cast: [],
    //     //
    //     directors: [
    //       {"role": "director", "starID": "Jayaprakash Sivagurunadan"}
    //     ],
    //     producers: [
    //       {"role": "producer", "starID": "Chamara Samarawickrama"}
    //     ],
    //     genres: ["Drama"],
    //     reviews: {"userId1": "hahahaaaa", "userId2": "mara dial tikk neh mun"},
    //     ratingValues: [],
    //     rateMap: {},
    //     ratings: 1,
    //     youtubeURL: "https://www.youtube.com/watch?v=kW9ijxpZc-0"),
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

  bool isLoading = true;

  Future<void> executeMethod(String urlLink) async {
    var url = Uri.parse(urlLink);

    try {
      final response = await http.get(url);

      final List<Item> loadedItems = [];
      final extractedItems = json.decode(response.body);

      // print(extractedItems);

      extractedItems.forEach((item) {
        final List<String> urls = [];
        final List<Map<String, String>> casts = [];
        final List<Map<String, String>> diRectors = [];
        final List<Map<String, String>> proDucers = [];
        final List<String> genErs = [];

        item['imageUrls'].forEach((url) {
          urls.add(url.toString());
        });

        item['genres'].forEach((item) {
          genErs.add(item.toString());
        });

        item['cast'].forEach((cast) {
          casts.add({
            "role": cast['role'],
            "starID": cast['starID'],
            "imageUrl": cast['imageUrl'],
          });
        });

        item['directors'].forEach((cast) {
          diRectors.add({
            "role": cast['role'],
            "starID": cast['starID'],
            // "imageUrl": cast['imageUrl'],
          });
        });

        item['producers'].forEach((cast) {
          proDucers.add({
            "role": cast['role'],
            "starID": cast['starID'],
            // "imageUrl": cast['imageUrl'],
          });
        });

        loadedItems.add(Item(
          id: item['id'].toString(),
          title: item['title'],
          category: item['category'],
          imageUrls: urls,
          description: item['description'],
          cast: casts,
          directors: diRectors,
          producers: proDucers,
          genres: genErs,
          youtubeURL: item['youtubeURL'],
          // rateMap: item['rateMap'],
          // reviews: item['reviews'],
          rateMap: {
            "role": "role",
            "starID": "satarID",
          },
          reviews: {
            "role": "role",
            "starID": "satarID",
          },
          ratings: item['ratings'],
          ratedCount: item['ratedCount'],
        ));
      });

      // print(response.body);
      isLoading = false;
      _items = loadedItems;
      notifyListeners();
    } catch (err) {
      throw err;
    }
  }

  Future<void> getTeledramas() async {
    executeMethod("https://sl-cinema.herokuapp.com/cinema/teledrama/all");
    // var url = Uri.parse("https://sl-cinema.herokuapp.com/cinema/teledrama/all");
  }

  Future<void> getMovies() async {
    executeMethod("https://sl-cinema.herokuapp.com/cinema/movies/all");
    // var url = Uri.parse("https://sl-cinema.herokuapp.com/cinema/movies/all");
  }

  Future<void> getWebSeries() async {
    executeMethod("https://sl-cinema.herokuapp.com/cinema/web-series/all");
    // var url = Uri.parse("https://sl-cinema.herokuapp.com/cinema/web-series/all");
  }

  Future<void> getMiniSeries() async {
    executeMethod("https://sl-cinema.herokuapp.com/cinema/mini-series/all");
    // var url = Uri.parse("https://sl-cinema.herokuapp.com/cinema/mini-series/all");
  }

  Future<void> getShortMovies() async {
    executeMethod("https://sl-cinema.herokuapp.com/cinema/short-movies/all");
    // var url = Uri.parse("https://sl-cinema.herokuapp.com/cinema/short-movies/all");
  }

  Future<void> addItem(Item item) {
    var url = Uri.parse("https://sl-cinema.herokuapp.com/admin/editor/cinema/add/item");

    // print(item.id);
    // print(item.title);
    // print(item.category);
    // print(item.description);
    // print(item.cast);
    // print(item.directors);
    // print(item.producers);
    // print(item.youtubeURL);
    // print(item.imageUrls);

    print(item);

    return http
        .post(
      url,
      headers: {
        HttpHeaders.authorizationHeader:
            "Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbkBnbWFpbC5jb20iLCJyb2xlIjpbeyJhdXRob3JpdHkiOiJST0xFX0FETUlOIn1dLCJlbmFibGUiOnRydWUsImV4cCI6MTYyOTE2MzU2NywiaWF0IjoxNjI4OTQ3NTY3fQ.LZW7vsYx8yZu9VkPPgmgMuvTE7794lkXyuy1je4ntKg",
        "content-type": "application/json"
      },
      body: json.encode({
        "title": item.title,
        "category": item.category,
        "imageUrls": item.imageUrls,
        "description": item.description,
        "cast": item.cast,
        "directors": item.directors,
        "producers": item.producers,
        "genres": item.genres,
        "youtubeURL": item.youtubeURL,
      }),
    )
        .then((response) {
      final newItem = Item(
        id: DateTime.now().toString(),
        category: item.category,
        title: item.title,
        imageUrls: item.imageUrls,
        description: item.description,
        cast: item.cast,
        directors: item.directors,
        producers: item.producers,
        genres: item.genres,
        reviews: item.reviews,
        // ratingValues: item.ratingValues,
        rateMap: item.rateMap,
        youtubeURL: item.youtubeURL,
      );

      print(response.statusCode);

      if (response.statusCode.toString() == "200") {
        _items.add(newItem);
        print("Item added");

        notifyListeners();
      } else {
        print("Item not added");
        throw HttpException(response.body);
      }
    }).catchError((error) {
      throw error;
    });
  }
}
