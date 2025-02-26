import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://api.themoviedb.org/3";
  static const String apikey = "3e08132f85ad271dfdad036bfe53f012";

  Future<List<Map<String, dynamic>>> getAllMovies() async {
    final response = await http
        .get(Uri.parse("$baseUrl/movie/now_playing?api_keys=$apikey"));
    final data = json.decode(response.body);
    return List<Map<String, dynamic>>.from(data['results']);
  }

  Future<List<Map<String, dynamic>>> getTrendingMovies() async {
    final response =
        await http.get(Uri.parse("$baseUrl/movie/trending?api_keys=$apikey"));
    final data = json.decode(response.body);
    return List<Map<String, dynamic>>.from(data['results']);
  }

  Future<List<Map<String, dynamic>>> getPopularMovies() async {
    final response =
        await http.get(Uri.parse("$baseUrl/movie/popular?api_keys=$apikey"));
    final data = json.decode(response.body);
    return List<Map<String, dynamic>>.from(data['results']);
  }
}
