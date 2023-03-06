import 'package:mow/data/models/song.dart';
import 'package:mow/domain/music_api.dart';

class MusicRepository {
  final _apiProvider = MusicApiProvider();

  Future<List<Song>> searchTracks(String query) async {
    final response = await _apiProvider.searchTracks(query);
    return response;
  }

  // Future<Movie> fetchMovie(int id) async {
  //   final response = await _apiProvider.get("/movies/$id");
  //   return Movie.fromJson(response);
  // }
}
