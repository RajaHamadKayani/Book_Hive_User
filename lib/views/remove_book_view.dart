import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

// ignore: must_be_immutable
class SuccessfulView extends StatelessWidget {
  String title;
   SuccessfulView({Key? key,required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                    ),
                    child: const Stack(
                      children: [
                        Positioned(
                          top: 1,
                          left: 2,
                          child: CircleAvatar(
                            radius: 10,
                            backgroundColor: Color(0xff5858CC),
                          ),
                        ),
                        Positioned(
                          // top: 1,
                          bottom: 3,
                          right: 0,
                          child: CircleAvatar(
                            radius: 7,
                            backgroundColor: Color(0xff5858CC),
                          ),
                        ),
                        Positioned(
                          top: 1,
                          right: 2,
                          child: CircleAvatar(
                            radius: 4,
                            backgroundColor: Color(0xff5858CC99),
                          ),
                        ),
                        Positioned(
                          top: 30,
                          right: 2,
                          child: CircleAvatar(
                            radius: 4,
                            backgroundColor: Color(0xff5858CC99),
                          ),
                        ),
                        Positioned(
                          top: 1,
                          bottom: 2,
                          child: CircleAvatar(
                            radius: 4,
                            backgroundColor: Color(0xff5858CC99),
                          ),
                        ),
                        Positioned(
                          // top: 1,
                          bottom: 2,
                          child: CircleAvatar(
                            radius: 4,
                            backgroundColor: Color(0xff5858CC99),
                          ),
                        ),
                        Positioned(
                          top: 1,
                          bottom: 2,
                          child: CircleAvatar(
                            radius: 4,
                            backgroundColor: Color(0xff5858CC99),
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          right: 20,
                          child: CircleAvatar(
                            radius: 3,
                            backgroundColor: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Done icon
                  Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      color: Color(0xFF50C878),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.done,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
               Text.rich(
                TextSpan(
                  text: 'Successfully ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: title,
                      style: TextStyle(
                        color: Color(0xff7F789D),
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 70,
              ),
              ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6A5AE0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
