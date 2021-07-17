enum Genre { Drama, Thriller, Horror, Romamce, Action, Commody }

class Item {
  final String id;
  final String category;
  final String title;
  final String imageUrl;
  final String description;
  final List<String> cast;
  final String director;
  final String producer;
  final Genre genre;
  final bool isFavourite;

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
  });
}
