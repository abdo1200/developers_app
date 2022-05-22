import 'package:developers_app/main.dart';
import 'package:developers_app/models/User.dart';
import 'package:developers_app/provider/AuthProvider.dart';
import 'package:developers_app/provider/CustomProvider.dart';
import 'package:developers_app/screens/AddProduct.dart';
import 'package:developers_app/widgets/Home/CardListt.dart';
import 'package:developers_app/widgets/Home/FilterBar.dart';
import 'package:developers_app/widgets/Home/Header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sticky_headers/sticky_headers.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    var custom = Provider.of<CustomProvider>(context);
    var auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: FutureBuilder<UserModel>(
            future: auth.getUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  height: height,
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              UserModel userData = snapshot.data;
              return Column(
                children: [
                  Header(
                    image: userData.image,
                    name: userData.name,
                  ),
                  StickyHeader(
                    header: FilterBar(),
                    content: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          custom.forYou
                              ? CardList(
                                  filter: 'forYou',
                                  specialty: userData.specialty)
                              : CardList(
                                  filter: 'all', specialty: userData.specialty),
                          SizedBox(
                            height: height * .15,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              );
            }),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddProduct()));
        },
        child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: navy,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Icon(
              Icons.add,
              color: Colors.white,
            )),
      ),
      bottomSheet: Padding(padding: EdgeInsets.only(bottom: 150)),
    );
  }
}
