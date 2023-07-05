import 'dart:convert';

import 'package:http/http.dart' as http;
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
}
