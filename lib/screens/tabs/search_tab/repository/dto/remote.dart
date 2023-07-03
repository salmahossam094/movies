import 'package:http/http.dart' as http;
import 'package:movies/screens/tabs/search_tab/repository/repo.dart';
import 'package:movies/shared/components/constants.dart';
import 'package:movies/shared/components/end_points.dart';

class RemoteRepoSearch extends SearchRepo {
  @override
  Future<http.Response> search(String query) {
    Uri url = Uri.https(Constants.BASE, EndPoints.searchEndpoint,
        {"api_key": Constants.APIKEY, "query": query});
    return http.get(url);
  }
}
