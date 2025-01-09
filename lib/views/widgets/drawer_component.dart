import 'package:flutter/material.dart';

class DrawerComponent extends StatefulWidget {
  String title;
  String iamge;
  DrawerComponent({super.key, required this.iamge, required this.title});

  @override
  State<DrawerComponent> createState() => _DrawerComponentState();
}

class _DrawerComponentState extends State<DrawerComponent> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(widget.iamge),
      title: Text(widget.title,
      style: TextStyle(
        color: Colors.black,
        fontFamily: "Pulp",
        fontWeight: FontWeight.w700,
        fontSize: 16
      ),),
    );
  }
}
