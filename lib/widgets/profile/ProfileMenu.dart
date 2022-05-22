import 'package:developers_app/main.dart';
import 'package:flutter/material.dart';

class ProfileMenu extends StatelessWidget {
  final int likes;
  final List followers;
  final int views;

  ProfileMenu({this.likes, this.followers, this.views});
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.all(20),
      width: width * .9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(blurRadius: 2, color: navy, spreadRadius: 1)],
        color: white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Text(likes.toString(),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 5,
              ),
              Text('Likes'),
            ],
          ),
          Container(
            height: 30,
            width: 1,
            color: navy,
          ),
          Column(
            children: [
              Text(followers.length.toString(),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 5,
              ),
              Text('Followers'),
            ],
          ),
          Container(
            height: 30,
            width: 1,
            color: navy,
          ),
          Column(
            children: [
              Text(views.toString(),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 5,
              ),
              Text('Views'),
            ],
          ),
        ],
      ),
    );
  }
}
