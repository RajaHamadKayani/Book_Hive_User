import 'package:book_hive_user/controllers/book_controller.dart';
import 'package:book_hive_user/controllers/book_mark_controller.dart';
import 'package:book_hive_user/utils/constants.dart';
import 'package:book_hive_user/utils/toast_util.dart';
import 'package:book_hive_user/views/authentication_view/login_view.dart';
import 'package:book_hive_user/views/widgets/delete_book_mark_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookmarksView extends StatefulWidget {
  const BookmarksView({super.key});

  @override
  State<BookmarksView> createState() => _BookmarksViewState();
}

class _BookmarksViewState extends State<BookmarksView> {
  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  BookMarkController bookMarkController = Get.put(BookMarkController());
  final BookController bookController = Get.put(BookController());

  @override
  void initState() {
    super.initState();
    bookMarkController
        .fetchbookMarkedBooks(); // Fetch books when the screen loads
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    height: 46,
                    width: 46,
                    decoration: BoxDecoration(
                      color: const Color(0xffF2F2F5),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 18,
                        color: Color(0xff1F1C33),
                      ),
                    ),
                  ),
                ),
                const Text(
                  "BOOK HIVE",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: "Pulp",
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            backgroundColor: const Color(
                                0xffFFFFFF), // Updated background color
                            title: Text(
                              "Logout",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(
                                    0xff100C26), // White text for better contrast
                              ),
                            ),
                            content: Text(
                              "Are you sure want to logout?",
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(
                                    0xff100C26), // White text for better contrast
                              ),
                            ),
                            actions: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Cancel Button
                                  Expanded(
                                    flex: 1,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xffE6E6E6),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(); // Close the dialog
                                      },
                                      child: Text(
                                        "Cancel",
                                        style: TextStyle(
                                            color: Color(0xff0C091C),
                                            fontSize: 12),
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
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                        ),
                                        onPressed: () {
                                          FirebaseAuth.instance.signOut();
                                          ToastUtil.showToast(
                                              message: "Logout Succesfully");
                                          Get.off(LoginView());
                                        },
                                        child: bookController.isLoading.value
                                            ? Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Colors.white,
                                                ),
                                              )
                                            : const Text(
                                                "Signout",
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
                    icon: Icon(
                      Icons.logout,
                      color: Colors.black,
                    ))
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Book Mark List",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  fontFamily: 'Pulp'),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Obx(() {
                if (bookMarkController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (bookMarkController.allBookedMarkedBooks.isEmpty) {
                  return const Center(
                    child: Text(
                      "No books found for this genre.",
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: bookMarkController.allBookedMarkedBooks.length,
                  itemBuilder: (context, index) {
                    final book = bookMarkController.allBookedMarkedBooks[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xffE6E6E6),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: ListTile(
                            trailing: Container(
                              height: 28,
                              width: 28,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1, color: const Color(0xff3B3654)),
                                shape: BoxShape.circle,
                              ),
                              child: InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Container(
                                          decoration: BoxDecoration(
                                              color: Color(0xffF7F7F7),
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(32),
                                                  topRight:
                                                      Radius.circular(32))),
                                          padding: const EdgeInsets.all(20.0),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
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
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xffF2F2F5),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                        ),
                                                        child: Center(
                                                          child: Icon(
                                                              Icons.close,
                                                              color: Color(
                                                                  0xff1F1C33)),
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
                                                        color:
                                                            Color(0xff333333),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(120)),
                                                    child: Center(
                                                      child: Image.asset(
                                                          "assets/images/edit.png"),
                                                    ),
                                                  ),
                                                  title: Text(
                                                    "Delete from BookMark",
                                                    style: TextStyle(
                                                        fontFamily: "Pulp",
                                                        color:
                                                            Color(0xff100C26),
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize:
                                                            textSize.medium),
                                                  ),
                                                  onTap: () {
                                                    Get.back();
                                                    showDialog(context: context, builder: (BuildContext context){
                                                   return   DeleteBookMarkDialog(bookId: book.id);
                                                    });
                                                    
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                },
                                child: const Icon(
                                  Icons.more_horiz,
                                  color: Color(0xff7F789D),
                                  size: 18,
                                ),
                              ),
                            ),
                            leading: CircleAvatar(
                              backgroundColor: const Color(0xff3CBBB1),
                              backgroundImage:
                                  AssetImage("assets/images/splash_logo.png"),
                            ),
                            title: Text(
                              book.title,
                              style: const TextStyle(
                                fontFamily: "Pulp",
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            subtitle: Text(
                              "Author: ${book.author}\nGenre: ${book.genre}",
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: "Pulp",
                              ),
                            ),
                            isThreeLine: true,
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      )),
    );
  }
}
