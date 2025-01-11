import 'package:book_hive_user/controllers/book_controller.dart';
import 'package:book_hive_user/controllers/book_mark_controller.dart';
import 'package:book_hive_user/utils/toast_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class DeleteBookMarkDialog extends StatefulWidget {
  String bookId;
  DeleteBookMarkDialog({super.key, required this.bookId});

  @override
  State<DeleteBookMarkDialog> createState() => _DeleteBookMarkDialogState();
}

class _DeleteBookMarkDialogState extends State<DeleteBookMarkDialog> {
  BookMarkController bookMarkController = Get.put(BookMarkController());
  final BookController bookController = Get.put(BookController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      backgroundColor: const Color(0xffFFFFFF), // Updated background color
      title: Text(
        "BookMark",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xff100C26), // White text for better contrast
        ),
      ),
      content: Text(
        "Are you sure want to Remove from bookmark list?",
        style: TextStyle(
          fontSize: 16,
          color: Color(0xff100C26), // White text for better contrast
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Cancel Button
            Expanded(
              flex: 1,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffE6E6E6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Color(0xff0C091C), fontSize: 12),
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            // Remove Button
            Obx(() {
              return Expanded(
                flex: 1,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffEE4266),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  onPressed: () {
                    bookMarkController.deleteBook(widget.bookId);
                    ToastUtil.showToast(
                        message:
                            "Book removed from book mark list Successfully!!!");
                    Get.back();
                  },
                  child: bookController.isLoading.value
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          "Remove",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                ),
              );
            })
          ],
        ),
      ],
    );
  }
}
