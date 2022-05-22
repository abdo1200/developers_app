import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:developers_app/main.dart';
import 'package:developers_app/provider/CustomProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductOwner extends StatelessWidget {
  final String image;
  final String name;
  final String email;
  final String specialty;

  const ProductOwner({this.image, this.name, this.specialty, this.email});
  @override
  Widget build(BuildContext context) {
    var custom = Provider.of<CustomProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border:
                  Border.all(color: navy, width: 2, style: BorderStyle.solid)),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                  height: 30, width: 30, child: Image.network(image))),
        ),
        SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name,
                style: TextStyle(
                  fontSize: 18,
                )),
            Text(specialty,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          ],
        ),
        SizedBox(
          width: 20,
        ),
        FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser.email)
                .get(),
            builder: (context, usersnapshot) {
              if (usersnapshot.connectionState == ConnectionState.waiting) {
                return Container();
              }
              return GestureDetector(
                onTap: () {
                  custom.follow(email);
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: usersnapshot.data['following'].contains(email)
                          ? navy
                          : navy.withOpacity(.2),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      usersnapshot.data['following'].contains(email)
                          ? Container()
                          : Icon(
                              Icons.person_add,
                              color: navy,
                              size: 15,
                            ),
                      SizedBox(
                        width: 5,
                      ),
                      usersnapshot.data['following'].contains(email)
                          ? Text(
                              'Unfollow',
                              style: TextStyle(
                                  color: white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10),
                            )
                          : Text(
                              'Follow',
                              style: TextStyle(
                                  color: navy,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10),
                            ),
                    ],
                  ),
                ),
              );
            })
      ],
    );
  }
}
