class Movie {
  final String imdbId;
  final String title;
  final String year;
  final String type;
  final String poster;
  final String plot;
  final String genre;
  final String director;
  final String actors;
  final String imdbRating;
  final String runtime;

  const Movie({
    required this.imdbId,
    required this.title,
    required this.year,
    required this.type,
    required this.poster,
    this.plot = '',
    this.genre = '',
    this.director = '',
    this.actors = '',
    this.imdbRating = 'N/A',
    this.runtime = '',
  });

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      imdbId: map['imdbID']?.toString() ?? '',
      title: map['Title']?.toString() ?? 'Sin título',
      year: map['Year']?.toString() ?? '',
      type: map['Type']?.toString() ?? '',
      poster: map['Poster']?.toString() ?? '',
      plot: map['Plot']?.toString() ?? '',
      genre: map['Genre']?.toString() ?? '',
      director: map['Director']?.toString() ?? '',
      actors: map['Actors']?.toString() ?? '',
      imdbRating: map['imdbRating']?.toString() ?? 'N/A',
      runtime: map['Runtime']?.toString() ?? '',
    );
  }

  bool get hasValidPoster =>
      poster.isNotEmpty && poster != 'N/A' && poster.startsWith('http');

  Map<String, String> toRouteMap() => {
        'imdbId': imdbId,
        'title': title,
        'year': year,
        'poster': poster,
      };
}
