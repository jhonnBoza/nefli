/// Listas y Mapas utilizados en la aplicación.
class CatalogData {
  static const List<String> menuItems = [
    'Inicio',
    'Series',
    'Películas',
    'Novedades',
    'Mi lista',
  ];

  static const Map<String, String> categories = {
    'Tendencias': 'marvel',
    'Acción': 'action',
    'Comedia': 'comedy',
    'Drama': 'drama',
    'Terror': 'horror',
    'Ciencia Ficción': 'star',
  };

  static const Map<String, String> featuredSearches = {
    'Destacado': 'suits',
    'Popular': 'batman',
    'Nuevo': 'dune',
  };

  static const List<Map<String, String>> quickLinks = [
    {'titulo': 'Suits', 'anio': '2011'},
    {'titulo': 'Inception', 'anio': '2010'},
    {'titulo': 'Interstellar', 'anio': '2014'},
  ];
}
