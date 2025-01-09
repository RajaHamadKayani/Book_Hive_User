import 'package:book_hive_user/controllers/update_profile_controller.dart';
import 'package:book_hive_user/views/widgets/update_profile_component.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateProfileView extends StatefulWidget {
  String name;
  String address;
  String DOB;
  String phone;
  String email;
  String uid;
  UpdateProfileView(
      {super.key,
      required this.DOB,
      required this.uid,
      required this.address,
      required this.email,
      required this.name,
      required this.phone});

  @override
  State<UpdateProfileView> createState() => _UpdateProfileViewState();
}

class _UpdateProfileViewState extends State<UpdateProfileView> {
  UpdateProfileController updateProfileController =
      Get.put(UpdateProfileController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (kDebugMode) {
      print("User id is ${widget.uid}");
    }
    updateProfileController.textEditingControllerName.value.text = widget.name;
    updateProfileController.textEditingControllerEmail.value.text =
        widget.email;
    updateProfileController.textEditingControllerAdress.value.text =
        widget.address;
    updateProfileController.textEditingControllerPhone.value.text =
        widget.phone;
    updateProfileController.textEditingControllerDOB.value.text = widget.DOB;
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
                child: Column(
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
                    UpdateProfileComponent(
                        title: "Name",
                        controller: updateProfileController
                            .textEditingControllerName.value),
                    UpdateProfileComponent(
                        title: "Email",
                        controller: updateProfileController
                            .textEditingControllerEmail.value),
                    UpdateProfileComponent(
                        title: "Phone",
                        controller: updateProfileController
                            .textEditingControllerPhone.value),
                    UpdateProfileComponent(
                        title: "Address",
                        controller: updateProfileController
                            .textEditingControllerAdress.value),
                    UpdateProfileComponent(
                        title: "Date Of Birth",
                        controller: updateProfileController
                            .textEditingControllerDOB.value),
                    const SizedBox(
                      height: 30,
                    ),
                    Center(child: Obx(() {
                      return GestureDetector(
                        onTap: () {
                          updateProfileController.updateProfile(widget.uid);
                          Get.back();
                        },
                        child: Container(
                          width: 225,
                          decoration: BoxDecoration(
                              color: Color(0XFF3CBBB1),
                              borderRadius: BorderRadius.circular(6)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 13),
                            child: Center(
                              child: updateProfileController.isLoading.value
                                  ? Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    )
                                  : Text(
                                      "Save Changes",
                                      style: TextStyle(color: Colors.white),
                                    ),
                            ),
                          ),
                        ),
                      );
                    }))
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
