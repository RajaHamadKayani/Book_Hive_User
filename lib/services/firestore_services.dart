import 'package:book_hive_user/models/book_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

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

 // Stream for recommendations
  Stream<List<Map<String, dynamic>>> getRecommendationsStream(String bookId) {
    return _firestore.collection('books').doc(bookId).snapshots().map((doc) {
      if (doc.exists) {
        final data = doc.data();
        return List<Map<String, dynamic>>.from(data?['recommendations'] ?? []);
      }
      return [];
    });
  }

  // Add a recommendation to Firestore
  Future<void> addRecommendation(String bookId, String userId, String recommendation, String userName) async {
    try {
      final bookRef = _firestore.collection('books').doc(bookId);

      await bookRef.update({
        'recommendations': FieldValue.arrayUnion([
          {'userId': userId, 'recommendation': recommendation,'userName':userName},
        ]),
      });
    } catch (e) {
      throw Exception("Error adding recommendation: $e");
    }
  }
}
