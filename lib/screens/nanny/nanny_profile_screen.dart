import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_theme.dart';

class NannyProfileScreen extends StatefulWidget {
  const NannyProfileScreen({super.key});

  @override
  State<NannyProfileScreen> createState() => _NannyProfileScreenState();
}

class _NannyProfileScreenState extends State<NannyProfileScreen> {
  final List<Map<String, dynamic>> _reviews = [
    {
      'parentName': 'Ana García',
      'rating': 5.0,
      'comment': 'Excelente cuidadora, muy responsable y cariñosa con mis hijos.',
      'date': '15 Oct 2024',
      'children': 2,
    },
    {
      'parentName': 'Carlos Mendoza',
      'rating': 5.0,
      'comment': 'María es increíble, siempre puntual y los niños la adoran.',
      'date': '12 Oct 2024',
      'children': 1,
    },
    {
      'parentName': 'Laura Torres',
      'rating': 4.0,
      'comment': 'Muy buena experiencia, recomendada al 100%.',
      'date': '8 Oct 2024',
      'children': 3,
    },
  ];

  final List<String> _specialties = [
    'Cuidado de bebés (0-2 años)',
    'Actividades educativas',
    'Ayuda con tareas',
    'Primeros auxilios',
    'Cocina básica',
    'Cuidado nocturno',
  ];

  final List<String> _languages = ['Español', 'Inglés básico'];

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
                  _buildStatsSection(theme),
                  const SizedBox(height: 24),
                  _buildAboutSection(theme),
                  const SizedBox(height: 24),
                  _buildSpecialtiesSection(theme),
                  const SizedBox(height: 24),
                  _buildCertificationsSection(theme),
                  const SizedBox(height: 24),
                  _buildReviewsSection(theme),
                  const SizedBox(height: 24),
                  _buildSettingsSection(theme),
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
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                theme.colorScheme.primary,
                theme.colorScheme.primary.withValues(alpha: 0.8),
              ],
            ),
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
                        color: Colors.black.withValues(alpha: 0.1),
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
                  'María Elena Rodríguez',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Niñera profesional certificada',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 20),
                    const SizedBox(width: 4),
                    Text(
                      '4.9',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      ' (127 reseñas)',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                    ),
                  ],
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
                'María Elena Rodríguez',
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
          onPressed: () => _showEditProfile(),
          icon: const Icon(Icons.edit, color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildStatsSection(ThemeData theme) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard('3 años', 'Experiencia', Icons.work_outline, theme),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard('247', 'Trabajos\ncompletados', Icons.check_circle_outline, theme),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard('98%', 'Satisfacción', Icons.thumb_up_outlined, theme),
        ),
      ],
    );
  }

  Widget _buildStatCard(String value, String label, IconData icon, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: theme.colorScheme.primary, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 10,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSection(ThemeData theme) {
    return _buildSection(
      'Acerca de mí',
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Soy una niñera profesional con más de 3 años de experiencia cuidando niños de todas las edades. Me especializo en actividades educativas y recreativas que ayudan al desarrollo integral de los pequeños.',
            style: GoogleFonts.poppins(
              fontSize: 14,
              height: 1.5,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _languages.map((language) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppTheme.rosaClaro,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                language,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: theme.colorScheme.secondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )).toList(),
          ),
        ],
      ),
      theme,
    );
  }

  Widget _buildSpecialtiesSection(ThemeData theme) {
    return _buildSection(
      'Especialidades',
      Wrap(
        spacing: 8,
        runSpacing: 8,
        children: _specialties.map((specialty) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: theme.colorScheme.primary.withValues(alpha: 0.3),
            ),
          ),
          child: Text(
            specialty,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
        )).toList(),
      ),
      theme,
    );
  }

  Widget _buildCertificationsSection(ThemeData theme) {
    final certifications = [
      {
        'title': 'Primeros Auxilios Pediátricos',
        'institution': 'Cruz Roja Peruana',
        'date': 'Válido hasta Dic 2025',
        'verified': true,
      },
      {
        'title': 'Certificación en Cuidado Infantil',
        'institution': 'Instituto de Cuidado Infantil',
        'date': 'Obtenido en Mar 2022',
        'verified': true,
      },
      {
        'title': 'Curso de Estimulación Temprana',
        'institution': 'Universidad Cayetano Heredia',
        'date': 'Obtenido en Ene 2023',
        'verified': false,
      },
    ];

    return _buildSection(
      'Certificaciones',
      Column(
        children: certifications.map((cert) {
          final isVerified = cert['verified'] as bool;
          final title = cert['title'] as String;
          final institution = cert['institution'] as String;
          final date = cert['date'] as String;

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: theme.colorScheme.outline.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: isVerified
                      ? theme.colorScheme.primary.withValues(alpha: 0.1)
                      : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    isVerified ? Icons.verified : Icons.school,
                    color: isVerified
                      ? theme.colorScheme.primary
                      : Colors.grey.shade600,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      Text(
                        institution,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                        ),
                      ),
                      Text(
                        date,
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                        ),
                      ),
                    ],
                  ),
                ),
                if (isVerified)
                  Icon(
                    Icons.check_circle,
                    color: theme.colorScheme.primary,
                    size: 20,
                  ),
              ],
            ),
          );
        }).toList(),
      ),
      theme,
    );
  }

  Widget _buildReviewsSection(ThemeData theme) {
    return _buildSection(
      'Reseñas recientes',
      Column(
        children: [
          ..._reviews.take(3).map((review) => Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: theme.colorScheme.outline.withValues(alpha: 0.3),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      review['parentName'],
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    Row(
                      children: List.generate(5, (index) => Icon(
                        Icons.star,
                        size: 16,
                        color: index < review['rating']
                          ? Colors.amber
                          : Colors.grey.shade300,
                      )),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  review['comment'],
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    height: 1.4,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${review['date']} • ${review['children']} niño${review['children'] > 1 ? 's' : ''}',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                ),
              ],
            ),
          )).toList(),
          TextButton(
            onPressed: () {},
            child: Text(
              'Ver todas las reseñas (127)',
              style: GoogleFonts.poppins(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      theme,
    );
  }

  Widget _buildSettingsSection(ThemeData theme) {
    final settingsItems = [
      {
        'title': 'Configurar disponibilidad',
        'subtitle': 'Horarios y días disponibles',
        'icon': Icons.schedule,
        'onTap': () {},
      },
      {
        'title': 'Tarifas y pagos',
        'subtitle': 'Configurar precios por hora',
        'icon': Icons.payment,
        'onTap': () {},
      },
      {
        'title': 'Notificaciones',
        'subtitle': 'Alertas y recordatorios',
        'icon': Icons.notifications,
        'onTap': () {},
      },
      {
        'title': 'Verificación de identidad',
        'subtitle': 'Documentos y antecedentes',
        'icon': Icons.verified_user,
        'onTap': () {},
      },
      {
        'title': 'Ayuda y soporte',
        'subtitle': 'Contactar con KidyCare',
        'icon': Icons.help,
        'onTap': () {},
      },
      {
        'title': 'Cerrar sesión',
        'subtitle': 'Salir de la aplicación',
        'icon': Icons.logout,
        'onTap': () {},
        'isDestructive': true,
      },
    ];

    return _buildSection(
      'Configuración',
      Column(
        children: settingsItems.map((item) {
          final isDestructive = item['isDestructive'] as bool? ?? false;

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: isDestructive ? BoxDecoration(
              color: const Color(0xFFf582ae),
              borderRadius: BorderRadius.circular(12),
            ) : null,
            child: ListTile(
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: (isDestructive
                    ? Colors.white
                    : theme.colorScheme.primary
                  ).withValues(alpha: isDestructive ? 1.0 : 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  item['icon'] as IconData,
                  color: isDestructive
                    ? const Color(0xFFf582ae)
                    : theme.colorScheme.primary,
                  size: 20,
                ),
              ),
              title: Text(
                item['title'] as String,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  color: isDestructive
                    ? Colors.white
                    : theme.colorScheme.onSurface,
                ),
              ),
              subtitle: Text(
                item['subtitle'] as String,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: isDestructive
                    ? Colors.white.withValues(alpha: 0.8)
                    : theme.colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: isDestructive
                  ? Colors.white.withValues(alpha: 0.7)
                  : theme.colorScheme.onSurface.withValues(alpha: 0.4),
              ),
              onTap: item['onTap'] as VoidCallback,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              tileColor: isDestructive ? Colors.transparent : null,
            ),
          );
        }).toList(),
      ),
      theme,
    );
  }

  Widget _buildSection(String title, Widget content, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 12),
        content,
      ],
    );
  }

  void _showEditProfile() {
    // Implementar edición de perfil
  }
}
