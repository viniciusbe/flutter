import 'package:flutter/material.dart';
import 'package:hello_flutter/shared/loading.viewmodel.dart';
import 'package:hello_flutter/home/home.model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomeViewModel extends LoadingViewModel {
  MovieListModel _homeModel = MovieListModel();

  HomeViewModel();

  MovieListModel get homeModel => _homeModel;

  set homeModel(MovieListModel list) {
    _homeModel = list;
    notifyListeners();
  }

  void addItem(Movie movie) {}

  Future<void> fetchData() async {
    try {
      isLoading = true;
      final response = await http.get(
          Uri.parse(
              'https://fqzyopllwufpsragzdju.supabase.co/rest/v1/movies?select=*'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'apikey':
                'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZxenlvcGxsd3VmcHNyYWd6ZGp1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTgyNzc0MTgsImV4cCI6MjAxMzg1MzQxOH0.gPkfTyP3qe3i2tITJtBhQuP3rRL1DKb6eO2uOhhi9jM',
          });

      List<dynamic> list = json.decode(response.body);
      _homeModel = MovieListModel.fromJson(list);
    } catch (exc) {
      debugPrint('Error in _fetchData : ${exc.toString()}');
    }

    isLoading = false;
    notifyListeners();
  }
}
