import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/custom_search_bar.dart';
import '../../widgets/nanny_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];
  bool _isSearching = false;

  // Datos de ejemplo para búsqueda
  final List<Map<String, dynamic>> _allNannies = [
    {
      'name': 'María Elena Quispe',
      'experience': '5 años de experiencia',
      'rating': 4.8,
      'price': 'S/12/hora',
      'imageUrl': 'assets/images/nanny1.jpg',
      'isFavorite': false,
      'location': 'San Isidro',
      'services': ['Cuidado diario', 'Fin de semana'],
    },
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
      'isFavorite': false,
      'location': 'Surco',
      'services': ['Cuidado diario', 'Emergencia'],
    },
  ];

  void _performSearch(String query) {
    setState(() {
      _isSearching = query.isNotEmpty;
      if (query.isEmpty) {
        _searchResults = [];
      } else {
        _searchResults = _allNannies
            .where((nanny) =>
                nanny['name'].toLowerCase().contains(query.toLowerCase()) ||
                nanny['location'].toLowerCase().contains(query.toLowerCase()) ||
                nanny['services'].any((service) =>
                    service.toLowerCase().contains(query.toLowerCase())))
            .toList();
      }
    });
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
                "Buscar niñeras",
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),

              const SizedBox(height: 20),

              // Barra de búsqueda
              CustomSearchBar(
                hintText: "Buscar por nombre, ubicación o servicio...",
                controller: _searchController,
                onChanged: _performSearch,
                onFilterTap: () {
                  // Implementar filtros
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Filtros próximamente")),
                  );
                },
              ),

              const SizedBox(height: 20),

              // Resultados de búsqueda
              Expanded(
                child: _buildSearchResults(),
              ),

              const SizedBox(height: 100), // Espacio para el navbar
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    final theme = Theme.of(context);

    if (!_isSearching) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search,
              size: 80,
              color: theme.colorScheme.primary.withOpacity(0.3),
            ),
            const SizedBox(height: 16),
            Text(
              "Busca niñeras por nombre,\nubicación o tipo de servicio",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
          ],
        ),
      );
    }

    if (_searchResults.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 80,
              color: theme.colorScheme.primary.withOpacity(0.3),
            ),
            const SizedBox(height: 16),
            Text(
              "No se encontraron resultados",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurface,
              ),
            ),
            Text(
              "Intenta con otros términos de búsqueda",
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final nanny = _searchResults[index];
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
            setState(() {
              final originalIndex = _allNannies.indexWhere(
                  (original) => original['name'] == nanny['name']);
              if (originalIndex != -1) {
                _allNannies[originalIndex]['isFavorite'] =
                    !nanny['isFavorite'];
                _searchResults[index]['isFavorite'] = !nanny['isFavorite'];
              }
            });
          },
        );
      },
    );
  }
}
