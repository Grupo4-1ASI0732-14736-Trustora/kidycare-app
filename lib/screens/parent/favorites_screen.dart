import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/nanny_card.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  // Datos de ejemplo para niñeras favoritas
  List<Map<String, dynamic>> _favoriteNannies = [
    {
      'name': 'Carmen Rosa Flores',
      'experience': '3 años de experiencia',
      'rating': 4.9,
      'price': 'S/15/hora',
      'imageUrl': 'assets/images/nanny2.jpg',
      'isFavorite': true,
      'location': 'Miraflores',
      'services': ['Emergencia', 'Nocturno'],
    },
    {
      'name': 'Ana Lucía García',
      'experience': '7 años de experiencia',
      'rating': 4.7,
      'price': 'S/18/hora',
      'imageUrl': 'assets/images/nanny1.jpg',
      'isFavorite': true,
      'location': 'Surco',
      'services': ['Cuidado diario', 'Emergencia'],
    },
  ];

  void _removeFavorite(int index) {
    setState(() {
      _favoriteNannies.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Niñera eliminada de favoritos"),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                "Mis favoritas",
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),

              if (_favoriteNannies.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  "${_favoriteNannies.length} niñera${_favoriteNannies.length != 1 ? 's' : ''} guardada${_favoriteNannies.length != 1 ? 's' : ''}",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
              ],

              const SizedBox(height: 20),

              // Lista de favoritos
              Expanded(
                child: _buildFavoritesList(),
              ),

              const SizedBox(height: 100), // Espacio para el navbar
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFavoritesList() {
    final theme = Theme.of(context);

    if (_favoriteNannies.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_border,
              size: 80,
              color: theme.colorScheme.primary.withOpacity(0.3),
            ),
            const SizedBox(height: 16),
            Text(
              "No tienes favoritas aún",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Explora niñeras y marca las que\nmás te gusten como favoritas",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                // Navegar a búsqueda o home
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Navegar a búsqueda")),
                );
              },
              icon: const Icon(Icons.search),
              label: Text(
                "Buscar niñeras",
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: _favoriteNannies.length,
      itemBuilder: (context, index) {
        final nanny = _favoriteNannies[index];
        return NannyCard(
          name: nanny['name'],
          experience: nanny['experience'],
          rating: nanny['rating'],
          price: nanny['price'],
          imageUrl: nanny['imageUrl'],
          isFavorite: nanny['isFavorite'],
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Ver perfil de ${nanny['name']}")),
            );
          },
          onFavoriteToggle: () {
            _removeFavorite(index);
          },
        );
      },
    );
  }
}
