import 'package:book_hive_user/services/firestore_services.dart';
import 'package:book_hive_user/utils/toast_util.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RecommendationReplyBottomSheet extends StatefulWidget {
  final String bookId;
  final int recommendationIndex;
  final String recommendation;
  final String userId;
  final List<dynamic> replies;
  final String userName;

  const RecommendationReplyBottomSheet({
    super.key,
    required this.bookId,
    required this.recommendationIndex,
    required this.userId,
    required this.recommendation,
    required this.replies,
    required this.userName,
  });

  @override
  State<RecommendationReplyBottomSheet> createState() =>
      _RecommendationReplyBottomSheetState();
}

class _RecommendationReplyBottomSheetState
    extends State<RecommendationReplyBottomSheet> {
  final TextEditingController replyController = TextEditingController();
  final BookService _bookService = BookService();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          FocusScope.of(context).unfocus(), // Dismiss keyboard on tap outside
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xffF7F7F7),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
        padding: EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          bottom: MediaQuery.of(context).viewInsets.bottom +
              20, // Adjust for keyboard
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Recommendation: ${widget.recommendation}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // List of Replies
              widget.replies.isEmpty
                  ? Center(
                      child: Text(
                        "No reply yet. Be the first",
                        style:
                            TextStyle(color: Colors.black, fontFamily: "Pulp"),
                      ),
                    )
                  : ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.4,
                      ),
                      child: ListView.builder(
                        itemCount: widget.replies.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final reply = widget.replies[index];
                          return ListTile(
                            leading: SizedBox(
                              height: 40,
                              width: 40,
                              child: Image.asset(
                                  "assets/images/dummy_user_image.png"),
                            ),
                            title: Text(
                              "${reply['userName']} • ${reply['date']}",
                              style: const TextStyle(
                                fontFamily: "Pulp",
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                                color: Colors.black,
                              ),
                            ),
                            subtitle: Text(
                              reply['reply'],
                              style: const TextStyle(
                                fontFamily: "Pulp",
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          );
                        },
                      ),
                    ),

              const SizedBox(height: 20),

              // Add Reply Section
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
                          controller: replyController,
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
                      if (replyController.text.isNotEmpty) {
                        await _bookService.addReplyToRecommendation(
                          widget.bookId,
                          widget.recommendationIndex,
                          widget.userId,
                          replyController.text,
                          widget.userName,
                        );

                        // Update UI
                        setState(() {
                          widget.replies.add({
                            'userId': widget.userId,
                            'reply': replyController.text,
                            'date':
                                DateFormat('dd-MM-yyyy').format(DateTime.now()),
                          });
                        });

                        replyController.clear();
                        ToastUtil.showToast(
                          message: "Reply Added Successfully",
                        );
                      } else {
                        ToastUtil.showToast(
                            message: "Please write a reply first");
                      }
                    },
                    icon: const Icon(
                      Icons.send,
                      color: Color(0xffFF3CBBB1),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
