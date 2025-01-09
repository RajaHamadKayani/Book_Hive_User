import 'package:book_hive_user/services/firestore_services.dart';
import 'package:book_hive_user/utils/toast_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateProfileController extends GetxController {
  var textEditingControllerName = TextEditingController().obs;
  var textEditingControllerEmail = TextEditingController().obs;
  var textEditingControllerPhone = TextEditingController().obs;
  var textEditingControllerAdress = TextEditingController().obs;
  var textEditingControllerDOB = TextEditingController().obs;
  var isLoading=false.obs;

  final BookService _firestoreService = BookService();

  Future<void> updateProfile(String userId) async {
    Map<String, dynamic> updatedData = {
      'name': textEditingControllerName.value.text,
      'email': textEditingControllerEmail.value.text,
      'phone': textEditingControllerPhone.value.text,
      'address': textEditingControllerAdress.value.text,
      'dob': textEditingControllerDOB.value.text,
    };
    isLoading.value=true;

    try {
      await _firestoreService.updateUserProfile(userId, updatedData);
      ToastUtil.showToast(message: "Profile updated successfully!");
    } catch (e) {
      ToastUtil.showToast(message: "Error ${e.toString()}");
    }
    finally{
      isLoading.value=false;
    }
  }
}
