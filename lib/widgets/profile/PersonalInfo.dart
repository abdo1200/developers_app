import 'package:developers_app/main.dart';
import 'package:flutter/material.dart';

class PersonalInfo extends StatelessWidget {
  final String email;
  final String phone;
  final String birthday;
  final String specialty;

  PersonalInfo({this.email, this.phone, this.birthday, this.specialty});
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: navy.withOpacity(.2),
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                Icon(Icons.email),
                SizedBox(width: 10),
                Text(email),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: width * .4,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: navy.withOpacity(.2),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Icon(Icons.phone_android),
                    SizedBox(width: 10),
                    Text(phone),
                  ],
                ),
              ),
              Container(
                width: width * .4,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: navy.withOpacity(.2),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Icon(Icons.calendar_today),
                    SizedBox(width: 10),
                    Text(birthday),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text('Specialty',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: navy,
                  )),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                    color: navy.withOpacity(.2),
                    borderRadius: BorderRadius.circular(10)),
                child: Text(specialty),
              ),
            ],
          )
        ],
      ),
    );
  }
}
