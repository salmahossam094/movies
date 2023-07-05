import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies/model/MovieDetailsModel.dart';
import 'package:movies/model/PopularModel.dart';
import 'package:movies/model/SearchModel.dart';

import '../../../shared/components/constants.dart';
import '../../../shared/components/end_points.dart';

class ApiManager {
  static Future<SearchModel> search(String query) async {
    Uri url = Uri.https(Constants.BASE, EndPoints.searchEndpoint,
        {"api_key": Constants.APIKEY, "query": query});
    http.Response response = await http.get(url);
    var responseJson = jsonDecode(response.body);
    SearchModel searchModel = SearchModel.fromJson(responseJson);
    return searchModel;
  }

  static Future<MovieDetailsModel> movieDetails(num movieId) async {
    Uri url = Uri.http(
        Constants.BASE,
        '${EndPoints.movieDetailsEndpoint}$movieId',
        {"api_key": Constants.APIKEY});
    http.Response response = await http.get(url);
    var responseJson = jsonDecode(response.body);
    MovieDetailsModel movieDetailsModel =
        MovieDetailsModel.fromJson(responseJson);
    return movieDetailsModel;
  }

  static Future<PopularModel> getSimilarMovies(num movieId) async {
    Uri url = Uri.https(
        Constants.BASE, '${EndPoints.movieDetailsEndpoint}$movieId/similar', {"api_key": Constants.APIKEY});
    http.Response response = await http.get(url);
    var responseJson = jsonDecode(response.body);
    PopularModel model = PopularModel.fromJson(responseJson);
    print(model.statusCode);
    return model;
  }
}
