class Book {
  String id;
  String title;
  String author;
  String genre;
  String description;
  // String coverImage;
  DateTime createdAt;

  Book({
    required this.id,
    required this.title,
    required this.description,
    required this.author,
    required this.genre,
    // required this.coverImage,
    required this.createdAt,
  });

  // Convert Book object to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'description':description,
      'genre': genre,
      // 'coverImage': coverImage,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // Create a Book object from Firestore Map
  factory Book.fromMap(Map<String, dynamic> map, String documentId) {
    return Book(
      description: map['description'],
      id: documentId,
      title: map['title'] ?? '',
      author: map['author'] ?? '',
      genre: map['genre'] ?? '',
      // coverImage: map['coverImage'] ?? '',
      createdAt:
          DateTime.parse(map['createdAt'] ?? DateTime.now().toIso8601String()),
    );
  }
}
