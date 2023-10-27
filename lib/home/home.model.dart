class MovieListModel {
  List<Movie> items;

  MovieListModel({this.items = const []});

  factory MovieListModel.fromJson(List<dynamic> json) {
    return MovieListModel(
        items: List<Movie>.from(json.map((e) => Movie.fromJson(e))));
  }
}

class Movie {
  final int? id;
  final String name;
  final String synopsis;
  final int duration;
  final int age;

  const Movie({
    this.id,
    required this.name,
    required this.synopsis,
    required this.duration,
    required this.age,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        id: json['id'] as int,
        name: json['name'] as String,
        synopsis: json['synopsis'] as String,
        duration: json['duration'] as int,
        age: json['age'] as int,
      );
}
