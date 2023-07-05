import 'package:http/http.dart';


abstract class BaseRepository {
  Future<Response>? getPopularMovies();
  Future<Response>? getNewReleasesMovies();
  Future<Response>? getTopMovies();
  Future<Response>? getMovieDetails(num movieId);
}
