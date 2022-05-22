class UserModel {
  final String email;
  final String name;
  final String image;
  final String phone;
  final String birthday;
  final String specialty;
  final List followers;
  final List following;
  final int views;
  final int likes;
  final List saved;

  UserModel(
      {this.email,
      this.name,
      this.phone,
      this.birthday,
      this.specialty,
      this.image,
      this.saved,
      this.followers,
      this.following,
      this.likes,
      this.views});

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      birthday: data['birthday'] ?? '',
      image: data['image'] ?? '',
      phone: data['phone'] ?? '',
      specialty: data['specialty'] ?? '',
      saved: data['saved'] ?? '',
      followers: data['followers'] ?? '',
      following: data['following'] ?? '',
      likes: data['likes'] ?? '',
      views: data['views'] ?? '',
    );
  }
}
