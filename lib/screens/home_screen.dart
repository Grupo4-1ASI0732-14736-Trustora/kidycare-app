import 'package:flutter/material.dart';
import '../widgets/glass_navbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;

  final List<Widget> _pages = const [
    Center(child: Text("Inicio")),
    Center(child: Text("Buscar niñera")),
    Center(child: Text("Favoritos")),
    Center(child: Text("Perfil")),
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
