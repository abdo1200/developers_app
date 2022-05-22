import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:developers_app/models/Specialty.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  Stream<List<Specialty>> getSpecialty() {
    return _db.collection('Specialties').snapshots().map((snapshot) => snapshot
        .docs
        .map((document) => Specialty.fromMap(document.data()))
        .toList());
  }
}
