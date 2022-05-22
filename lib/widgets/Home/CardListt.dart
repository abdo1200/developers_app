import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:developers_app/main.dart';
import 'package:developers_app/models/Product.dart';
import 'package:developers_app/provider/CustomProvider.dart';
import 'package:developers_app/provider/ProductProvider.dart';
import 'package:developers_app/screens/ProductDetails.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardList extends StatelessWidget {
  final String filter;
  final String specialty;
  String email = FirebaseAuth.instance.currentUser.email;

  CardList({this.filter, this.specialty});
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection('Products')
        .where('userEmail', isNotEqualTo: email)
        .snapshots();
    final Stream<QuerySnapshot> fliterStream = FirebaseFirestore.instance
        .collection('Products')
        .where('userEmail', isNotEqualTo: email)
        .where('specialty', isEqualTo: specialty)
        .snapshots();
    final Stream<QuerySnapshot> userProjects = FirebaseFirestore.instance
        .collection('Products')
        .where('userEmail', isEqualTo: email)
        .snapshots();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var provider = Provider.of<CustomProvider>(context);

    return StreamBuilder<QuerySnapshot>(
      stream: (filter == 'all')
          ? _usersStream
          : (filter == 'user')
              ? userProjects
              : fliterStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return GridView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            childAspectRatio: ((width * .55) / (height * .42)),
            mainAxisSpacing: 10,
          ),
          itemCount: snapshot.hasData ? snapshot.data.docs.length : 0,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            QueryDocumentSnapshot data = snapshot.data.docs[index];

            Product product = Product.fromMap(data);

            return GestureDetector(
              onTap: () async {
                await provider.view(product.id);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductDetails(product)));
              },
              child: Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: white,
                    boxShadow: [
                      BoxShadow(blurRadius: 2, color: black, spreadRadius: .5)
                    ],
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    ClipRRect(
                      child: Image.network(
                        data['image'],
                        fit: BoxFit.cover,
                        height: 150,
                        width: width * .45,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            FutureBuilder(
                                future: FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(data['userEmail'])
                                    .get(),
                                builder: (context, usersnapshot) {
                                  if (usersnapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Container();
                                  }
                                  return ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Container(
                                          height: 20,
                                          width: 20,
                                          child: Image.network(
                                              usersnapshot.data['image'])));
                                }),
                            SizedBox(width: 5),
                            Text(data['name']),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(Icons.favorite, color: Colors.red),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(data['likes'].length.toString()),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(Icons.visibility, color: Colors.purple),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(data['views'].length.toString()),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.save_alt_outlined, color: navy),
                                SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
