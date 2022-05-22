import 'package:developers_app/main.dart';
import 'package:developers_app/models/User.dart';
import 'package:developers_app/provider/AuthProvider.dart';
import 'package:developers_app/screens/Login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Header extends StatelessWidget {
  final String image;
  final String name;

  Header({this.image, this.name});

  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<AuthProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                        color: navy, width: 2, style: BorderStyle.solid)),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                        height: 30,
                        width: 30,
                        child: Image.network(
                          image,
                          fit: BoxFit.cover,
                        ))),
              ),
              SizedBox(
                width: 10,
              ),
              Text(name,
                  style: TextStyle(
                    fontSize: 18,
                  )),
            ],
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.logout,
                  color: navy,
                ),
                onPressed: () {
                  auth.logoutMethod();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Login()));
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
