import 'package:book_hive_user/controllers/book_controller.dart';
import 'package:book_hive_user/views/update_profile_view.dart';
import 'package:book_hive_user/views/widgets/view_profile_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileView extends StatefulWidget {
  String name;
  String address;
  String DOB;
  String phone;
  String email;
  String uid;
  ProfileView(
      {super.key,
      required this.DOB,
      required this.address,
      required this.uid,
      required this.email,
      required this.name,
      required this.phone});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  BookController bookController=Get.put(BookController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bookController.fetchCurrentUser();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             GestureDetector(
                      onTap: () {
                        Get.back(); // Navigate back
                      },
                      child: Container(
                        height: 46,
                        width: 46,
                        decoration: BoxDecoration(
                            color: const Color(0xffF2F2F5),
                            borderRadius: BorderRadius.circular(50)),
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.only(left: 4),
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: 18,
                              color: Color(0xff1F1C33),
                            ),
                          ),
                        ),
                      ),
                    ),
              Expanded(
              child: SingleChildScrollView(
                child: Obx(() {
                  // Check if the user data is still loading
                  if (bookController.isLoadingUser.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final user = bookController.currentUser.value;
                  if (user == null) {
                    return const Center(
                      child: Text("User data not available."),
                    );
                  }

                  return Column(
                    children: [
                      Center(
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.asset(
                            "assets/images/dummy_user_image.png",
                            fit: BoxFit.cover,
                            height: double.infinity,
                            width: double.infinity,
                          ),
                        ),
                      ),
                      ViewProfileComponent(title: "Name", value: user.name),
                      ViewProfileComponent(title: "Email", value: user.email),
                      ViewProfileComponent(title: "Phone", value: user.phone),
                      ViewProfileComponent(title: "Address", value: user.address),
                      ViewProfileComponent(title: "Date Of Birth", value: user.dob),
                      const SizedBox(height: 30),
                      Center(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UpdateProfileView(
                                  uid: user.id,
                                  DOB: user.dob,
                                  name: user.name,
                                  address: user.address,
                                  phone: user.phone,
                                  email: user.email,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: 225,
                            decoration: BoxDecoration(
                              color: const Color(0XFF3CBBB1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 13),
                              child: const Center(
                                child: Text(
                                  "Update",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
         
          
        )],
        ),
      )),
    );
  }
}
