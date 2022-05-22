import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  final String image;
  final String date;
  final String id;
  final String views;

  ProductImage({this.image, this.date, this.id, this.views});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            image,
            width: width * .95,
          ),
        ),
        SizedBox(
          height: 20,
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
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Products')
                        .doc(id)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container();
                      }
                      return Text(snapshot.data['likes'].length.toString());
                    }),
                SizedBox(
                  width: 10,
                ),
                Icon(Icons.visibility, color: Colors.purple),
                SizedBox(
                  width: 2,
                ),
                Text(views),
              ],
            ),
            Text(date)
          ],
        ),
      ],
    );
  }
}
