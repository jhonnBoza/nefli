import 'package:flutter/material.dart';

import '../data/catalog_data.dart';
import '../models/movie.dart';
import '../routes/app_routes.dart';
import '../services/omdb_service.dart';
import '../theme/app_theme.dart';
import '../widgets/hero_banner.dart';
import '../widgets/movie_row.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final OmdbService _service = OmdbService();
  Movie? _featured;
  final Map<String, List<Movie>> _rows = {};
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadCatalog();
  }

  Future<void> _loadCatalog() async {
    try {
      final featured = await _service.getByTitle('suits', year: '2011');
      final rows = <String, List<Movie>>{};

      for (final entry in CatalogData.categories.entries) {
        final movies = await _service.searchMovies(entry.value);
        rows[entry.key] = movies.take(10).toList();
      }

      if (mounted) {
        setState(() {
          _featured = featured;
          _rows
            ..clear()
            ..addAll(rows);
          _loading = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Image.asset(
          'assets/images/netflix_logo.png',
          height: 28,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => Navigator.pushNamed(context, AppRoutes.search),
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => Navigator.pushNamed(context, AppRoutes.profile),
          ),
        ],
      ),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(color: AppTheme.netflixRed),
            )
          : RefreshIndicator(
              color: AppTheme.netflixRed,
              onRefresh: _loadCatalog,
              child: ListView(
                children: [
                  HeroBanner(movie: _featured),
                  SizedBox(
                    height: 48,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: CatalogData.menuItems.length,
                      itemBuilder: (context, index) {
                        final item = CatalogData.menuItems[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Center(
                            child: Text(
                              item,
                              style: AppTheme.accentFont.copyWith(
                                color: index == 0 ? Colors.white : AppTheme.netflixGray,
                                fontWeight:
                                    index == 0 ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  ..._rows.entries.map(
                    (entry) => MovieRow(title: entry.key, movies: entry.value),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
    );
  }
}
