import 'package:hello_flutter/shared/movie.model.dart';

class MovieListModel {
  List<Movie> items;

  MovieListModel({this.items = const []});

  factory MovieListModel.fromJson(List<dynamic> json) {
    return MovieListModel(
        items: List<Movie>.from(json.map((e) => Movie.fromJson(e))));
  }
}
