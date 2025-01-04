
import 'package:book_hive_user/models/book_model.dart';
import 'package:book_hive_user/models/user_model.dart';
import 'package:book_hive_user/services/auth_services.dart';
import 'package:book_hive_user/services/firestore_services.dart';
import 'package:book_hive_user/utils/toast_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookController extends GetxController {
    final AuthService _authService = AuthService();

  final BookService _bookService = BookService();
 var currentUser = Rxn<UserModel>(); // Reactive variable to store the user
  var isLoadingUser = false.obs; // Loading indicator for user data
  // Observables
  var books = <Book>[].obs;
  var isLoading = false.obs;
  var filteredBooks = <Book>[].obs; // Observable for filtered books
    var searchController = TextEditingController();
    @override
     onInit(){
      super.onInit();
      fetchCurrentUser();
      
    }
      // Fetch the current user data
  Future<void> fetchCurrentUser() async {
    isLoadingUser.value = true;
    try {
      currentUser.value = await _authService.fetchCurrentUser();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoadingUser.value = false;
    }
  }


  var textEditingControllerTitle = TextEditingController().obs;
  var textEditingControllerGenre = TextEditingController().obs;
  var textEditingControllerAuthor = TextEditingController().obs;
  var textEditingControllerDescription = TextEditingController().obs;

  // Fetch all books from Firestore
  // Fetch all books from Firestore
  Future<void> fetchBooks() async {
    isLoading.value = true;
    try {
      books.value = await _bookService.fetchBooks();
      filteredBooks.value = books; // Initialize filteredBooks with all books
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch books: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Filter books by genre
  void filterBooksByGenre(String genre) {
    if (genre.isEmpty) {
      filteredBooks.value = books; // Show all books if filter is cleared
    } else {
      filteredBooks.value = books
          .where(
              (book) => book.genre.toLowerCase().contains(genre.toLowerCase()))
          .toList();
    }
  }

  // Add a new book
  Future<void> addBook(Book book) async {
    isLoading.value = true;
    try {
      await _bookService.addBook(book);
      books.add(book); // Update the local list
      ToastUtil.showToast(
        message: "Book added Successfully",
      );
    } catch (e) {
      ToastUtil.showToast(
        message: "Failed to add book",
      );
      print("error while Uploading the book $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Update an existing book
  Future<void> updateBook(Book book) async {
    isLoading.value = true;
    try {
      await _bookService.updateBook(book);
      int index = books.indexWhere((b) => b.id == book.id);
      if (index != -1) {
        books[index] = book; // Update the local list
      }
      Get.snackbar('Success', 'Book updated successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update book: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Delete a book
  Future<void> deleteBook(String bookId) async {
    isLoading.value = true;
    try {
      await _bookService.deleteBook(bookId);
      books.removeWhere((b) => b.id == bookId); // Update the local list
      Get.snackbar('Success', 'Book deleted successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete book: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
