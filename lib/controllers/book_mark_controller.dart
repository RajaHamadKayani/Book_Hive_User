import 'package:book_hive_user/models/book_model.dart';
import 'package:book_hive_user/services/firestore_services.dart';
import 'package:book_hive_user/utils/toast_util.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class BookMarkController extends GetxController {
  var isLoading = false.obs;
  BookService bookService = BookService();
  var allBookedMarkedBooks = <Book>[].obs;
  Future<void> addBookToBookMark(Book book) async {
    isLoading.value = true;
    try {
      await bookService.bookMark(book);
      ToastUtil.showToast(message: "Book Added to book Mark successfully");
      Get.back();
    } catch (e) {
      if (kDebugMode) {
        print(
            "Error while adding books to book to book mark list ${e.toString()}");
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchbookMarkedBooks() async {
    isLoading.value = true;
    try {
      allBookedMarkedBooks.value = await bookService.fetchAllBookMarkedBooks();
    } catch (e) {
      if (kDebugMode) {
        print(
            "Error while fetching books from  book mark list ${e.toString()}");
      }
    } finally {
      isLoading.value = false;
    }
  }
    Future<void> deleteBook(String bookId) async {
    isLoading.value = true;
    try {
      await bookService.deleteBookedMarkBook(bookId);
      allBookedMarkedBooks.removeWhere((b) => b.id == bookId); // Update the local list
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete book: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
