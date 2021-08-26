import 'dart:ffi';
import 'dart:io';

import 'package:drama_app/models/item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class Items with ChangeNotifier {
  // List<Item> _items = [];

  List<Item> _movieItems = [];
  List<Item> _teledramaItems = [];
  List<Item> _webseriesItems = [];
  List<Item> _shortmovieItems = [];
  List<Item> _miniseriesItems = [];
  List<Item> _oldhitsItems = [];

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

//////////////////////Get Fav Items//////////////////////////////////////////////

  Future<List<Item>> getFavourits(String token) async {
    var url = Uri.parse("https://sl-cinema.herokuapp.com/user/cinema/get/wish-list");

    try {
      final response = await http.get(
        url,
        headers: {
          HttpHeaders.authorizationHeader: "Bearer " + token,
          "content-type": "application/json",
        },
      );

      final List<Item> loadedFavItems = [];
      final extractedItems = json.decode(response.body);

      print(extractedItems);

      extractedItems.forEach((item) {
        final List<String> urls = [];
        final List<Map<String, String>> casts = [];
        final List<Map<String, String>> diRectors = [];
        final List<Map<String, String>> proDucers = [];
        final List<String> genErs = [];
        final List<Map<String, String>> raTes = [];
        final List<Map<String, dynamic>> reViews = [];

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
            "imageUrl": cast['imageUrl'] ?? "https://1.bp.blogspot.com/-Yse-3Lsfexo/XqSuUgy1UrI/AAAAAAAABwU/3viZGIYZjQg1TyXyf7ATttMd_zoxmIU0QCLcBGAsYHQ/s1600/12.jpg",
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

        // print(item['rateMap']);

        item['rateMap'].forEach((k, v) => {
              raTes.add({
                "user": k.toString(),
                "rate": v.toString(),
              })
            });

        item['reviews'].forEach((k, v) => {
              reViews.add({
                "user": k.toString(),
                "review": v,
              })
            });

        // print(reViews);

        // print(item['reviews']);

        loadedFavItems.add(Item(
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
          rateMap: raTes,
          reviews: reViews,
          ratings: item['ratings'],
          ratedCount: item['ratedCount'],
        ));
      });

      _favItems = loadedFavItems;
      notifyListeners();
      isLoading = false;
      notifyListeners();
      return loadedFavItems;
    } catch (err) {
      throw err;
    }
  }

  bool isFavProv = false;

  set setIsFavProv(bool val) {
    isFavProv = val;
    notifyListeners();
  }

//////////////////////////Get Items////////////////////////////////////////
  bool isLoading = true;

  Future<void> executeMethod(String urlLink, String itemListName) async {
    var url = Uri.parse(urlLink.toString());

    try {
      if ((flagTele && itemListName == "teledramaItems")) {
        isLoading = false;
        notifyListeners();
      } else if ((flagMovies && itemListName == "movieItems")) {
        isLoading = false;
        notifyListeners();
      } else if ((flagWeb && itemListName == "webseriesItems")) {
        isLoading = false;
        notifyListeners();
      } else if ((flagMini && itemListName == "miniseriesItems")) {
        isLoading = false;
        notifyListeners();
      } else if ((flagShort && itemListName == "shortmovieItems")) {
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = true;
        notifyListeners();
      }

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
        final List<Map<String, String>> raTes = [];
        final List<Map<String, dynamic>> reViews = [];

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
            "imageUrl": cast['imageUrl'] ?? "https://1.bp.blogspot.com/-Yse-3Lsfexo/XqSuUgy1UrI/AAAAAAAABwU/3viZGIYZjQg1TyXyf7ATttMd_zoxmIU0QCLcBGAsYHQ/s1600/12.jpg",
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

        if (item['rateMap'] != null) {
          item['rateMap'].forEach((k, v) => {
                raTes.add({
                  "user": k.toString(),
                  "rate": v.toString(),
                })
              });
        } else {
          raTes.add({
            "user": "NOUSER",
            "rate": "0",
          });
        }

        if (item['reviews'] != null) {
          item['reviews'].forEach((k, v) => {
                reViews.add({
                  "user": k.toString(),
                  "review": v,
                })
              });
        }

        // print(reViews);

        // print(item['reviews']);

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
          rateMap: raTes,
          reviews: reViews,
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

  late bool flagTele = false;
  late bool flagMovies = false;
  late bool flagWeb = false;
  late bool flagMini = false;
  late bool flagShort = false;

  Future<void> getTeledramas() async {
    executeMethod("https://sl-cinema.herokuapp.com/cinema/teledrama/all", "teledramaItems");
    flagTele = true;
  }

  Future<void> getMovies() async {
    executeMethod("https://sl-cinema.herokuapp.com/cinema/movies/all", "movieItems");
    flagMovies = true;
  }

  Future<void> getWebSeries() async {
    executeMethod("https://sl-cinema.herokuapp.com/cinema/web-series/all", "webseriesItems");
    flagWeb = true;
  }

  Future<void> getMiniSeries() async {
    executeMethod("https://sl-cinema.herokuapp.com/cinema/mini-series/all", "miniseriesItems");
    flagMini = true;
  }

  Future<void> getShortMovies() async {
    executeMethod("https://sl-cinema.herokuapp.com/cinema/short-movies/all", "shortmovieItems");
    flagShort = true;
  }

////////////////////////POST Items//////////////////////////////
  Future<void> addItem(Item item, String token) {
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
        HttpHeaders.authorizationHeader: "Bearer " + token,
        "content-type": "application/json",
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
        id: item.id,
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
        if (item.category.toString() == "teledramaItems") {
          _teledramaItems.add(newItem);
        }
        if (item.category.toString() == "webseriesItems") {
          _webseriesItems.add(newItem);
        }
        if (item.category.toString() == "movieItems") {
          _movieItems.add(newItem);
        }
        if (item.category.toString() == "shortmovieItems") {
          _shortmovieItems.add(newItem);
        }
        if (item.category.toString() == "miniseriesItems") {
          _miniseriesItems.add(newItem);
        }
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

  ////////////////////////Update Items//////////////////////////////
  Future<void> updateItem(Item item, String token) {
    var url = Uri.parse("https://sl-cinema.herokuapp.com/admin/editor/cinema/edit/item");

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

    print(token);

    return http
        .put(
      url,
      headers: {
        HttpHeaders.authorizationHeader: "Bearer " + token,
        "content-type": "application/json",
      },
      body: json.encode({
        "id": item.id,
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
        id: item.id,
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
        // if (item.category.toString() == "teledramaItems") {

        //   _teledramaItems.add(newItem);
        // }
        // if (item.category.toString() == "webseriesItems") {
        //   _webseriesItems.add(newItem);
        // }
        // if (item.category.toString() == "movieItems") {
        //   _movieItems.add(newItem);
        // }
        // if (item.category.toString() == "shortmovieItems") {
        //   _shortmovieItems.add(newItem);
        // }
        // if (item.category.toString() == "miniseriesItems") {
        //   _miniseriesItems.add(newItem);
        // }
        // print("Item added");

        // notifyListeners();
      } else {
        print("Item not added");
        throw HttpException(response.body);
      }
    }).catchError((error) {
      throw error;
    });
  }
}
