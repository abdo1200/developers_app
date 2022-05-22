import 'package:developers_app/main.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String image;

  const ProfileHeader({this.name, this.image});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              icon: Icon(
                Icons.logout,
                color: white,
              ),
              onPressed: () {},
            ),
          ],
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Image.network(
            image,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          name,
          style: TextStyle(fontSize: 20, color: white),
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
