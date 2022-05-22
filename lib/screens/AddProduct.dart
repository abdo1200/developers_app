import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:developers_app/main.dart';
import 'package:developers_app/models/Product.dart';
import 'package:developers_app/provider/CustomProvider.dart';
import 'package:developers_app/screens/ProductDetails.dart';
import 'package:developers_app/widgets/Custom/CustomButton.dart';
import 'package:developers_app/widgets/Custom/CustomTextField.dart';
import 'package:developers_app/widgets/Custom/DropDown.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart';
import 'package:intl/intl.dart';

class AddProduct extends StatelessWidget {
  final TextEditingController name = TextEditingController();
  final TextEditingController description = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var custom = Provider.of<CustomProvider>(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
        backgroundColor: navy,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 20),
                child: Row(
                  children: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      child: (custom.userImageFile != null)
                          ? Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50)),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    width: width * .7,
                                    child: Image.file(
                                      custom.userImageFile,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                    color: navy,
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.add_a_photo,
                                          color: white,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text("Change Image",
                                            style: TextStyle(
                                                color: white, fontSize: 20)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(
                              width: width * .75,
                              height: height * .35,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                    style:
                                        TextStyle(color: purble, fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                      onPressed: () async {
                        await custom.getimage();
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              CustomTextField(
                hinttext: 'Project Name',
                backcolor: white,
                textEditingController: name,
              ),
              SizedBox(height: 20),
              CustomTextField(
                hinttext: 'description',
                backcolor: white,
                textEditingController: description,
              ),
              SizedBox(height: 20),
              Container(
                color: Colors.white,
                child: DropDown(),
              ),
              SizedBox(height: 20),
              CustomButton(
                linearGradient: linearColor,
                text: 'Add',
                ontap: () async {
                  var now = new DateTime.now();
                  var dateformatter = new DateFormat('yyyy-MM-dd');
                  var timeformatter = new DateFormat('hh:mm');
                  String date = dateformatter.format(now);
                  String time = timeformatter.format(now);

                  Reference storageReference = FirebaseStorage.instance
                      .ref()
                      .child(basename(custom.userImageFile.path));
                  print('1');
                  UploadTask uploadTask =
                      storageReference.putFile(custom.userImageFile);
                  print('2');
                  await uploadTask.whenComplete(() {
                    print('File Uploaded');
                    String image;
                    storageReference.getDownloadURL().then((fileURL) async {
                      image = fileURL;
                      await custom.addProduct(
                          name.text,
                          description.text,
                          fileURL,
                          date,
                          custom.categoryValue,
                          FirebaseAuth.instance.currentUser.email,
                          time);
                    });

                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductDetails(Product(
                                  name: name.text,
                                  userEmail:
                                      FirebaseAuth.instance.currentUser.email,
                                  date: date,
                                  time: time,
                                  description: description.text,
                                  image: image,
                                  specialty: custom.categoryValue,
                                  comments: [],
                                  likes: [],
                                  views: [],
                                ))));
                    name.text = '';
                    description.text = '';
                    custom.userImageFile = null;
                    custom.categoryValue = null;
                  });
                },
                textcolor: white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
