class Movie {
  final int id;
  final String name;
  final String synopsis;
  final int duration;
  final int age;

  const Movie({
    required this.id,
    required this.name,
    required this.synopsis,
    required this.duration,
    required this.age,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] as int,
      name: json['name'] as String,
      synopsis: json['synopsis'] as String,
      duration: json['duration'] as int,
      age: json['age'] as int,
    );
  }
}
