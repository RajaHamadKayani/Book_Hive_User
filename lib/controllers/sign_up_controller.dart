import 'package:book_hive_user/services/auth_services.dart';
import 'package:book_hive_user/utils/toast_util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../models/user_model.dart';

class SignupController extends GetxController {
  final AuthService _authService = AuthService();

  // TextEditingControllers
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var addressController = TextEditingController();
  var phoneController = TextEditingController();
  var dobController = TextEditingController();
  var passwordController = TextEditingController();

  var isLoading = false.obs;
Future<void> registerUser() async {
  isLoading.value = true;
  try {
    // Register the user and get the userCredential
    UserCredential userCredential = await _authService.registerUser(
      emailController.text,
      passwordController.text,
    );

    // Create a UserModel with the generated UID
    UserModel newUser = UserModel(
      id: userCredential.user!.uid, // Use the UID from Firebase
      name: nameController.text,
      email: emailController.text,
      address: addressController.text,
      phone: phoneController.text,
      dob: dobController.text,
    );

    // Save the user data to Firestore
    await _authService.saveUserToFirestore(newUser);

    Get.snackbar("Success", "User registered successfully!");
  } catch (e) {
    Get.snackbar("Error", e.toString());
  } finally {
    isLoading.value = false;
  }
}


}
