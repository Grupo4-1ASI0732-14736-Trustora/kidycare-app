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
      appBar: AppBar(
        title: Text(
          'Buscar Niñeras',
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
                  "Encuentra la niñera perfecta",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Busca por nombre, ubicación o servicios",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 16),
                // Barra de búsqueda
                CustomSearchBar(
                  controller: _searchController,
                  hintText: "Buscar niñeras...",
                  onChanged: _performSearch,
                ),
              ],
            ),
          ),

          // Contenido principal
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  if (!_isSearching) ...[
                    Text(
                      "Sugerencias para ti",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Prueba buscando por ubicación como 'Miraflores' o por servicios como 'emergencia'",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: theme.colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                  ] else ...[
                    Text(
                      "Resultados de búsqueda (${_searchResults.length})",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: _searchResults.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.search_off,
                                    size: 64,
                                    color: theme.colorScheme.onSurface.withOpacity(0.3),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    "No se encontraron resultados",
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                                    ),
                                  ),
                                  Text(
                                    "Intenta con otros términos de búsqueda",
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: theme.colorScheme.onSurface.withOpacity(0.4),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : ListView.builder(
                              itemCount: _searchResults.length,
                              itemBuilder: (context, index) {
                                final nanny = _searchResults[index];
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
                                    onFavoriteToggle: () {
                                      setState(() {
                                        nanny['isFavorite'] = !nanny['isFavorite'];
                                      });
                                    },
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
