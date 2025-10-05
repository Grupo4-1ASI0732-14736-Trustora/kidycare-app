import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Datos de ejemplo del usuario
  final Map<String, dynamic> _userProfile = {
    'name': 'Usuario Ejemplo',
    'email': 'usuario@example.com',
    'phone': '+51 999 999 999',
    'location': 'Lima, Perú',
    'memberSince': 'Enero 2024',
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(theme),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Información del perfil
                  Text(
                    "Información personal",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildInfoItem(
                    icon: Icons.phone,
                    title: "Teléfono",
                    value: _userProfile['phone'],
                    theme: theme,
                  ),
                  const SizedBox(height: 12),
                  _buildInfoItem(
                    icon: Icons.location_on,
                    title: "Ubicación",
                    value: _userProfile['location'],
                    theme: theme,
                  ),
                  const SizedBox(height: 32),

                  // Configuración
                  Text(
                    "Configuración",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 16),

                  _buildOptionItem(
                    icon: Icons.edit,
                    title: "Editar perfil",
                    subtitle: "Actualiza tu información personal",
                    onTap: () {},
                    theme: theme,
                  ),
                  _buildOptionItem(
                    icon: Icons.notifications,
                    title: "Notificaciones",
                    subtitle: "Configura tus preferencias",
                    onTap: () {},
                    theme: theme,
                  ),
                  _buildOptionItem(
                    icon: Icons.security,
                    title: "Privacidad y seguridad",
                    subtitle: "Administra tu cuenta",
                    onTap: () {},
                    theme: theme,
                  ),
                  _buildOptionItem(
                    icon: Icons.help,
                    title: "Ayuda y soporte",
                    subtitle: "¿Necesitas ayuda?",
                    onTap: () {},
                    theme: theme,
                  ),
                  _buildOptionItem(
                    icon: Icons.logout,
                    title: "Cerrar sesión",
                    subtitle: "Salir de la aplicación",
                    onTap: () {},
                    theme: theme,
                    isDestructive: true,
                  ),

                  const SizedBox(height: 100), // Espacio para navbar
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar(ThemeData theme) {
    return SliverAppBar(
      expandedHeight: 280,
      pinned: true,
      backgroundColor: theme.colorScheme.primary,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.primary,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.person,
                    size: 50,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  _userProfile['name'],
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  _userProfile['email'],
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Miembro desde ${_userProfile['memberSince']}",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ),
        collapseMode: CollapseMode.pin,
        titlePadding: EdgeInsets.zero,
        title: LayoutBuilder(
          builder: (context, constraints) {
            // Solo mostrar el título cuando el AppBar esté completamente colapsado
            final collapsedHeight = MediaQuery.of(context).padding.top + kToolbarHeight;
            final isCollapsed = constraints.biggest.height <= collapsedHeight + 10;

            return AnimatedOpacity(
              opacity: isCollapsed ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: Text(
                _userProfile['name'],
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            );
          },
        ),
        centerTitle: true,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.settings, color: Colors.white),
          tooltip: 'Configuración',
        ),
      ],
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String title,
    required String value,
    required ThemeData theme,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.primary.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: theme.colorScheme.primary,
            size: 24,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
                Text(
                  value,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required ThemeData theme,
    bool isDestructive = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: isDestructive ? BoxDecoration(
        color: const Color(0xFFf582ae),
        borderRadius: BorderRadius.circular(12),
      ) : null,
      child: ListTile(
        onTap: onTap,
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: (isDestructive
                ? Colors.white
                : theme.colorScheme.primary
            ).withOpacity(isDestructive ? 1.0 : 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: isDestructive
                ? const Color(0xFFf582ae)
                : theme.colorScheme.primary,
            size: 24,
          ),
        ),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: isDestructive
                ? Colors.white
                : theme.colorScheme.onSurface,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: isDestructive
                ? Colors.white.withOpacity(0.8)
                : theme.colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: isDestructive
              ? Colors.white.withOpacity(0.7)
              : theme.colorScheme.onSurface.withOpacity(0.4),
          size: 16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        tileColor: isDestructive ? Colors.transparent : theme.colorScheme.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }
}
