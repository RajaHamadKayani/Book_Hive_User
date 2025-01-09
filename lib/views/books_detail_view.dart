import 'package:book_hive_user/controllers/like_dislike_book_controller.dart';
import 'package:book_hive_user/services/firestore_services.dart';
import 'package:book_hive_user/utils/toast_util.dart';
import 'package:book_hive_user/views/widgets/book_rating_component.dart';
import 'package:book_hive_user/views/widgets/recommendation_reply_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BookDetailsPage extends StatefulWidget {
  final String bookName;
  final String bookId;
  final String authorName;
  final String genre;
  final String description;
  final DateTime dateTime;
  final String userId;
  final String userName;
  const BookDetailsPage({
    super.key,
    required this.bookName,
    required this.authorName,
    required this.bookId,
    required this.userName,
    required this.genre,
    required this.userId,
    required this.description,
    required this.dateTime,
  });

  @override
  State<BookDetailsPage> createState() => _BookDetailsPageState();
}

class _BookDetailsPageState extends State<BookDetailsPage> {
  final TextEditingController recommendationController =
      TextEditingController();
  final LikeDislikeBookController bookController =
      Get.put(LikeDislikeBookController());

  final BookService _firestoreService = BookService();
  @override
  Widget build(BuildContext context) {
    bookController.listenToBook(widget.bookId);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Book Details",
          style: TextStyle(
            fontFamily: "Pulp",
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xff3CBBB1),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 16,
            ),
            // Top Cover
            Center(
              child: Container(
                height: 200,
                width: 200, // Make the container a square
                decoration: const BoxDecoration(
                  color: Color(0xffF5F5F5),
                  shape: BoxShape.circle, // Make the container circular
                ),
                child: ClipOval(
                  child: Image.asset(
                    "assets/images/splash_logo.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            // Book Details
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Book Name
                  Text(
                    widget.bookName,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Pulp",
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Author Name
                  Text(
                    "Author: ${widget.authorName}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontFamily: "Pulp",
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Genre
                  Row(
                    children: [
                      const Icon(
                        Icons.category,
                        size: 20,
                        color: Color(0xff3CBBB1),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "Genre: ${widget.genre}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: "Pulp",
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),

                  // Description
                  const Text(
                    "Description:",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Pulp",
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.description,
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: "Pulp",
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Added Date
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        size: 20,
                        color: Color(0xff3CBBB1),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "Added On: ${widget.dateTime.toLocal().toString().split(' ')[0]}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: "Pulp",
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(() {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text("Likes: ${bookController.likes.length}"),
                            IconButton(
                              onPressed: () {
                                bookController.toggleLike(
                                    widget.bookId, widget.userId);
                              },
                              icon: Icon(
                                Icons.thumb_up,
                                color:
                                    bookController.likes.contains(widget.userId)
                                        ? Colors.blue
                                        : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text("Dislikes: ${bookController.dislikes.length}"),
                            IconButton(
                              onPressed: () {
                                bookController.toggleDislike(
                                    widget.bookId, widget.userId);
                              },
                              icon: Icon(
                                Icons.thumb_down,
                                color: bookController.dislikes
                                        .contains(widget.userId)
                                    ? Colors.red
                                    : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),

            // Footer Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff3CBBB1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Back",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontFamily: "Pulp",
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffEE4266),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        // Add your delete or favorite functionality here
                      },
                      child: const Text(
                        "Favorite", 
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontFamily: "Pulp",
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                "Recommendations",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            StreamBuilder<List<Map<String, dynamic>>>(
              stream: _firestoreService.getRecommendationsStream(widget.bookId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                }

                final recommendations = snapshot.data ?? [];
                if (recommendations.isEmpty) {
                  return const Text("No recommendations yet.");
                }

                return ListView.builder(
                  itemCount: recommendations.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final recommendation = recommendations[index];
                        final ratings = List<Map<String, dynamic>>.from(recommendation['ratings'] ?? []);

                    return ListTile(
                      leading:
                          Image.asset("assets/images/dummy_user_image.png"),
                      title: Text(
                        recommendation['userName'],
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            fontFamily: "Pulp"),
                      ),
                      trailing: Text(
                        recommendation['dateTime'],
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Pulp",
                            fontSize: 12),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            recommendation['recommendation'],
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                                fontFamily: "Pulp"),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BookRatingComponent(
                                userId: widget.userId,
                                bookId: widget.bookId,
                                ratings:ratings,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return RecommendationReplyBottomSheet(
                                        userName: widget.userName,
                                        userId: widget.userId,
                                        bookId: widget.bookId,
                                        recommendationIndex: index,
                                        recommendation:
                                            recommendation['recommendation'],
                                        replies: List.from(
                                            recommendation['replies'] ?? []),
                                      );
                                    },
                                  );
                                },
                                child: const Icon(
                                  Icons.comment,
                                  size: 18,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                );
              },
            ),

            const Divider(),

            // Add Your Recommendation
            const Text(
              "Add Your Recommendation",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 40,
                    width: 40,
                    child: Image.asset(
                      "assets/images/dummy_user_image.png",
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xffFF3CBBB1).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 1),
                      child: TextFormField(
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          fontFamily: "Pulp",
                        ),
                        controller: recommendationController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter your reply",
                          hintStyle: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            fontFamily: "Pulp",
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    String formattedDate =
                        DateFormat('dd-MM-yyyy').format(DateTime.now());

                    if (recommendationController.text.isNotEmpty) {
                      await _firestoreService.addRecommendation(
                          widget.bookId,
                          widget.userId, // Replace with the current user's ID
                          recommendationController.text,
                          widget.userName,
                          formattedDate);
                      recommendationController.clear();
                      ToastUtil.showToast(
                          message: "Recommendation Added Successfully");
                    }
                  },
                  icon: const Icon(
                    Icons.send,
                    color: Color(0xffFF3CBBB1),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
