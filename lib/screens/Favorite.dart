import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:developers_app/main.dart';
import 'package:developers_app/models/Product.dart';
import 'package:developers_app/models/User.dart';
import 'package:developers_app/provider/AuthProvider.dart';
import 'package:developers_app/screens/ProductDetails.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Favorite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    var auth = Provider.of<AuthProvider>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          FutureBuilder<UserModel>(
              future: auth.getUser(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    height: height,
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                UserModel userData = snapshot.data;
                return GridView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      childAspectRatio: ((width * .55) / (height * .42)),
                      mainAxisSpacing: 10,
                    ),
                    itemCount: userData.saved.length,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      //QueryDocumentSnapshot data = snapshot.data.docs[index];

                      CollectionReference products =
                          FirebaseFirestore.instance.collection('Products');

                      return FutureBuilder<DocumentSnapshot>(
                        future: products.doc(userData.saved[index]).get(),
                        builder: (BuildContext context,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (snapshot.hasData && !snapshot.data.exists) {
                            return Text("Document does not exist");
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            DocumentSnapshot data = snapshot.data;
                            Product product = Product.fromMap(data);

                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProductDetails(product)));
                              },
                              child: Container(
                                margin: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: white,
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 2,
                                          color: black,
                                          spreadRadius: .5)
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
                                                future: FirebaseFirestore
                                                    .instance
                                                    .collection('users')
                                                    .doc(data['userEmail'])
                                                    .get(),
                                                builder:
                                                    (context, usersnapshot) {
                                                  if (usersnapshot
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    return Container();
                                                  }
                                                  return ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      child: Container(
                                                          height: 20,
                                                          width: 20,
                                                          child: Image.network(
                                                              usersnapshot.data[
                                                                  'image'])));
                                                }),
                                            SizedBox(width: 5),
                                            Text(data['name']),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Icon(Icons.favorite,
                                                    color: Colors.red),
                                                SizedBox(
                                                  width: 2,
                                                ),
                                                Text(data['likes']
                                                    .length
                                                    .toString()),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Icon(Icons.visibility,
                                                    color: Colors.purple),
                                                SizedBox(
                                                  width: 2,
                                                ),
                                                Text(data['views']
                                                    .length
                                                    .toString()),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Icon(Icons.save_alt_outlined,
                                                    color: navy),
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
                          }

                          return Text("loading");
                        },
                      );
                    });
              }),
        ],
      ),
    );
  }
}
