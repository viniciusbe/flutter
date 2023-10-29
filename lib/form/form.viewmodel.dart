import 'package:flutter/material.dart';
import 'package:hello_flutter/form/form.model.dart';
import 'package:hello_flutter/shared/http_utils.dart';
import 'package:hello_flutter/shared/status.viewmodel.dart';
import 'package:hello_flutter/shared/movie.model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class FormViewModel extends StatusViewModel {
  int? _movieId;
  FormModel _formModel = FormModel(Movie());

  FormModel get formModel => _formModel;

  set formModel(FormModel formModel) {
    _formModel = formModel;
    notifyListeners();
  }

  Future<void> fetchData(int? movieId) async {
    if (movieId == null) {
      _formModel = FormModel(Movie());
      status = Status.fetched;
      notifyListeners();
      return;
    }

    _movieId = movieId;

    try {
      status = Status.loading;

      final response = await http.get(
        Uri.parse('$baseUrl/movies?select=*&id=eq.$movieId'),
        headers: headers,
      );

      List<dynamic> data = json.decode(response.body);
      _formModel = FormModel.fromJson(data[0]);
      status = Status.fetched;
    } catch (exc) {
      status = Status.error;
      debugPrint('Error in _fetchData : ${exc.toString()}');
    }

    notifyListeners();
  }

  Future<void> createData(name, synopsis, duration, age) async {
    try {
      // status = Status.loading;

      Map<String, String> updatedMovie = {
        'name': name,
        'synopsis': synopsis,
        'duration': duration.toString(),
        'age': age.toString()
      };

      await http.post(Uri.parse('$baseUrl/movies'),
          headers: headers, body: updatedMovie);

      status = Status.created;
    } catch (exc) {
      status = Status.error;
      debugPrint('Error in _createData : ${exc.toString()}');
    }

    notifyListeners();
  }
}
