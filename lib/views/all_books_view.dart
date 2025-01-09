import 'package:book_hive_user/controllers/book_controller.dart';
import 'package:book_hive_user/utils/toast_util.dart';
import 'package:book_hive_user/views/authentication_view/login_view.dart';
import 'package:book_hive_user/views/drawer_widget.dart';
import 'package:book_hive_user/views/profile_view.dart';
import 'package:book_hive_user/views/widgets/more_options_bottom_sheet_all_books.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllBooksView extends StatefulWidget {
  const AllBooksView({super.key});

  @override
  State<AllBooksView> createState() => _AllBooksViewState();
}

class _AllBooksViewState extends State<AllBooksView> {
  GlobalKey<ScaffoldState> globalKey=GlobalKey<ScaffoldState>();
  final BookController bookController = Get.put(BookController());

  @override
  void initState() {
    super.initState();
    bookController.fetchBooks(); // Fetch books when the screen loads
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      key: globalKey,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      globalKey.currentState!.openDrawer();
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
                          Icons.menu,
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
            ),
            Obx(() {
              if (bookController.isLoadingUser.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (bookController.currentUser.value == null) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text(
                    "Welcome!",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                );
              }
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileView(
                              uid: bookController.currentUser.value!.id,
                                  address:
                                      bookController.currentUser.value!.address,
                                  DOB: bookController.currentUser.value!.dob,
                                  name: bookController.currentUser.value!.name,
                                  phone:
                                      bookController.currentUser.value!.phone,
                                  email:
                                      bookController.currentUser.value!.email,
                                )));
                  },
                  child: Text(
                    "Welcome, ${bookController.currentUser.value!.name}!",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Pulp",
                      color: Colors.black,
                    ),
                  ),
                ),
              );
            }),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: bookController.searchController,
                      onChanged: (value) {
                        bookController.filterBooksByGenre(value);
                      },
                      decoration: InputDecoration(
                        hintText: "Search by Genre",
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(() {
                if (bookController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (bookController.filteredBooks.isEmpty) {
                  return const Center(
                    child: Text(
                      "No books found for this genre.",
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  );
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ListView.builder(
                    itemCount: bookController.filteredBooks.length,
                    itemBuilder: (context, index) {
                      final book = bookController.filteredBooks[index];
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
                                        return MoreOptionsBottomSheetAllBooks(
                                          bookId: book.id,
                                          userName: bookController
                                              .currentUser.value!.name,
                                          userId: bookController
                                              .currentUser.value!.id,
                                          authorName: book.author,
                                          bookName: book.title,
                                          description: book.description,
                                          dateTime: book.createdAt,
                                          genre: book.genre,
                                        );
                                      },
                                    );
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
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
