import 'package:developers_app/main.dart';
import 'package:developers_app/provider/AuthProvider.dart';

import 'package:developers_app/widgets/Custom/BottomNavBar.dart';
import 'package:developers_app/widgets/Custom/CustomButton.dart';
import 'package:developers_app/widgets/Custom/CustomTextField.dart';
import 'package:developers_app/widgets/Login/LoginHeader.dart';
import 'package:developers_app/widgets/Login/SignUpText.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: white,
      body: SingleChildScrollView(
        child: Container(
            child: Column(
          children: [
            LoginHeader(
              heightPercentage: .5,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: CustomTextField(
                backcolor: white,
                hinttext: 'Enter your email',
                iconData: Icons.email,
                textEditingController: email,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: CustomTextField(
                  backcolor: white,
                  hinttext: 'Enter your password',
                  iconData: Icons.lock,
                  textEditingController: password),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SignUpText(),
                SizedBox(
                  width: 10,
                ),
                CustomButton(
                  linearGradient: linearColor,
                  text: 'Login',
                  ontap: () async {
                    await auth.signMethod(email.text, password.text);
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                  textcolor: white,
                ),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
          ],
        )),
      ),
    );
  }
}
