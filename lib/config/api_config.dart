class ApiConfig {
  static const String apiKey = 'f1def80d';
  static const String baseUrl = 'http://www.omdbapi.com/';

  static String searchUrl(String query) =>
      '$baseUrl?apikey=$apiKey&s=$query';

  static String searchByTitleUrl(String title, {String? year}) {
    final yearParam = year != null ? '&y=$year' : '';
    return '$baseUrl?apikey=$apiKey&t=$title$yearParam';
  }

  static String searchByIdUrl(String imdbId) =>
      '$baseUrl?apikey=$apiKey&i=$imdbId';
}
