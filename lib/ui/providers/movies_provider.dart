import 'package:flutter/material.dart';
import 'package:mow/data/repositories/movies_repository.dart';

import '../../data/models/movie.dart';
// import 'package:movies_app/data/repositories/movie_repository.dart';
// import 'package:movies_app/domain/usecases/get_movies.dart';
// import 'package:movies_app/data/models/movie.dart';

class MovieProvider with ChangeNotifier {
  final MovieRepository _movieRepository = MovieRepository();

  String? title = 'WoM';

  List<Movie> movies = [];

  Future<void> fetchMovies() async {
    movies = await _movieRepository.fetchAllMovies();
    notifyListeners();
  }
}
