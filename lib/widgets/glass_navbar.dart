import 'dart:ui';
import 'package:flutter/material.dart';

class GlassNavbar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTabChange;

  const GlassNavbar({
    super.key,
    required this.currentIndex,
    required this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onTabChange,
          backgroundColor: theme.colorScheme.primary.withOpacity(0.15),
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: theme.colorScheme.primary,
          unselectedItemColor: theme.colorScheme.onBackground.withOpacity(0.6),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Inicio"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Buscar"),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favoritos"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
          ],
        ),
      ),
    );
  }
}
