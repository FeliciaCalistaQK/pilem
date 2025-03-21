import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String apiKey = '3ca730984ca2569220926da0be7e7d51';

  Future<List<Map<String, dynamic>>> getAllMovies() async {
    final response =
        await http.get(Uri.parse('$baseUrl/movie/now_playing?api_key=$apiKey'));
    final data = json.decode(response.body);
    return List<Map<String, dynamic>>.from(data['results']);
  }

  Future<List<Map<String, dynamic>>> getTrendingMovies() async {
    final response = await http
        .get(Uri.parse('$baseUrl/trending/movie/week?api_key=$apiKey'));
    final data = json.decode(response.body);
    return List<Map<String, dynamic>>.from(data['results']);
  }

  Future<List<Map<String, dynamic>>> getPopularMovies() async {
    final response =
        await http.get(Uri.parse('$baseUrl/movie/popular?api_key=$apiKey'));
    final data = json.decode(response.body);
    return List<Map<String, dynamic>>.from(data['results']);
  }

  Future<List<Map<String, dynamic>>> searchMovies(String query) async {
    final response = await http.get(Uri.parse('$baseUrl/search/movie?api_key=$apiKey&query=$query'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data['results']);
    } else {
      throw Exception('Failed to load movies');
    }
  }
}