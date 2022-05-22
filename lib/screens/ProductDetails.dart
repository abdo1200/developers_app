import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:developers_app/main.dart';
import 'package:developers_app/models/Product.dart';
import 'package:developers_app/provider/CustomProvider.dart';
import 'package:developers_app/widgets/product/ProductBar.dart';
import 'package:developers_app/widgets/product/ProductComments.dart';
import 'package:developers_app/widgets/product/ProductHeader.dart';
import 'package:developers_app/widgets/product/ProductImage.dart';
import 'package:developers_app/widgets/product/ProductOwner.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatelessWidget {
  final Product product;

  ProductDetails(this.product);
  @override
  Widget build(BuildContext context) {
    var custom = Provider.of<CustomProvider>(context, listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              ProductBar(),
              SizedBox(
                height: 10,
              ),
              FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('users')
                      .doc(product.userEmail)
                      .get(),
                  builder: (context, usersnapshot) {
                    if (usersnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Container();
                    }
                    return ProductOwner(
                      image: usersnapshot.data['image'],
                      name: usersnapshot.data['name'],
                      specialty: usersnapshot.data['specialty'],
                      email: product.userEmail,
                    );
                  }),
              SizedBox(
                height: 20,
              ),
              ProductHeader(id: product.id, name: product.name),
              ProductImage(
                image: product.image,
                date: product.date,
                id: product.id,
                views: product.views.length.toString(),
              ),
              ProductComments(id: product.id),
            ],
          ),
        ),
      ),
    );
  }
}
