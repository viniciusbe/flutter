import 'package:flutter/material.dart';
import 'package:hello_flutter/form/form.model.dart';
import 'package:hello_flutter/shared/http_utils.dart';
import 'package:hello_flutter/shared/loading.viewmodel.dart';
import 'package:hello_flutter/shared/movie.model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class FormViewModel extends StatusViewModel {
  FormModel _formModel = FormModel(Movie());

  FormModel get formModel => _formModel;

  set formModel(FormModel formModel) {
    _formModel = formModel;
    notifyListeners();
  }

  Future<void> fetchData() async {
    try {
      status = Status.loading;

      final response = await http.get(
        Uri.parse('$baseUrl/movies?id=${_formModel.movie.id}'),
        headers: headers,
      );

      Map<String, dynamic> list = json.decode(response.body);
      _formModel = FormModel.fromJson(list);
      status = Status.success;
    } catch (exc) {
      status = Status.error;
      debugPrint('Error in _fetchData : ${exc.toString()}');
    }

    notifyListeners();
  }

  Future<void> createData(name, synopsis, duration, age) async {
    try {
      status = Status.loading;

      Map<String, dynamic> updatedMovie = {
        'name': name,
        'synopsis': synopsis,
        'duration': duration,
        'age': age
      };

      await http.post(Uri.parse('$baseUrl/movies'),
          headers: headers, body: jsonEncode(updatedMovie));

      status = Status.success;
    } catch (exc) {
      status = Status.error;
      debugPrint('Error in _fetchData : ${exc.toString()}');
    }

    notifyListeners();
  }
}
