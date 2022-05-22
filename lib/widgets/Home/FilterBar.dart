import 'package:developers_app/main.dart';
import 'package:developers_app/provider/CustomProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var custom = Provider.of<CustomProvider>(context);
    return Container(
      padding: const EdgeInsets.only(right: 10, left: 20, top: 20, bottom: 10),
      color: white,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              custom.trendingOption(false);
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: custom.forYou
                  ? null
                  : BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: linearColor),
              child: Text(
                'All',
                style: TextStyle(
                    fontSize: 18, color: custom.forYou ? navy : white),
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          GestureDetector(
            onTap: () {
              custom.trendingOption(true);
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: custom.forYou
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: linearColor)
                  : null,
              child: Text(
                'For You',
                style: TextStyle(
                    fontSize: 18, color: custom.forYou ? white : navy),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
