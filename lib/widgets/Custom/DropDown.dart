import 'package:developers_app/Services/firestore_service.dart';
import 'package:developers_app/main.dart';
import 'package:developers_app/models/Specialty.dart';
import 'package:developers_app/provider/CustomProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DropDown extends StatelessWidget {
  final FirestoreService _db = FirestoreService();
  @override
  Widget build(BuildContext context) {
    var specialty = Provider.of<List<Specialty>>(context);
    var provider = Provider.of<CustomProvider>(context);
    return StreamBuilder<Object>(
        stream: _db.getSpecialty(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          return DropdownButtonFormField(
            items: specialty.map((spec) {
              return new DropdownMenuItem(
                  value: spec.name,
                  child: Row(
                    children: <Widget>[
                      Text(spec.name),
                    ],
                  ));
            }).toList(),
            onChanged: provider.chooseCategory,
            value: provider.categoryValue,
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: purble,
                )),
                focusColor: Colors.blue,
                fillColor: purble,
                labelText: 'Specialty',
                labelStyle: TextStyle(color: purble, fontSize: 20)),
          );
        });
  }
}
