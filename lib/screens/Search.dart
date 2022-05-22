import 'package:developers_app/provider/CustomProvider.dart';
import 'package:developers_app/widgets/Custom/DropDown.dart';
import 'package:developers_app/widgets/Home/CardListt.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CustomProvider>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: DropDown(),
          ),
          CardList(
            filter: 'none',
            specialty: provider.categoryValue,
          ),
        ],
      ),
    );
  }
}
