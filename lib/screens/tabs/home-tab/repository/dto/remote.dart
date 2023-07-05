import 'package:http/http.dart' as http;
import 'package:movies/screens/tabs/home-tab/repository/repo.dart';
import 'package:movies/shared/components/constants.dart';

class RemoteRepo extends BaseRepository {
  @override
  Future<http.Response> getPopularMovies() {
    Uri url = Uri.https(
        Constants.BASE, '/3/movie/popular', {"api_key": Constants.APIKEY});
    return http.get(
      url,
    );
  }

  @override
  Future<http.Response> getNewReleasesMovies() {
    Uri url = Uri.https(
        Constants.BASE, '/3/movie/upcoming', {"api_key": Constants.APIKEY});
    return http.get(url);
  }

  @override
  Future<http.Response>? getTopMovies() {
    Uri url = Uri.https(
        Constants.BASE, '/3/movie/top_rated', {"api_key": Constants.APIKEY});
    return http.get(url);
  }

  @override
  Future<http.Response>? getMovieDetails(num movieId) {
    // TODO: implement getMovieDetails
    throw UnimplementedError();
  }

  // @override
  // Future<http.Response>? getMovieDetails(num movieId) {
  //   Uri url = Uri.https(
  //       Constants.BASE, '/3/movie$movieId', {"api_key": Constants.APIKEY});
  //   return http.get(url);
  // }
}
