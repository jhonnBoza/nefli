import 'package:flutter/material.dart';

import '../models/movie.dart';
import '../services/omdb_service.dart';
import '../theme/app_theme.dart';

class MovieDetailScreen extends StatefulWidget {
  final Movie? movie;
  final Map<String, String>? movieMap;

  const MovieDetailScreen({super.key, this.movie}) : movieMap = null;

  const MovieDetailScreen.fromMap(Map<String, String> map, {super.key})
      : movie = null,
        movieMap = map;

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  final OmdbService _service = OmdbService();
  Movie? _movie;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadDetail();
  }

  Future<void> _loadDetail() async {
    Movie? detail;

    if (widget.movie != null && widget.movie!.plot.isNotEmpty) {
      detail = widget.movie;
    } else if (widget.movie != null) {
      detail = await _service.getById(widget.movie!.imdbId);
    } else if (widget.movieMap != null) {
      final map = widget.movieMap!;
      if (map['imdbId']?.isNotEmpty == true) {
        detail = await _service.getById(map['imdbId']!);
      } else {
        detail = await _service.getByTitle(
          map['title'] ?? '',
          year: map['year'],
        );
      }
    }

    if (mounted) {
      setState(() {
        _movie = detail;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _movie?.title ?? 'Detalle',
          style: AppTheme.displayFont.copyWith(fontSize: 20),
        ),
      ),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(color: AppTheme.netflixRed),
            )
          : _movie == null
              ? Center(
                  child: Text('No se encontró la película', style: AppTheme.bodyFont),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (_movie!.hasValidPoster)
                        Image.network(
                          _movie!.poster,
                          height: 320,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            height: 200,
                            color: const Color(0xFF2A2A2A),
                            alignment: Alignment.center,
                            child: const Icon(Icons.movie, size: 64),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _movie!.title,
                              style: AppTheme.displayFont.copyWith(fontSize: 28),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${_movie!.year} · ${_movie!.runtime} · ${_movie!.genre}',
                              style: AppTheme.accentFont,
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                const Icon(Icons.star, color: Colors.amber, size: 20),
                                const SizedBox(width: 6),
                                Text(
                                  'IMDb ${_movie!.imdbRating}',
                                  style: AppTheme.bodyFont.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text('Sinopsis', style: AppTheme.displayFont.copyWith(fontSize: 20)),
                            const SizedBox(height: 8),
                            Text(_movie!.plot, style: AppTheme.bodyFont),
                            const SizedBox(height: 16),
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Director', style: AppTheme.accentFont),
                                    Text(_movie!.director, style: AppTheme.bodyFont),
                                    const SizedBox(height: 12),
                                    Text('Actores', style: AppTheme.accentFont),
                                    Text(_movie!.actors, style: AppTheme.bodyFont),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
