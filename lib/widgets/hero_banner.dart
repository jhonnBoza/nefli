import 'package:flutter/material.dart';

import '../models/movie.dart';
import '../routes/app_routes.dart';
import '../theme/app_theme.dart';

class HeroBanner extends StatelessWidget {
  final Movie? movie;

  const HeroBanner({super.key, this.movie});

  @override
  Widget build(BuildContext context) {
    if (movie == null) {
      return Container(
        height: 420,
        color: AppTheme.netflixDark,
        alignment: Alignment.center,
        child: const CircularProgressIndicator(color: AppTheme.netflixRed),
      );
    }

    return SizedBox(
      height: 420,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (movie!.hasValidPoster)
            Image.network(
              movie!.poster,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  Container(color: AppTheme.netflixDark),
            )
          else
            Container(color: AppTheme.netflixDark),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Color(0xCC141414),
                  Color(0xFF141414),
                ],
              ),
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 24,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie!.title.toUpperCase(),
                  style: AppTheme.displayFont.copyWith(fontSize: 36),
                ),
                const SizedBox(height: 8),
                Text(
                  '${movie!.year} · ${movie!.genre.isNotEmpty ? movie!.genre : movie!.type}',
                  style: AppTheme.accentFont,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.detail,
                          arguments: movie,
                        );
                      },
                      icon: const Icon(Icons.play_arrow),
                      label: const Text('Reproducir'),
                    ),
                    const SizedBox(width: 12),
                    OutlinedButton.icon(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Colors.white54),
                      ),
                      icon: const Icon(Icons.info_outline),
                      label: Text('Info', style: AppTheme.bodyFont),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
