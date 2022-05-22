import 'package:developers_app/models/User.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthProvider extends ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore _db = FirebaseFirestore.instance;
  UserCredential userCredential;

  UserModel user = UserModel();

  registerMethod(
    String email,
    String password,
    String name,
    String image,
    String phone,
    String birthday,
    String specialty,
  ) async {
    userCredential = await auth.createUserWithEmailAndPassword(
        email: email, password: password);

    await FirebaseFirestore.instance.collection('users').doc(email).set({
      'name': name,
      'email': email,
      'image': image,
      'saved': [],
      'specialty': specialty,
      'phone': phone,
      'birthday': birthday,
      'following': [],
      'followers': [],
      'view': 0,
      'likes': 0,
    });

    notifyListeners();
  }

  signMethod(String email, String password) async {
    userCredential =
        await auth.signInWithEmailAndPassword(email: email, password: password);

    notifyListeners();
  }

  logoutMethod() async {
    auth.signOut();
    user = new UserModel();
    notifyListeners();
  }

  Future<UserModel> getUser() {
    return _db
        .collection('users')
        .doc(auth.currentUser.email)
        .get()
        .then((document) => UserModel.fromMap(document.data()));
  }
}
