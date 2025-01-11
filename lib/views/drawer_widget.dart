import 'package:book_hive_user/controllers/book_controller.dart';
import 'package:book_hive_user/views/bookmarks_view.dart';
import 'package:book_hive_user/views/profile_view.dart';
import 'package:book_hive_user/views/terms_and_policies_view.dart';
import 'package:book_hive_user/views/widgets/drawer_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
    final BookController bookController = Get.put(BookController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                Text(
                  "Settings",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      fontFamily: "Pulp"),
                ),
                const SizedBox()
              ],
            ),
            const SizedBox(
              height: 19,
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Account",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                        fontFamily: "Pulp"),
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Color(0xffE6E6E6),
                        borderRadius: BorderRadius.circular(6)),
                    child: Padding(
                      padding: EdgeInsets.all(13),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: (){
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
                            child: DrawerComponent(
                                iamge: "assets/images/person.png",
                                title: "Edit Profile"),
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> const BookmarksView()));
                            },
                            child: DrawerComponent(
                                iamge: "assets/images/security.png",
                                title: "Book Mark"),
                          ),
                          DrawerComponent(
                              iamge: "assets/images/notification.png",
                              title: "Notifications"),
                          DrawerComponent(
                              iamge: "assets/images/privacy.png",
                              title: "Privacy"),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Support & About",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                        fontFamily: "Pulp"),
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Color(0xffE6E6E6),
                        borderRadius: BorderRadius.circular(6)),
                    child: Padding(
                      padding: EdgeInsets.all(13),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DrawerComponent(
                              iamge: "assets/images/subscription.png",
                              title: "My Subscription"),
                          DrawerComponent(
                              iamge: "assets/images/support.png",
                              title: "Help & Support"),
                          GestureDetector(
                            onTap: (){
                              Get.to(const TermsAndPoliciesView());
                            },
                            child: DrawerComponent(
                                iamge: "assets/images/policies.png",
                                title: "Terms and Policies"),
                          ),
                    
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 19,),
                  Text(
                    "Cache & cellular",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                        fontFamily: "Pulp"),
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Color(0xffE6E6E6),
                        borderRadius: BorderRadius.circular(6)),
                    child: Padding(
                      padding: EdgeInsets.all(13),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DrawerComponent(
                              iamge: "assets/images/free_space.png",
                              title: "Free up space"),
                          DrawerComponent(
                              iamge: "assets/images/data_saver.png",
                              title: "Data Saver"),
                    
                        ],
                      ),
                    ),
                  ),
                  
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
