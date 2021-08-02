class User {
  final String id;
  final String name;
  final String userName;
  final String password;
  final String imageUrl;
  final List<Map<String, String>> commnets; // eventId comment
  final List<String> likedItems;

  const User({
    required this.id,
    required this.name,
    required this.userName,
    required this.password,
    required this.imageUrl,
    required this.commnets,
    required this.likedItems,
  });
}
