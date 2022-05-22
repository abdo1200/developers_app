import 'package:developers_app/widgets/Home/CardListt.dart';
import 'package:flutter/material.dart';

class MyWork extends StatelessWidget {
  final List<String> images = [
    'assets/ecommerce.jpg',
    'assets/food.png',
    'assets/wallpaper.jpg',
    'assets/xo.png',
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 20,
        ),
        CardList(
          filter: 'user',
        )
      ],
    );
  }
}
