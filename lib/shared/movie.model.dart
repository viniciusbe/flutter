class Movie {
  int? id;
  String? name;
  String? synopsis;
  int? duration;
  int? age;

  Movie({
    this.id,
    this.name,
    this.synopsis,
    this.duration,
    this.age,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        id: json['id'] as int,
        name: json['name'] as String,
        synopsis: json['synopsis'] as String,
        duration: json['duration'] as int,
        age: json['age'] as int,
      );

  String movieToString(Movie movie) => movie.toString();
}
