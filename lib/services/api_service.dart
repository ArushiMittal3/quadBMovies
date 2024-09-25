import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://api.tvmaze.com';

  Future<List<dynamic>> fetchMovies() async {
    final response = await http.get(Uri.parse('$baseUrl/search/shows?q=all'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<List<dynamic>> searchMovies(String query) async {
    final response =
        await http.get(Uri.parse('$baseUrl/search/shows?q=$query'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
