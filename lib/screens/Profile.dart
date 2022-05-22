import 'package:developers_app/main.dart';
import 'package:developers_app/models/User.dart';
import 'package:developers_app/provider/AuthProvider.dart';
import 'package:developers_app/provider/CustomProvider.dart';
import 'package:developers_app/widgets/Home/CardListt.dart';
import 'package:developers_app/widgets/profile/PersonalInfo.dart';
import 'package:developers_app/widgets/profile/ProfileHeader.dart';
import 'package:developers_app/widgets/profile/ProfileMenu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var custom = Provider.of<CustomProvider>(context);
    var auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
          child: FutureBuilder<Object>(
              future: auth.getUser(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                      width: width,
                      height: height,
                      child: Center(child: CircularProgressIndicator()));
                }
                UserModel userData = snapshot.data;
                return Container(
                  width: width,
                  child: Stack(
                    children: [
                      Container(
                        height: height * .35,
                        color: navy,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ProfileHeader(
                              image: userData.image, name: userData.name),
                          ProfileMenu(
                              likes: userData.likes,
                              followers: userData.followers,
                              views: userData.views),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  custom.profileoption(true);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: custom.personInfo
                                          ? navy
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text('Personal Info',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: custom.personInfo ? white : navy,
                                      )),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  custom.profileoption(false);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: custom.personInfo
                                          ? Colors.transparent
                                          : navy,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text('My Work',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: custom.personInfo ? navy : white,
                                      )),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          custom.personInfo
                              ? Column(
                                  children: [
                                    PersonalInfo(
                                      birthday: userData.birthday,
                                      email: userData.email,
                                      phone: userData.phone,
                                      specialty: userData.specialty,
                                    ),
                                    SizedBox(
                                      height: height * .15,
                                    )
                                  ],
                                )
                              : Column(children: [
                                  CardList(
                                    filter: 'user',
                                  ),
                                  SizedBox(height: height * .15)
                                ]),
                        ],
                      ),
                    ],
                  ),
                );
              })),
      // floatingActionButton: Container(
      //   padding: EdgeInsets.all(20),
      //   decoration: BoxDecoration(
      //     color: navy,
      //     borderRadius: BorderRadius.circular(50),
      //   ),
      //   child: Text('Hire',
      //       style: TextStyle(
      //         color: white,
      //         fontSize: 16,
      //       )),
      // ),
      // bottomSheet: Padding(padding: EdgeInsets.only(bottom: 150)),
    );
  }
}
