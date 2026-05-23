import 'package:flutter/material.dart';

import '../models/movie.dart';
import '../theme/app_theme.dart';
import 'movie_card.dart';

class MovieRow extends StatelessWidget {
  final String title;
  final List<Movie> movies;

  const MovieRow({
    super.key,
    required this.title,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 10),
          child: Text(title, style: AppTheme.displayFont.copyWith(fontSize: 22)),
        ),
        SizedBox(
          height: 170,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return MovieCard(movie: movies[index]);
            },
          ),
        ),
      ],
    );
  }
}
