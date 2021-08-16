import 'dart:io';

import 'package:drama_app/models/item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class Items with ChangeNotifier {
  List<Item> _items = [];

  List<Item> _movieItems = [];
  List<Item> _teledramaItems = [];
  List<Item> _webseriesItems = [];
  List<Item> _shortmovieItems = [];
  List<Item> _miniseriesItems = [];
  List<Item> _oldhitsItems = [];

  List<Item> get items {
    return [..._items];
  }

  List<Item> get movieItems {
    return [..._movieItems];
  }

  List<Item> get teledramaItems {
    return [..._teledramaItems];
  }

  List<Item> get webseriesItems {
    return [..._webseriesItems];
  }

  List<Item> get shortmovieItems {
    return [..._shortmovieItems];
  }

  List<Item> get miniseriesItems {
    return [..._miniseriesItems];
  }

  List<Item> get oldhitsItems {
    return [..._oldhitsItems];
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

//////////////////////////Get Items////////////////////////////////////////
  bool isLoading = true;

  Future<void> executeMethod(String urlLink, String itemListName) async {
    isLoading = true;

    var url = Uri.parse(urlLink.toString());

    try {
      final response = await http.get(url);

      final List<Item> loadedItems = [];
      final extractedItems = json.decode(response.body);
      print(extractedItems);

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
            "imageUrl": cast['imageUrl'] ?? "https://1.bp.blogspot.com/-Yse-3Lsfexo/XqSuUgy1UrI/AAAAAAAABwU/3viZGIYZjQg1TyXyf7ATttMd_zoxmIU0QCLcBGAsYHQ/s1600/12.jpg",
          });
        });

        item['producers'].forEach((cast) {
          proDucers.add({
            "role": cast['role'],
            "starID": cast['starID'],
            "imageUrl": cast['imageUrl'] ?? "https://1.bp.blogspot.com/-Yse-3Lsfexo/XqSuUgy1UrI/AAAAAAAABwU/3viZGIYZjQg1TyXyf7ATttMd_zoxmIU0QCLcBGAsYHQ/s1600/12.jpg",
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

      if (itemListName.toString() == "teledramaItems") {
        _teledramaItems = loadedItems;
      }
      if (itemListName.toString() == "webseriesItems") {
        _webseriesItems = loadedItems;
      }
      if (itemListName.toString() == "movieItems") {
        _movieItems = loadedItems;
      }
      if (itemListName.toString() == "shortmovieItems") {
        _shortmovieItems = loadedItems;
      }
      if (itemListName.toString() == "miniseriesItems") {
        _miniseriesItems = loadedItems;
      }

      isLoading = false;
      notifyListeners();
    } catch (err) {
      throw err;
    }
  }

  Future<void> getTeledramas() async {
    executeMethod("https://sl-cinema.herokuapp.com/cinema/teledrama/all", "teledramaItems");
  }

  Future<void> getMovies() async {
    executeMethod("https://sl-cinema.herokuapp.com/cinema/movies/all", "movieItems");
  }

  Future<void> getWebSeries() async {
    executeMethod("https://sl-cinema.herokuapp.com/cinema/web-series/all", "webseriesItems");
  }

  Future<void> getMiniSeries() async {
    executeMethod("https://sl-cinema.herokuapp.com/cinema/mini-series/all", "miniseriesItems");
  }

  Future<void> getShortMovies() async {
    executeMethod("https://sl-cinema.herokuapp.com/cinema/short-movies/all", "shortmovieItems");
  }

////////////////////////POST Items//////////////////////////////
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

    // print(item);

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
