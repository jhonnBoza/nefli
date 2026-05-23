import 'package:flutter/material.dart';

import '../models/movie.dart';
import '../routes/app_routes.dart';
import '../theme/app_theme.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final double width;
  final double height;

  const MovieCard({
    super.key,
    required this.movie,
    this.width = 120,
    this.height = 170,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.detail,
          arguments: movie,
        );
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.only(right: 8),
        child: SizedBox(
          width: width,
          height: height,
          child: movie.hasValidPoster
              ? Image.network(
                  movie.poster,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => _placeholder(),
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppTheme.netflixRed,
                        strokeWidth: 2,
                      ),
                    );
                  },
                )
              : _placeholder(),
        ),
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      color: const Color(0xFF2A2A2A),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8),
      child: Text(
        movie.title,
        textAlign: TextAlign.center,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        style: AppTheme.accentFont.copyWith(color: Colors.white),
      ),
    );
  }
}
