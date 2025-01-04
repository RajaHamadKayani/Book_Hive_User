// ignore_for_file: must_be_immutable

import 'package:book_hive_user/controllers/book_controller.dart';
import 'package:book_hive_user/utils/constants.dart';
import 'package:book_hive_user/views/books_detail_view.dart';
import 'package:book_hive_user/views/remove_book_view.dart';
import 'package:book_hive_user/views/widgets/edit_book_bottom_sheet.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MoreOptionsBottomSheetAllBooks extends StatefulWidget {
  String bookName;
  String authorName;
  DateTime dateTime;
  String genre;
  String description;
  String bookId;
  String userId;
  String userName;


  MoreOptionsBottomSheetAllBooks(
      {super.key,
      required this.authorName,
      required this.userName,
      required this.bookId,
      required this.userId,
      required this.dateTime,
      required this.bookName,
      required this.description,
      required this.genre});

  @override
  State<MoreOptionsBottomSheetAllBooks> createState() =>
      _MoreOptionsBottomSheetAllBooksState();
}

class _MoreOptionsBottomSheetAllBooksState
    extends State<MoreOptionsBottomSheetAllBooks> {
  BookController bookController = Get.put(BookController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (kDebugMode) {
      print("Book name ${widget.bookName}");
      print("Book id ${widget.bookId}");
      print("Book aithor ${widget.authorName}");
      print("Book genre ${widget.genre}");
      print("Book description ${widget.description}");
      print("Book date time ${widget.dateTime}");
      print("User Id ${widget.userId}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xffF7F7F7),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32), topRight: Radius.circular(32))),
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(),
                const SizedBox(),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 32,
                    width: 32,
                    decoration: BoxDecoration(
                      color: Color(0xffF2F2F5),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                      child: Icon(Icons.close, color: Color(0xff1F1C33)),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                    color: Color(0xff333333),
                    borderRadius: BorderRadius.circular(120)),
                child: Center(
                  child: Image.asset("assets/images/edit.png"),
                ),
              ),
              title: Text(
                "Edit Book Data",
                style: TextStyle(
                    fontFamily: "Pulp",
                    color: Color(0xff100C26),
                    fontWeight: FontWeight.w400,
                    fontSize: textSize.medium),
              ),
              onTap: () {
                Get.back();
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return EditBookBottomSheet(
                      id: widget.bookId,
                      bookName: widget.bookName,
                      authorName: widget.authorName,
                      description: widget.description,
                      genre: widget.genre,
                      dateTime: widget.dateTime,
                    );
                  },
                );
              },
            ),
            ListTile(
              leading: Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                    color: Color(0xff333333),
                    borderRadius: BorderRadius.circular(120)),
                child: Center(
                  child: Image.asset("assets/images/delete.png"),
                ),
              ),
              title: Text(
                "Delete Book",
                style: TextStyle(
                    fontFamily: "Pulp",
                    color: Color(0xff100C26),
                    fontWeight: FontWeight.w400,
                    fontSize: textSize.medium),
              ),
              onTap: () {
                Get.back();
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor:
                          const Color(0xffFFFFFF), // Updated background color
                      title: Text(
                        "Delete Book",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(
                              0xff100C26), // White text for better contrast
                        ),
                      ),
                      content: Text(
                        "Do you want to remove this Book?",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(
                              0xff100C26), // White text for better contrast
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
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                },
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                      color: Color(0xff0C091C), fontSize: 12),
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
                                    bookController.deleteBook(widget.bookId);

                                    Get.to(SuccessfulView(
                                      title: 'Removed',
                                    ));
                                  },
                                  child: bookController.isLoading.value
                                      ? Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                        )
                                      : const Text(
                                          "Remove",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                        ),
                                ),
                              );
                            })
                          ],
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            GestureDetector(
              child: ListTile(
                leading: Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                      color: Color(0xff333333),
                      borderRadius: BorderRadius.circular(120)),
                  child: Center(
                    child: Image.asset("assets/images/info.png"),
                  ),
                ),
                title: Text(
                  "Book Info",
                  style: TextStyle(
                      fontFamily: "Pulp",
                      color: Color(0xff100C26),
                      fontWeight: FontWeight.w400,
                      fontSize: textSize.medium),
                ),
                onTap: () {
                  Get.back(); // Close the bottom sheet
                  Get.to(() => BookDetailsPage(
                    userName: widget.userName,
                        bookId: widget.bookId,
                        userId: widget.userId,
                        bookName: widget.bookName,
                        authorName: widget.authorName,

                        genre: widget.genre,
                        description: widget.description,
                        dateTime: widget.dateTime,
                      ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
