import 'dart:convert';
import 'package:hello_flutter/model.dart';
import 'package:http/http.dart' as http;

Future<List<Movie>> fetchMovies() async {
  final response = await http.get(
      Uri.parse(
          'https://fqzyopllwufpsragzdju.supabase.co/rest/v1/movies?select=*'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'apikey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZxenlvcGxsd3VmcHNyYWd6ZGp1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTgyNzc0MTgsImV4cCI6MjAxMzg1MzQxOH0.gPkfTyP3qe3i2tITJtBhQuP3rRL1DKb6eO2uOhhi9jM',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsImtpZCI6Ijk5RkhrUFd3MFJoTElGTnoiLCJ0eXAiOiJKV1QifQ.eyJhdWQiOiJhdXRoZW50aWNhdGVkIiwiZXhwIjoxNjk4MzAxMTc5LCJpYXQiOjE2OTgyOTc1NzksImlzcyI6Imh0dHBzOi8vZnF6eW9wbGx3dWZwc3JhZ3pkanUuc3VwYWJhc2UuY28vYXV0aC92MSIsInN1YiI6IjY0MWYxNjU0LTQ0ZDQtNDJjMC1hMzA1LWFmZjcwMTJjNzg3NCIsImVtYWlsIjoidmluaWJzcDEwQGdtYWlsLmNvbSIsInBob25lIjoiIiwiYXBwX21ldGFkYXRhIjp7InByb3ZpZGVyIjoiZW1haWwiLCJwcm92aWRlcnMiOlsiZW1haWwiXX0sInVzZXJfbWV0YWRhdGEiOnt9LCJyb2xlIjoiYXV0aGVudGljYXRlZCIsImFhbCI6ImFhbDEiLCJhbXIiOlt7Im1ldGhvZCI6InBhc3N3b3JkIiwidGltZXN0YW1wIjoxNjk4Mjk3NTc5fV0sInNlc3Npb25faWQiOiIzNWYwMzZlMi1mNjNhLTRhMTAtYmRjNi0yODNkNzgwMjI2MDUifQ.6oAsHpgvyuH1S1ORhJnO_tjmRuQ5H9VrABHgYgfnOn0',
      });

  if (response.statusCode == 200) {
    List<dynamic> list = json.decode(response.body);
    return List<Movie>.from(list.map((e) => Movie.fromJson(e)));
  } else {
    throw Exception('Failed to load movies: ${response.statusCode}');
  }
}
