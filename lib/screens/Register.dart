import 'package:developers_app/main.dart';
import 'package:developers_app/provider/AuthProvider.dart';
import 'package:developers_app/provider/CustomProvider.dart';
import 'package:developers_app/widgets/Custom/BottomNavBar.dart';
import 'package:developers_app/widgets/Custom/CustomButton.dart';
import 'package:developers_app/widgets/Custom/CustomTextField.dart';
import 'package:developers_app/widgets/Custom/DropDown.dart';
import 'package:developers_app/widgets/Login/LoginHeader.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Register extends StatelessWidget {
  final TextEditingController email = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController birthday = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var auth = Provider.of<AuthProvider>(context);
    var custom = Provider.of<CustomProvider>(context);
    return Scaffold(
      backgroundColor: white,
      body: SingleChildScrollView(
        child: Container(
            child: Column(
          children: [
            LoginHeader(
              heightPercentage: .2,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: CustomTextField(
                backcolor: white,
                hinttext: 'Enter your email',
                iconData: Icons.email,
                textEditingController: email,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: CustomTextField(
                  backcolor: white,
                  hinttext: 'Enter your name',
                  iconData: Icons.person,
                  textEditingController: name),
            ),
            Container(
              padding: EdgeInsets.only(left: 20),
              child: Row(
                children: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      primary: Colors.white,
                    ),
                    child: (custom.userImageFile != null)
                        ? Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50)),
                            child: Row(
                              children: <Widget>[
                                Image.file(
                                  custom.userImageFile,
                                  width: 70,
                                  height: 70,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Icon(
                                  Icons.add_a_photo,
                                  color: purble,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("Change Image",
                                    style:
                                        TextStyle(color: purble, fontSize: 20)),
                              ],
                            ),
                          )
                        : Row(
                            children: [
                              Icon(
                                Icons.add_a_photo,
                                color: purble,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Choose image",
                                style: TextStyle(color: purble, fontSize: 20),
                              ),
                            ],
                          ),
                    onPressed: () async {
                      await custom.getimage();
                    },
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.only(left: 30, right: 30),
              child: Container(
                color: Colors.white,
                child: DropDown(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: width * .45,
                    child: CustomTextField(
                        backcolor: white,
                        hinttext: 'phone',
                        iconData: Icons.phone_android,
                        textEditingController: phone),
                  ),
                  Container(
                    width: width * .45,
                    child: CustomTextField(
                        backcolor: white,
                        hinttext: 'birthday',
                        iconData: Icons.calendar_today,
                        textEditingController: birthday),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: CustomTextField(
                  backcolor: white,
                  hinttext: 'Enter your password',
                  iconData: Icons.lock,
                  textEditingController: password),
            ),
            SizedBox(
              height: 20,
            ),
            CustomButton(
              linearGradient: linearColor,
              text: 'Register',
              ontap: () async {
                Reference storageReference = FirebaseStorage.instance
                    .ref()
                    .child(basename(custom.userImageFile.path));
                UploadTask uploadTask =
                    storageReference.putFile(custom.userImageFile);
                await uploadTask.whenComplete(() {
                  print('File Uploaded');
                  storageReference.getDownloadURL().then((fileURL) async {
                    await auth.registerMethod(
                        email.text,
                        password.text,
                        name.text,
                        fileURL,
                        phone.text,
                        birthday.text,
                        custom.categoryValue);
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  });
                });
              },
              textcolor: white,
            ),
          ],
        )),
      ),
    );
  }
}
