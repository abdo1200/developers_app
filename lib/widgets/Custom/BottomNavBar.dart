import 'package:developers_app/main.dart';
import 'package:developers_app/screens/Favorite.dart';
import 'package:developers_app/screens/Home.dart';
import 'package:developers_app/screens/Profile.dart';
import 'package:developers_app/screens/Search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  var currentIndex = 0;
  List<Widget> _screens = [
    Home(),
    Search(),
    Favorite(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
        backgroundColor: white,
        body: Stack(
          children: [
            _screens[currentIndex],
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  margin: EdgeInsets.all(displayWidth * .05),
                  height: displayWidth * .155,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.1),
                        blurRadius: 30,
                        offset: Offset(0, 10),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: ListView.builder(
                      itemCount: 4,
                      scrollDirection: Axis.horizontal,
                      padding:
                          EdgeInsets.symmetric(horizontal: displayWidth * .02),
                      itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            setState(() {
                              currentIndex = index;

                              HapticFeedback.lightImpact();
                            });
                          },
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          child: Stack(
                            children: [
                              AnimatedContainer(
                                duration: Duration(seconds: 1),
                                curve: Curves.fastLinearToSlowEaseIn,
                                width: index == currentIndex
                                    ? displayWidth * .32
                                    : displayWidth * .18,
                                alignment: Alignment.center,
                                child: AnimatedContainer(
                                  duration: Duration(seconds: 1),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  height: index == currentIndex
                                      ? displayWidth * .12
                                      : 0,
                                  width: index == currentIndex
                                      ? displayWidth * .32
                                      : 0,
                                  decoration: BoxDecoration(
                                    color: index == currentIndex
                                        ? navy.withOpacity(.2)
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                              ),
                              AnimatedContainer(
                                duration: Duration(seconds: 1),
                                curve: Curves.fastLinearToSlowEaseIn,
                                width: index == currentIndex
                                    ? displayWidth * .31
                                    : displayWidth * .18,
                                alignment: Alignment.center,
                                child: Stack(
                                  children: [
                                    Row(
                                      children: [
                                        AnimatedContainer(
                                          duration: Duration(seconds: 1),
                                          curve: Curves.fastLinearToSlowEaseIn,
                                          width: index == currentIndex
                                              ? displayWidth * .13
                                              : 0,
                                        ),
                                        AnimatedOpacity(
                                          opacity:
                                              index == currentIndex ? 1 : 0,
                                          duration: Duration(seconds: 1),
                                          curve: Curves.fastLinearToSlowEaseIn,
                                          child: Text(
                                            index == currentIndex
                                                ? '${listOfStrings[index]}'
                                                : '',
                                            style: TextStyle(
                                              color: navy,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        AnimatedContainer(
                                          duration: Duration(seconds: 1),
                                          curve: Curves.fastLinearToSlowEaseIn,
                                          width: index == currentIndex
                                              ? displayWidth * .03
                                              : 20,
                                        ),
                                        Icon(
                                          listOfIcons[index],
                                          size: displayWidth * .076,
                                          color: index == currentIndex
                                              ? navy
                                              : Colors.black26,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )))),
            ),
          ],
        ));
  }

  List<IconData> listOfIcons = [
    Icons.home_rounded,
    Icons.search_rounded,
    Icons.save_alt_rounded,
    Icons.person_rounded,
  ];
  List<String> listOfStrings = [
    'Home',
    'Serach',
    'Saved',
    'Person',
  ];
}
