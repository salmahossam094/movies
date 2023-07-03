
import 'package:http/http.dart' as http;

abstract class SearchRepo {
  Future<http.Response> search(String query);
}
