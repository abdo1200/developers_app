import 'package:developers_app/main.dart';
import 'package:developers_app/screens/Register.dart';
import 'package:flutter/material.dart';

class SignUpText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("dosen't have account , "),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Register()));
          },
          child: Text(
            'Sign Up',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: purble),
          ),
        ),
      ],
    );
  }
}
