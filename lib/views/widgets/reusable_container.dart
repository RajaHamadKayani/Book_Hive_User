import 'package:flutter/material.dart';

class ReusableContainer extends StatelessWidget {
  String title;
  int color;
  BorderRadius borderRadius;

  ReusableContainer(
      {super.key,
      required this.borderRadius,
      required this.color,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: Color(color),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15,
        horizontal: 11),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
                color: Colors.white,
                fontFamily: "Pulp",
                fontSize: 16,
                fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }
}
