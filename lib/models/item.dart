//import 'dart:ffi';

class Item {
  final String id;
  final String category;
  final String title;
  final List<String> imageUrl;
  final String description;
  final List<Map<String, String>> cast;
  final List<Map<String, String>> directors;
  final List<Map<String, String>> producers;
  final List<String> genres;
  final bool isFavourite;
  final Map<String, String> reviews;
  final List<double> ratingValues;
  final double ratings;
  final Map<String, String> rateMap;
  final int ratedCount;
  final String youtubeURL;

  const Item({
    required this.id,
    required this.category,
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.cast,
    required this.directors,
    required this.producers,
    required this.genres,
    this.isFavourite = false,
    required this.reviews,
    required this.ratingValues,
    required this.rateMap,
    this.ratings = 0.0,
    this.ratedCount = 0,
    required this.youtubeURL,
  });
}
