import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class CustomProvider extends ChangeNotifier {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  bool personInfo = true;
  profileoption(option) {
    personInfo = option;
    notifyListeners();
  }

  bool forYou = false;
  trendingOption(option) {
    forYou = option;
    notifyListeners();
  }

  File userImageFile;
  String imgurl;

  Future getimage() async {
    final ImagePicker _picker = ImagePicker();
    XFile userImageXFile = await _picker.pickImage(source: ImageSource.gallery);
    userImageFile = File(userImageXFile.path);
    print(userImageFile);
    notifyListeners();
  }

  String categoryValue;

  void chooseCategory(value) {
    categoryValue = value;
    notifyListeners();
  }

  addProduct(
    String name,
    String description,
    String image,
    String date,
    String specialty,
    String userEmail,
    String time,
  ) async {
    await FirebaseFirestore.instance.collection('Products').doc().set({
      'name': name,
      'userEmail': userEmail,
      'image': image,
      'comments': [],
      'specialty': specialty,
      'date': date,
      'time': time,
      'views': [],
      'likes': [],
    });

    notifyListeners();
  }

  follow(email) async {
    await _db
        .collection('users')
        .doc(auth.currentUser.email)
        .get()
        .then((document) {
      List following = document.data()['following'];
      if (following.contains(email)) {
        following.remove(email);
        _db
            .collection('users')
            .doc(auth.currentUser.email)
            .update({'following': following});
      } else {
        following.add(email);
        _db
            .collection('users')
            .doc(auth.currentUser.email)
            .update({'following': following});
      }
    });
    await _db.collection('users').doc(email).get().then((document) {
      List followers = document.data()['followers'];
      if (followers.contains(auth.currentUser.email)) {
        followers.remove(auth.currentUser.email);
        _db.collection('users').doc(email).update({'followers': followers});
      } else {
        followers.add(auth.currentUser.email);
        _db.collection('users').doc(email).update({'followers': followers});
      }
    });
    notifyListeners();
  }

  save(id) async {
    await _db
        .collection('users')
        .doc(auth.currentUser.email)
        .get()
        .then((document) {
      List saved = document.data()['saved'];
      if (saved.contains(id)) {
        saved.remove(id);
        _db
            .collection('users')
            .doc(auth.currentUser.email)
            .update({'saved': saved});
      } else {
        saved.add(id);
        _db
            .collection('users')
            .doc(auth.currentUser.email)
            .update({'saved': saved});
      }
    });
    notifyListeners();
  }

  like(id) async {
    await _db.collection('Products').doc(id).get().then((document) async {
      List likes = document.data()['likes'];
      String email = document.data()['userEmail'];
      if (likes.contains(auth.currentUser.email)) {
        await _db.collection('users').doc(email).get().then((document2) {
          int like = document2.data()['likes'];
          like = like - 1;
          _db.collection('users').doc(email).update({'likes': like});
        });
        likes.remove(auth.currentUser.email);
        _db.collection('Products').doc(id).update({'likes': likes});
      } else {
        await _db.collection('users').doc(email).get().then((document2) {
          int like = document2.data()['likes'];
          like = like + 1;
          _db.collection('users').doc(email).update({'likes': like});
        });
        likes.add(auth.currentUser.email);
        _db.collection('Products').doc(id).update({'likes': likes});
      }
    });
    notifyListeners();
  }

  comment(id, content) async {
    var now = new DateTime.now();
    var dateformatter = new DateFormat('yyyy-MM-dd');
    var timeformatter = new DateFormat('hh:mm');
    String date = dateformatter.format(now);
    String time = timeformatter.format(now);
    await _db
        .collection('users')
        .doc(auth.currentUser.email)
        .get()
        .then((user) async {
      await _db.collection('Products').doc(id).get().then((document) {
        List comments = document.data()['comments'];
        comments.add({
          'userName': user.data()['name'],
          'userImage': user.data()['image'],
          'content': content,
          'data': date,
          'time': time
        });
        _db.collection('Products').doc(id).update({'comments': comments});
      });
    });
    notifyListeners();
  }

  view(id) async {
    await _db.collection('Products').doc(id).get().then((document) async {
      List views = document.data()['views'];
      String email = document.data()['userEmail'];
      if (views.contains(auth.currentUser.email)) {
        _db.collection('Products').doc(id).update({'views': views});
      } else {
        await _db.collection('users').doc(email).get().then((document2) {
          int view = document2.data()['views'];
          view = view + 1;
          _db.collection('users').doc(email).update({'views': view});
        });
        views.add(auth.currentUser.email);
        _db.collection('Products').doc(id).update({'views': views});
      }
    });
    notifyListeners();
  }
}
