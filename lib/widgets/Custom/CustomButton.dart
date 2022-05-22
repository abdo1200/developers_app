import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function ontap;
  final String text;
  final Color textcolor;
  final Color btncolor;
  final Color bordercolor;
  final IconData iconData;
  final LinearGradient linearGradient;

  CustomButton(
      {this.ontap,
      this.text,
      this.textcolor,
      this.btncolor,
      this.iconData,
      this.linearGradient,
      this.bordercolor});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
            color: btncolor,
            borderRadius: BorderRadius.circular(10),
            border: (bordercolor != null)
                ? Border.all(
                    color: bordercolor, style: BorderStyle.solid, width: 1)
                : null,
            gradient: linearGradient),
        child: Text(
          text,
          style: TextStyle(
            color: textcolor,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
