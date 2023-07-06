import 'package:http/http.dart' as http;
import 'package:movies/screens/tabs/browse/repository/repo.dart';
import 'package:movies/shared/components/constants.dart';
import 'package:movies/shared/components/end_points.dart';

class BrowseRemoteRepo extends BrowseRepo {
  @override
  Future<http.Response> getCategories() {
    Uri url = Uri.https(Constants.BASE, EndPoints.categoryEndpoint,
        {"api_key": Constants.APIKEY});
    return http.get(url);
  }

  // @override
  // Future<http.Response> getMoviesWithCategories(String category) {
  //
  //   return http.get(url);
  // }
}
