import 'dart:async';

import 'package:book_hive_user/views/all_books_view.dart';
import 'package:book_hive_user/views/authentication_view/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Using GetX for navigation

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();

    // Navigate to LoginView or AllBooksView after 4 seconds
    Timer(const Duration(seconds: 4), () {
      final currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser == null) {
        // User is not logged in
        Get.off(() => const LoginView());
      } else {
        // User is logged in
        Get.off(() => const AllBooksView());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Image.asset(
              'assets/images/splash_logo.png',
              width: 150, // Adjust the width as needed
              height: 150, // Adjust the height as needed
            ),
            const SizedBox(height: 20), // Space between logo and text
            // App Name
            const Text(
              'Book Hive',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: "Pulp", // Use your app's font
              ),
            ),
          ],
        ),
      ),
    );
  }
}
