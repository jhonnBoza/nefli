import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/api_config.dart';
import '../models/movie.dart';

class OmdbService {
  Future<List<Movie>> searchMovies(String query) async {
    final response = await http.get(Uri.parse(ApiConfig.searchUrl(query)));

    if (response.statusCode != 200) {
      throw Exception('Error al buscar películas');
    }

    final data = json.decode(response.body) as Map<String, dynamic>;
    if (data['Response'] != 'True') {
      return [];
    }

    final results = data['Search'] as List<dynamic>? ?? [];
    return results
        .map((item) => Movie.fromMap(item as Map<String, dynamic>))
        .toList();
  }

  Future<Movie?> getByTitle(String title, {String? year}) async {
    final response = await http.get(
      Uri.parse(ApiConfig.searchByTitleUrl(title, year: year)),
    );

    if (response.statusCode != 200) return null;

    final data = json.decode(response.body) as Map<String, dynamic>;
    if (data['Response'] != 'True') return null;

    return Movie.fromMap(data);
  }

  Future<Movie?> getById(String imdbId) async {
    final response = await http.get(Uri.parse(ApiConfig.searchByIdUrl(imdbId)));

    if (response.statusCode != 200) return null;

    final data = json.decode(response.body) as Map<String, dynamic>;
    if (data['Response'] != 'True') return null;

    return Movie.fromMap(data);
  }
}
