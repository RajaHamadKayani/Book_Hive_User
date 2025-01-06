
import 'package:book_hive_user/controllers/login_controller.dart';
import 'package:book_hive_user/views/all_books_view.dart';
import 'package:book_hive_user/views/authentication_view/sign_up_view.dart';
import 'package:book_hive_user/views/widgets/reusable_container.dart';
import 'package:book_hive_user/views/widgets/reusable_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  LoginController loginController = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();

  // Focus nodes for the text fields
  final emailController = FocusNode();
  final passswordController = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          true, // Allow the screen to resize when the keyboard is open
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(),
                      const SizedBox(),
                      Center(
                        child: const Text(
                          "BOOK HIVE",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: "Pulp",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                          width: 46), // Spacer to align the back button
                    ],
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 38,
                      fontFamily: "Pulp",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  ReusableTextFieldWidget(
                    controller: loginController.emailController,
                    hintText: "Enter your Email",
                    suffixIcon: const Icon(Icons.email, color: Colors.black),
                    title: 'Email',
                    focusNode: emailController, // Assign focus node
                    textInputAction: TextInputAction
                        .next, // Set the action to move to the next field
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(passswordController);
                    },
                  ),
                  ReusableTextFieldWidget(
                    controller: loginController.passwordController,
                    hintText: "Enter your Password",
                    suffixIcon: const Icon(Icons.password, color: Colors.black),
                    title: 'Pssword',
                    focusNode: passswordController, // Assign focus node
                    textInputAction: TextInputAction
                        .next, // Set the action to move to the next field
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(passswordController);
                    },
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: "Forgot ",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              fontFamily: "Pulp")),
                      TextSpan(
                          text: "Password?",
                          style: TextStyle(
                              color: Color(0XFF3CBBB1),
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              fontFamily: "Pulp"))
                    ])),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Obx(
                      () => loginController.isLoading.value
                          ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                          : GestureDetector(
                              onTap: () async {
                                if (_formKey.currentState!.validate()) {
                                  loginController.loginUser();
                                  // Clear the text fields after successful upload
                                  loginController.emailController.clear();
                                  loginController.passwordController.clear();
                                  Get.off(() => const AllBooksView());
                                }
                              },
                              child: ReusableContainer(
                                borderRadius: BorderRadius.circular(50),
                                color: 0XFF3CBBB1,
                                title: "Login",
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Get.to(SignUpView());
                      },
                      child: RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: "Do not have an account? ",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                                fontFamily: "Pulp")),
                        TextSpan(
                            text: "SignUp",
                            style: TextStyle(
                                color: Color(0XFF3CBBB1),
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                                fontFamily: "Pulp"))
                      ])),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
