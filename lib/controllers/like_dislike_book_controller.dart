import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/firestore_services.dart';

class LikeDislikeBookController extends GetxController {
  final BookService _bookService = BookService();

  var likes = [].obs;
  var dislikes = [].obs;

  // Listen for real-time updates
  void listenToBook(String bookId) {
    _bookService.getBookStream(bookId).listen((snapshot) {
      if (snapshot.exists) {
        likes.value = List<String>.from(snapshot['likes'] ?? []);
        dislikes.value = List<String>.from(snapshot['dislikes'] ?? []);
      }
    });
  }

  Future<void> toggleLike(String bookId, String userId) async {
    await _bookService.toggleLike(bookId, userId);
  }

  Future<void> toggleDislike(String bookId, String userId) async {
    await _bookService.toggleDislike(bookId, userId);
  }
}
