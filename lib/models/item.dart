import 'dart:ffi';

class Item {
  final String id;
  final String category;
  final String title;
  final List<String> imageUrl;
  final String description;
  final List<String> cast;
  final List<String> directors;
  final List<String> producers;
  final List<String> genres;
  final bool isFavourite;
  final List<String> comments;
  // final List<String> likedUsers;
  final List<double> ratingValues;
  final double ratings;
  final String trailerVideoUrl;

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
    required this.comments,
    required this.ratingValues,
    this.ratings = 0.0,
    required this.trailerVideoUrl,
  });
}
