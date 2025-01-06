// import 'package:book_hive_user/utils/toast_util.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:book_hive_user/services/firestore_services.dart';
// import 'package:intl/intl.dart';

// class RecommendationRepliesPage extends StatefulWidget {
//   final String bookId;
//   final int recommendationIndex;
//   final String recommendation;
//   final String userId;
//   final List<dynamic> replies;

//   const RecommendationRepliesPage({
//     Key? key,
//     required this.bookId,
//     required this.recommendationIndex,
//     required this.userId,
//     required this.recommendation,
//     required this.replies,
//   }) : super(key: key);

//   @override
//   State<RecommendationRepliesPage> createState() =>
//       _RecommendationRepliesPageState();
// }

// class _RecommendationRepliesPageState extends State<RecommendationRepliesPage> {
//   final BookService _bookService = BookService();
//   final TextEditingController replyController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Replies"),
//         backgroundColor: const Color(0xff3CBBB1),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Recommendation: ${widget.recommendation}",
//               style: const TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 20),

//             // List of Replies
//             Expanded(
//               child: ListView.builder(
//                 itemCount: widget.replies.length,
//                 itemBuilder: (context, index) {
//                   final reply = widget.replies[index];
//                   return ListTile(
//                     title: Text(reply['reply']),
//                     subtitle: Text("By: ${reply['userId']}"),
//                   );
//                 },
//               ),
//             ),

//             // Add Reply Section
//             const Divider(),
//             const Text(
//               "Add a Reply",
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//             TextField(
//               controller: replyController,
//               decoration: const InputDecoration(
//                 labelText: "Enter your reply",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: () async {
//                 if (replyController.text.isNotEmpty) {
//                   await _bookService.addReplyToRecommendation(
//                     widget.bookId,
//                     widget.recommendationIndex,
//                     widget.userId, // Replace with the current user's ID
//                     replyController.text,
//                   );

//                   // Update UI
//                   setState(() {
//                     widget.replies.add({
//                       'userId': "currentUserId",
//                       'reply': replyController.text,
//                       'date': DateFormat('dd-MM-yyyy').format(DateTime.now()),
//                     });
//                   });

//                   replyController.clear();
//                   ToastUtil.showToast(message: "Reply Added Successfully",);
//                 }
//               },
//               child: const Text("Submit"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
