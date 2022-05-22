import 'package:developers_app/main.dart';
import 'package:flutter/material.dart';

class ProductBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: navy,
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Icon(
            Icons.logout,
            color: navy,
          ),
        ),
      ],
    );
  }
}
