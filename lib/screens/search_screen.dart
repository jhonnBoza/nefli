import 'package:flutter/material.dart';

import '../models/movie.dart';
import '../routes/app_routes.dart';
import '../services/omdb_service.dart';
import '../theme/app_theme.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final OmdbService _service = OmdbService();
  final TextEditingController _controller = TextEditingController(text: 'marvel');
  List<Movie> _results = [];
  bool _loading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _search();
  }

  Future<void> _search() async {
    final query = _controller.text.trim();
    if (query.isEmpty) return;

    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final results = await _service.searchMovies(query);
      if (mounted) {
        setState(() {
          _results = results;
          _loading = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _error = 'No se pudo conectar con OMDB';
          _loading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buscar', style: AppTheme.displayFont.copyWith(fontSize: 22)),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    style: AppTheme.bodyFont,
                    decoration: InputDecoration(
                      hintText: 'Ej: marvel, suits, batman',
                      hintStyle: AppTheme.accentFont,
                      filled: true,
                      fillColor: const Color(0xFF2A2A2A),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: const Icon(Icons.search, color: AppTheme.netflixGray),
                    ),
                    onSubmitted: (_) => _search(),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _search,
                  child: const Text('Buscar'),
                ),
              ],
            ),
          ),
          if (_loading)
            const Expanded(
              child: Center(
                child: CircularProgressIndicator(color: AppTheme.netflixRed),
              ),
            )
          else if (_error != null)
            Expanded(
              child: Center(
                child: Text(_error!, style: AppTheme.bodyFont),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: _results.length,
                itemBuilder: (context, index) {
                  final movie = _results[index];
                  return ListTile(
                    leading: movie.hasValidPoster
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Image.network(
                              movie.poster,
                              width: 50,
                              height: 70,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.movie, color: AppTheme.netflixRed),
                            ),
                          )
                        : const Icon(Icons.movie, color: AppTheme.netflixRed),
                    title: Text(movie.title, style: AppTheme.bodyFont),
                    subtitle: Text(
                      '${movie.year} · ${movie.type}',
                      style: AppTheme.accentFont,
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.detail,
                        arguments: movie,
                      );
                    },
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
