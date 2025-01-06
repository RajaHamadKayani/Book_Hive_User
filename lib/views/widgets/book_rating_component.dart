import 'package:flutter/material.dart';

class BookRatingComponent extends StatelessWidget {
  const BookRatingComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        return Padding(
          padding: const EdgeInsets.only(right: 2),
          child: Icon(
            Icons.star_outline,
            size: 16, // Adjust size as needed
            color: Colors.grey,
          ),
        );
      }),
    );
  }
}
