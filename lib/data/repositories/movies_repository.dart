import '../../domain/movie_api.dart';
import '../models/movie.dart';

class MovieRepository {
  final _apiProvider = MovieApiProvider();

  Future<List<Movie>> fetchAllMovies() async {
    final response = await _apiProvider.getMovies();
    return response;
  }

  // Future<Movie> fetchMovie(int id) async {
  //   final response = await _apiProvider.get("/movies/$id");
  //   return Movie.fromJson(response);
  // }
}
