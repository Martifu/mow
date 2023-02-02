import 'dart:convert';

import 'package:mow/data/models/movie.dart';

import 'package:http/http.dart' as http;

import 'dart:developer';

class MovieApiProvider {
  final String _baseUrl = 'https://api.themoviedb.org/3/';

  Future<List<Movie>> getMovies() async {
    final response = await http.get(Uri.parse(
        '${_baseUrl}movie/now_playing?api_key=874cd93d6e29b382616656c501e0906c&language=es-MX&page=1&include_video=true&sort_by=popularity.desc'));
    if (response.statusCode == 200) {
      var movies = jsonDecode(response.body);
      log(response.body);
      return movieFromJson(jsonEncode(movies['results']));
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
