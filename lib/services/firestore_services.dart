import 'package:book_hive_user/models/book_model.dart';
import 'package:book_hive_user/utils/toast_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class BookService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add a new book to Firestore
  Future<void> addBook(Book book) async {
    try {
      await _firestore.collection('books').doc(book.id).set(book.toMap());
    } catch (e) {
      rethrow;
    }
  }

  // Fetch all books from Firestore
  Future<List<Book>> fetchBooks() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('books').get();
      return snapshot.docs
          .map(
              (doc) => Book.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
    Future<List<Book>> fetchAllBookMarkedBooks() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('bookmarks').get();
      return snapshot.docs
          .map(
              (doc) => Book.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    } catch (e) {
      rethrow;
    }
  }


  // Update an existing book in Firestore
  Future<void> updateBook(Book book) async {
    try {
      await _firestore.collection('books').doc(book.id).update(book.toMap());
    } catch (e) {
      rethrow;
    }
  }

  // Delete a book from Firestore
  Future<void> deleteBook(String bookId) async {
    try {
      await _firestore.collection('books').doc(bookId).delete();
    } catch (e) {
      rethrow;
    }
  }
  // Delete a book from Firestore
  Future<void> deleteBookedMarkBook(String bookId) async {
    try {
      await _firestore.collection('bookmarks').doc(bookId).delete();
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<Map<String, dynamic>>> getRecommendationsStream(String bookId) {
    return _firestore.collection('books').doc(bookId).snapshots().map((doc) {
      if (doc.exists) {
        final data = doc.data();
        // Ensure 'recommendations' is always treated as a list of maps
        if (data != null && data['recommendations'] is List) {
          return List<Map<String, dynamic>>.from(data['recommendations']);
        }
      }
      return [];
    });
  }

  // Add a recommendation to Firestore
  Future<void> addRecommendation(String bookId, String userId,
      String recommendation, String userName, String dateTime) async {
    try {
      final bookRef = _firestore.collection('books').doc(bookId);

      await bookRef.update({
        'recommendations': FieldValue.arrayUnion([
          {
            'userId': userId,
            'recommendation': recommendation,
            'userName': userName,
            "dateTime": dateTime
          },
        ]),
      });
    } catch (e) {
      throw Exception("Error adding recommendation: $e");
    }
  }

  // Add a reply to a specific recommendation
  Future<void> addReplyToRecommendation(String bookId, int recommendationIndex,
      String userId, String replyText, String userName) async {
    final docRef = _firestore.collection('books').doc(bookId);

    await _firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(docRef);

      if (!snapshot.exists) {
        throw Exception("Book document does not exist.");
      }

      final data = snapshot.data();
      if (data == null || data['recommendations'] == null) {
        throw Exception("Recommendations field is missing or invalid.");
      }

      // Ensure recommendations is a List
      final recommendations =
          List<Map<String, dynamic>>.from(data['recommendations']);

      // Add reply to the specific recommendation
      final updatedRecommendation = recommendations[recommendationIndex];
      final replies = List<Map<String, dynamic>>.from(
          updatedRecommendation['replies'] ?? []);
      replies.add({
        'userId': userId,
        'reply': replyText,
        'date': DateFormat('dd-MM-yyyy').format(DateTime.now()),
        'userName': userName
      });

      updatedRecommendation['replies'] = replies;
      recommendations[recommendationIndex] = updatedRecommendation;

      // Update Firestore document
      transaction.update(docRef, {'recommendations': recommendations});
    });
  }

  // Toggle like
  Future<void> toggleLike(String bookId, String userId) async {
    DocumentReference bookRef = _firestore.collection('books').doc(bookId);

    await _firestore.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(bookRef);

      if (!snapshot.exists) throw Exception("Book not found");

      List likes = snapshot['likes'] ?? [];
      List dislikes = snapshot['dislikes'] ?? [];

      if (likes.contains(userId)) {
        likes.remove(userId); // Remove like
      } else {
        likes.add(userId); // Add like
        dislikes.remove(userId); // Ensure user can't dislike
      }

      transaction.update(bookRef, {"likes": likes, "dislikes": dislikes});
    });
  }

  // Toggle dislike
  Future<void> toggleDislike(String bookId, String userId) async {
    DocumentReference bookRef = _firestore.collection('books').doc(bookId);

    await _firestore.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(bookRef);

      if (!snapshot.exists) throw Exception("Book not found");

      List likes = snapshot['likes'] ?? [];
      List dislikes = snapshot['dislikes'] ?? [];

      if (dislikes.contains(userId)) {
        dislikes.remove(userId); // Remove dislike
      } else {
        dislikes.add(userId); // Add dislike
        likes.remove(userId); // Ensure user can't like
      }

      transaction.update(bookRef, {"likes": likes, "dislikes": dislikes});
    });
  }

  // Stream for likes and dislikes
  Stream<DocumentSnapshot> getBookStream(String bookId) {
    return _firestore.collection('books').doc(bookId).snapshots();
  }

  Future<void> updateBookRating(
      String bookId, String userId, int rating) async {
    final bookRef = _firestore.collection('books').doc(bookId);
    await _firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(bookRef);
      if (!snapshot.exists) throw Exception("Book does not exist!");

      final data = snapshot.data();
      final ratings = List<Map<String, dynamic>>.from(data?['ratings'] ?? []);
      final existingRatingIndex =
          ratings.indexWhere((r) => r['userId'] == userId);

      if (existingRatingIndex != -1) {
        // Update existing rating
        ratings[existingRatingIndex]['rating'] = rating;
      } else {
        // Add new rating
        ratings.add({'userId': userId, 'rating': rating});
      }

      transaction.update(bookRef, {'ratings': ratings});
    });
  }

  Future<void> updateUserProfile(
      String userId, Map<String, dynamic> updatedData) async {
    try {
      await _firestore.collection('users').doc(userId).update(updatedData);
    } catch (e) {
      throw Exception("Error updating user profile: $e");
    }
  }

 Future<void> bookMark(Book book) async {
  try {
    // Check if the book already exists in the 'bookmarks' collection
    DocumentSnapshot snapshot = await _firestore.collection("bookmarks").doc(book.id).get();

    if (snapshot.exists) {
      // If the book already exists, show a message or handle it as needed
     ToastUtil.showToast(message: "This book is already bookmarked");
      return; // Exit the function
    }

    // If the book does not exist, add it to the 'bookmarks' collection
    await _firestore.collection("bookmarks").doc(book.id).set(book.toMap());
    print("Bookmarked successfully.");
  } catch (e) {
    throw Exception("Error bookmarking book: $e");
  }
}

}
