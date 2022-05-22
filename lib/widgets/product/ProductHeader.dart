import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:developers_app/main.dart';
import 'package:developers_app/provider/CustomProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductHeader extends StatelessWidget {
  final String name;
  final String id;

  const ProductHeader({this.name, this.id});
  @override
  Widget build(BuildContext context) {
    var custom = Provider.of<CustomProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(name,
            style: TextStyle(
              fontSize: 20,
            )),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                custom.like(id);
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: navy,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Products')
                        .doc(id)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container();
                      }
                      return Row(
                        children: [
                          Icon(
                            Icons.favorite_rounded,
                            size: 20,
                            color: snapshot.data['likes'].contains(
                                    FirebaseAuth.instance.currentUser.email)
                                ? Colors.red
                                : white,
                          ),
                          SizedBox(width: 5),
                          Text(
                            snapshot.data['likes'].contains(
                                    FirebaseAuth.instance.currentUser.email)
                                ? 'unlike'
                                : 'like',
                            style: TextStyle(color: white),
                          )
                        ],
                      );
                    }),
              ),
            ),
            SizedBox(width: 10),
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
                      custom.save(id);
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: usersnapshot.data['saved'].contains(id)
                              ? navy
                              : navy.withOpacity(.2),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          usersnapshot.data['saved'].contains(id)
                              ? Container()
                              : Icon(
                                  Icons.save,
                                  color: navy,
                                  size: 15,
                                ),
                          SizedBox(
                            width: 5,
                          ),
                          usersnapshot.data['saved'].contains(id)
                              ? Text(
                                  'Unsave',
                                  style: TextStyle(
                                      color: white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10),
                                )
                              : Text(
                                  'Save',
                                  style: TextStyle(
                                      color: navy,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10),
                                )
                        ],
                      ),
                    ),
                  );
                }),
          ],
        )
      ],
    );
  }
}
