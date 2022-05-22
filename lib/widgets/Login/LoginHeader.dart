import 'package:developers_app/main.dart';
import 'package:developers_app/widgets/Custom/Clipershapes.dart';
import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  final double heightPercentage;

  LoginHeader({this.heightPercentage});
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      //mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipPath(
          clipper: MyClipper1(),
          child: Container(
            width: width,
            height: height * heightPercentage,
            decoration: BoxDecoration(gradient: linearColor),
          ),
        ),
        ClipPath(
          clipper: MyClipper2(),
          child: Container(
            width: width,
            height: height * heightPercentage,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                colors: <Color>[
                  navy.withOpacity(.5),
                  purble.withOpacity(.5),
                ],
              ),
            ),
          ),
        ),
        ClipPath(
          clipper: MyClipper3(),
          child: Container(
            width: width,
            height: height * heightPercentage,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                colors: <Color>[
                  navy.withOpacity(.5),
                  purble.withOpacity(.5),
                ],
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: width,
          height: height * heightPercentage,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Creative',
                  style: TextStyle(
                    color: white,
                    fontSize: 30,
                  )),
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.lightbulb,
                color: pink,
              )
            ],
          ),
        )
      ],
    );
  }
}
