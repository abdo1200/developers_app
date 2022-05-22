import 'package:developers_app/main.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hinttext;
  final Color backcolor;
  final IconData iconData;
  final TextEditingController textEditingController;

  const CustomTextField(
      {this.hinttext,
      this.backcolor,
      this.iconData,
      this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: backcolor,
            borderRadius: BorderRadiusDirectional.circular(100)),
        child: TextFormField(
            controller: textEditingController,
            decoration: InputDecoration(
              hintText: hinttext,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    width: 1,
                    color: purble,
                    style: BorderStyle.solid,
                  )),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    width: 1,
                    color: purble,
                    style: BorderStyle.solid,
                  )),
              contentPadding: const EdgeInsets.all(20.0),
              suffixIcon: (iconData != null)
                  ? IconButton(
                      onPressed: () {},
                      icon: Icon(
                        iconData,
                        color: pink,
                      ),
                    )
                  : null,
            )));
  }
}
