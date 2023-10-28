import 'package:hello_flutter/shared/movie.model.dart';

class FormModel {
  late Movie movie;

  FormModel(this.movie);

  factory FormModel.fromJson(Map<String, dynamic> json) {
    return FormModel(Movie.fromJson(json));
  }
}
