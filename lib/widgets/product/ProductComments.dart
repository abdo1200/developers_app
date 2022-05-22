import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:developers_app/main.dart';
import 'package:developers_app/provider/CustomProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductComments extends StatelessWidget {
  final String id;
  final TextEditingController comment = TextEditingController();

  ProductComments({this.id});
  @override
  Widget build(BuildContext context) {
    var custom = Provider.of<CustomProvider>(context, listen: false);
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Container(
          decoration: BoxDecoration(
              color: navy.withOpacity(.2),
              borderRadius: BorderRadius.circular(40)),
          child: TextField(
              controller: comment,
              decoration: InputDecoration(
                hintText: 'Leave Comment',
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: const EdgeInsets.all(20.0),
                suffixIcon: GestureDetector(
                  onTap: () async {
                    await custom.comment(id, comment.text);
                    comment.text = '';
                  },
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: navy, borderRadius: BorderRadius.circular(40)),
                    child: Icon(
                      Icons.send,
                      color: white,
                    ),
                  ),
                ),
              )),
        ),
        SizedBox(
          height: 10,
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
              return ListView.builder(
                  itemCount: snapshot.data['comments'].length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: navy, style: BorderStyle.solid, width: .5),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                        color: navy,
                                        width: 2,
                                        style: BorderStyle.solid)),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Container(
                                        height: 30,
                                        width: 30,
                                        child: Image.network(
                                            snapshot.data['comments'][index]
                                                ['userImage']))),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      snapshot.data['comments'][index]
                                          ['userName'],
                                      style: TextStyle(
                                        fontSize: 12,
                                      )),
                                  Text(
                                      snapshot.data['comments'][index]
                                          ['content'],
                                      style: TextStyle(
                                        fontSize: 18,
                                      )),
                                ],
                              ),
                              SizedBox(
                                width: 20,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(snapshot.data['comments'][index]['data']),
                              Text(snapshot.data['comments'][index]['time']),
                            ],
                          )
                        ],
                      ),
                    );
                  });
            }),
      ],
    );
  }
}
