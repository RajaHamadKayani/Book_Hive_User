
import 'package:book_hive_user/controllers/book_controller.dart';
import 'package:book_hive_user/models/book_model.dart';
import 'package:book_hive_user/views/remove_book_view.dart';
import 'package:book_hive_user/views/widgets/reusable_container.dart';
import 'package:book_hive_user/views/widgets/reusable_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

// ignore: must_be_immutable
class EditBookBottomSheet extends StatefulWidget {
  String bookName;
  String authorName;
  String id;
  DateTime dateTime;
  String genre;
  String description;

  EditBookBottomSheet(
      {super.key,
      required this.authorName,
      required this.id,
      required this.dateTime,
      required this.bookName,
      required this.description,
      required this.genre});

  @override
  State<EditBookBottomSheet> createState() => _EditBookBottomSheetState();
}

class _EditBookBottomSheetState extends State<EditBookBottomSheet> {
  BookController bookController = Get.put(BookController());
  // Focus nodes for the text fields
  final _titleFocusNode = FocusNode();
  final _authorFocusNode = FocusNode();
  final _genreFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bookController.textEditingControllerAuthor.value.text = widget.authorName;
    bookController.textEditingControllerDescription.value.text =
        widget.description;
    bookController.textEditingControllerGenre.value.text = widget.genre;
    bookController.textEditingControllerTitle.value.text = widget.bookName;

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
            mainAxisSize: MainAxisSize.min,
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
              const Text(
                "BOOK HIVE",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: "Pulp",
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 46), // Spacer to align the back button
              const SizedBox(
                height: 28,
              ),
              ReusableTextFieldWidget(
                controller: bookController.textEditingControllerTitle.value,
                hintText: "Enter Book Title",
                suffixIcon: const Icon(Icons.title, color: Colors.black),
                title: 'Update Book Title',
                focusNode: _titleFocusNode, // Assign focus node
                textInputAction: TextInputAction
                    .next, // Set the action to move to the next field
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_authorFocusNode);
                },
              ),
              ReusableTextFieldWidget(
                controller: bookController.textEditingControllerAuthor.value,
                hintText: "Enter Author Name",
                suffixIcon: const Icon(Icons.person, color: Colors.black),
                title: 'Update Author Name',
                focusNode: _authorFocusNode, // Assign focus node
                textInputAction: TextInputAction
                    .next, // Set the action to move to the next field
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_genreFocusNode);
                },
              ),
              ReusableTextFieldWidget(
                controller: bookController.textEditingControllerGenre.value,
                hintText: "Enter Genre",
                suffixIcon:
                    const Icon(Icons.type_specimen, color: Colors.black),
                title: 'Update Book Genre',
                focusNode: _genreFocusNode, // Assign focus node
                textInputAction: TextInputAction
                    .next, // Set the action to move to the next field
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
              ),
              ReusableTextFieldWidget(
                controller:
                    bookController.textEditingControllerDescription.value,
                hintText: "Enter Book Description",
                suffixIcon: const Icon(Icons.description, color: Colors.black),
                title: 'Update Book Description',
                focusNode: _descriptionFocusNode, // Assign focus node
                textInputAction: TextInputAction.done, // Close the keyboard
              ),
              const SizedBox(height: 20),
              Center(
                child: Obx(
                  () => bookController.isLoading.value
                      ? const CircularProgressIndicator()
                      : GestureDetector(
                          onTap: () async {
                            String id = widget.id;
                            String title = bookController
                                .textEditingControllerTitle.value.text;
                            String author = bookController
                                .textEditingControllerAuthor.value.text;
                            String genre = bookController
                                .textEditingControllerGenre.value.text;
                            String description = bookController
                                .textEditingControllerDescription.value.text;

                            Book newBook = Book(
                              id: id,
                              title: title,
                              author: author,
                              genre: genre,
                              description: description,
                              createdAt: DateTime.now(),
                            );

                            await bookController.updateBook(newBook);

                            // Clear the text fields after successful upload
                            bookController.textEditingControllerTitle.value
                                .clear();
                            bookController.textEditingControllerAuthor.value
                                .clear();
                            bookController.textEditingControllerGenre.value
                                .clear();
                            bookController
                                .textEditingControllerDescription.value
                                .clear();
                            bookController.fetchBooks(); // Reload books
                            Get.to(SuccessfulView(title: "Updated"));
                          },
                          child: ReusableContainer(
                            borderRadius: BorderRadius.circular(50),
                            color: 0xff000000,
                            title: "Upload Book",
                          ),
                        ),
                ),
              ),
            ],
          ),
        ));
  }
}
