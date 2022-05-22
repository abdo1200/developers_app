import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final String userEmail;
  final String name;
  final String description;
  final String image;
  final String date;
  final String time;
  final String specialty;
  final List views;
  final List likes;
  final List comments;

  Product(
      {this.userEmail,
      this.id,
      this.name,
      this.description,
      this.image,
      this.date,
      this.time,
      this.specialty,
      this.views,
      this.likes,
      this.comments});

  factory Product.fromMap(snapshot) {
    Map data = snapshot.data();
    return Product(
      id: snapshot.id,
      name: data['name'] ?? '',
      userEmail: data['userEmail'] ?? '',
      date: data['date'] ?? '',
      time: data['time'] ?? '',
      description: data['description'] ?? '',
      image: data['image'] ?? '',
      specialty: data['specialty'] ?? '',
      comments: data['comments'] ?? '',
      likes: data['likes'] ?? '',
      views: data['views'] ?? '',
    );
  }
}
