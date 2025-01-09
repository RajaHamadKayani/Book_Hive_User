import 'package:flutter/material.dart';
import 'package:book_hive_user/services/firestore_services.dart';

class BookRatingComponent extends StatefulWidget {
  final String userId;
  final String bookId;
  final List<Map<String, dynamic>> ratings;

  const BookRatingComponent({
    super.key,
    required this.userId,
    required this.bookId,
    required this.ratings,
  });

  @override
  State<BookRatingComponent> createState() => _BookRatingComponentState();
}

class _BookRatingComponentState extends State<BookRatingComponent> {
  int userRating = 0;
  final BookService _bookService = BookService();

  @override
  void initState() {
    super.initState();
    // Find the current user's rating if it exists
    userRating = widget.ratings
            .firstWhere((rating) => rating['userId'] == widget.userId, orElse: () => {'rating': 0})['rating'] ??
        0;
  }

  Future<void> updateRating(int rating) async {
    try {
      await _bookService.updateBookRating(widget.bookId, widget.userId, rating);
      setState(() {
        userRating = rating; // Update the local state
      });
    } catch (e) {
      print("Error updating rating: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap: () async {
            await updateRating(index + 1); // Update Firestore when rating changes
          },
          child: Icon(
            index < userRating ? Icons.star : Icons.star_outline,
            size: 16,
            color: index < userRating ? Colors.amber : Colors.grey,
          ),
        );
      }),
    );
  }
}
