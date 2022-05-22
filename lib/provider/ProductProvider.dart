import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:developers_app/models/Product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  List<Product> products = [];
}
