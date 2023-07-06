import 'package:http/http.dart';

abstract class BrowseRepo {
  Future<Response> getCategories();

  // Future<Response> getMoviesWithCategories(String category);
}
