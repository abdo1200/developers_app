class Specialty{
  final String name;
  Specialty({this.name});

  factory Specialty.fromMap(Map<String, dynamic> data) {
    return Specialty(
      name: data['name'] ?? '',
    );
  }
}