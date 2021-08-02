import 'dart:ffi';

enum Genre { Drama, Thriller, Horror, Romamce, Action, Commody }

class Item {
  final String id;
  final String category;
  final String title;
  final List<String> imageUrl;
  final String description;
  final List<String> cast;
  final List<String> director;
  final List<String> producer;
  final Genre genre;
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
    required this.director,
    required this.producer,
    required this.genre,
    this.isFavourite = false,
    required this.comments,
    required this.ratingValues,
    this.ratings = 0.0,
    required this.trailerVideoUrl,
  });
}
