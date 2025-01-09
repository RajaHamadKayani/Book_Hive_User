import 'package:flutter/material.dart';

class UpdateProfileComponent extends StatefulWidget {
  String title;
  TextEditingController controller;
  UpdateProfileComponent({super.key, required this.title, required this.controller});

  @override
  State<UpdateProfileComponent> createState() => _UpdateProfileComponentState();
}

class _UpdateProfileComponentState extends State<UpdateProfileComponent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          widget.title,
          style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: "Pulp"),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Color(0xffB5B5B5), width: 1)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 3),
            child: TextFormField(
              style: TextStyle(
                color: Colors.black
              ),
              controller: widget.controller,
              decoration: InputDecoration(
                border: InputBorder.none
              ),
            ),
          ),
        )
      ],
    );
  }
}
