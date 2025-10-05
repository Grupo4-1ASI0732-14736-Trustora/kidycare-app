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
      'price': 'S/15 por hora',
      'imageUrl': 'assets/images/nanny2.jpg',
      'isFavorite': true,
      'location': 'Miraflores',
      'services': ['Emergencia', 'Nocturno'],
    },
    {
      'name': 'Ana Lucía García',
      'experience': '7 años de experiencia',
      'rating': 4.7,
      'price': 'S/18 por hora',
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
      appBar: AppBar(
        title: Text(
          'Mis Favoritas',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: theme.colorScheme.primary,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          // Header con franja de color
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Tus niñeras guardadas",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _favoriteNannies.isNotEmpty
                      ? "${_favoriteNannies.length} niñera${_favoriteNannies.length != 1 ? 's' : ''} en tu lista"
                      : "Aún no tienes favoritas",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),

          // Contenido principal
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: _favoriteNannies.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.favorite_border,
                            size: 64,
                            color: theme.colorScheme.onSurface.withOpacity(0.3),
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
                            "Busca niñeras y agrega las que más te gusten a favoritos",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: theme.colorScheme.onSurface.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: _favoriteNannies.length,
                      itemBuilder: (context, index) {
                        final nanny = _favoriteNannies[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: NannyCard(
                            name: nanny['name'],
                            experience: nanny['experience'],
                            rating: nanny['rating'],
                            price: nanny['price'],
                            imageUrl: nanny['imageUrl'],
                            isFavorite: nanny['isFavorite'],
                            location: nanny['location'],
                            services: List<String>.from(nanny['services']),
                            onFavoriteToggle: () => _removeFavorite(index),
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
