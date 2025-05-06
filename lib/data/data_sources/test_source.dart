import 'package:http/http.dart' as http;
import 'dart:convert';

class TmdbRemoteDataSource {
  final String apiKey = '6d0f6680c900ce71d6f46bec0199d7b9';
  final String baseUrl = 'https://api.themoviedb.org/3';

  Future<List<dynamic>> getPopularMovies() async {
    final response = await http.get(
      Uri.parse('$baseUrl/movie/popular?api_key=$apiKey')
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['results'] as List<dynamic>);
    } else {
      throw Exception('Failed to load movies');
    }
  }
}