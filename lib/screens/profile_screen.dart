import 'package:flutter/material.dart';

import '../data/catalog_data.dart';
import '../routes/app_routes.dart';
import '../theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi Perfil', style: AppTheme.displayFont.copyWith(fontSize: 22)),
      ),
      body: ListView(
        children: [
          Card(
            margin: const EdgeInsets.all(16),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
                  child: Image.asset(
                    'assets/images/distance-education-1.png',
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Educación a Distancia',
                        style: AppTheme.displayFont.copyWith(fontSize: 24),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Laboratorio 10 - Desarrollo Móvil Multimedial',
                        style: AppTheme.bodyFont,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'ListViews · ListTiles · Rutas · Tema Global · Cards',
                        style: AppTheme.accentFont,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Accesos rápidos (Listas y Mapas)',
              style: AppTheme.displayFont.copyWith(fontSize: 20),
            ),
          ),
          ...CatalogData.quickLinks.map(
            (link) => ListTile(
              leading: const CircleAvatar(
                backgroundColor: AppTheme.netflixRed,
                child: Icon(Icons.movie, color: Colors.white),
              ),
              title: Text(link['titulo'] ?? '', style: AppTheme.bodyFont),
              subtitle: Text('Año ${link['anio']}', style: AppTheme.accentFont),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.detail,
                  arguments: link,
                );
              },
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
