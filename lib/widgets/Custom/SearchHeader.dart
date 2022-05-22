import 'package:developers_app/main.dart';
import 'package:developers_app/widgets/Custom/CustomTextField.dart';
import 'package:flutter/material.dart';

class SearchHeader extends StatelessWidget {
  final TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: width * .75,
            child: CustomTextField(
                backcolor: white,
                hinttext: 'Search',
                textEditingController: search),
          ),
          GestureDetector(
            child: Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: navy, borderRadius: BorderRadius.circular(10)),
              child: Icon(
                Icons.search_rounded,
                color: white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
