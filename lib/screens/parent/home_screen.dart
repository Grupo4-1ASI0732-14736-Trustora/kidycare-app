import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/glass_navbar.dart';
import '../../widgets/category_card.dart';
import '../../widgets/nanny_card.dart';
import '../../widgets/custom_search_bar.dart';
import 'search_screen.dart';
import 'favorites_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;
  final TextEditingController _searchController = TextEditingController();

  // Datos de ejemplo para niñeras
  final List<Map<String, dynamic>> _featuredNannies = [
    {
      'name': 'María Elena Quispe',
      'experience': '5 años de experiencia',
      'rating': 4.8,
      'price': 'S/12/hora',
      'imageUrl': 'assets/images/nanny1.jpg',
      'isFavorite': false,
    },
    {
      'name': 'Carmen Rosa Flores',
      'experience': '3 años de experiencia',
      'rating': 4.9,
      'price': 'S/15/hora',
      'imageUrl': 'assets/images/nanny2.jpg',
      'isFavorite': true,
    },
  ];

  Widget _buildHomePage() {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header con saludo
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "¡Hola, Usuario!",
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      Text(
                        "Encuentra la niñera perfecta",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: theme.colorScheme.primary,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Barra de búsqueda
              CustomSearchBar(
                hintText: "Buscar niñeras...",
                controller: _searchController,
                onChanged: (value) {
                  // Implementar búsqueda
                },
                onFilterTap: () {
                  setState(() => _index = 1);
                },
              ),

              const SizedBox(height: 24),

              // Categorías
              Text(
                "Servicios",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),

              const SizedBox(height: 16),

              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                childAspectRatio: 1.5,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                children: [
                  CategoryCard(
                    title: "Cuidado diario",
                    icon: Icons.schedule,
                    onTap: () => setState(() => _index = 1),
                  ),
                  CategoryCard(
                    title: "Emergencia",
                    icon: Icons.emergency,
                    onTap: () => setState(() => _index = 1),
                  ),
                  CategoryCard(
                    title: "Fin de semana",
                    icon: Icons.weekend,
                    onTap: () => setState(() => _index = 1),
                  ),
                  CategoryCard(
                    title: "Nocturno",
                    icon: Icons.nightlight,
                    onTap: () => setState(() => _index = 1),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Niñeras destacadas
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Niñeras destacadas",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  TextButton(
                    onPressed: () => setState(() => _index = 1),
                    child: Text(
                      "Ver todas",
                      style: GoogleFonts.poppins(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Lista de niñeras
              ...List.generate(_featuredNannies.length, (index) {
                final nanny = _featuredNannies[index];
                return NannyCard(
                  name: nanny['name'],
                  experience: nanny['experience'],
                  rating: nanny['rating'],
                  price: nanny['price'],
                  imageUrl: nanny['imageUrl'],
                  isFavorite: nanny['isFavorite'],
                  onTap: () {
                    // Navegar a detalles de niñera
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Ver perfil de ${nanny['name']}")),
                    );
                  },
                  onFavoriteToggle: () {
                    setState(() {
                      _featuredNannies[index]['isFavorite'] = !nanny['isFavorite'];
                    });
                  },
                );
              }),

              const SizedBox(height: 100), // Espacio para el navbar
            ],
          ),
        ),
      ),
    );
  }

  // Método para obtener las páginas dinámicamente
  List<Widget> get _pages => [
    _buildHomePage(),
    const SearchScreen(),
    const FavoritesScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _pages[_index],
      bottomNavigationBar: GlassNavbar(
        currentIndex: _index,
        onTabChange: (i) => setState(() => _index = i),
      ),
    );
  }
}
