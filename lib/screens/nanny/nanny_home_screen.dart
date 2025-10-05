import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_theme.dart';
import '../../widgets/nanny_glass_navbar.dart';
import 'nanny_calendar_screen.dart';
import 'nanny_earnings_screen.dart';
import 'nanny_profile_screen.dart';

class NannyHomeScreen extends StatefulWidget {
  const NannyHomeScreen({super.key});

  @override
  State<NannyHomeScreen> createState() => _NannyHomeScreenState();
}

class _NannyHomeScreenState extends State<NannyHomeScreen> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _todayAppointments = [
    {
      'family': 'Familia Mendoza',
      'time': '15:00 - 19:00',
      'children': 2,
      'ages': '3 y 5 años',
      'location': 'San Isidro',
      'payment': 'S/48',
      'distance': '2.5 km',
      'status': 'confirmed',
    },
    {
      'family': 'Familia García',
      'time': '20:00 - 23:00',
      'children': 1,
      'ages': '7 años',
      'location': 'Miraflores',
      'payment': 'S/45',
      'distance': '1.8 km',
      'status': 'pending',
    },
  ];

  final List<Map<String, dynamic>> _newRequests = [
    {
      'family': 'Familia López',
      'date': 'Mañana',
      'time': '14:00 - 18:00',
      'children': 3,
      'ages': '2, 4 y 8 años',
      'location': 'La Molina',
      'payment': 'S/56',
      'type': 'Cuidado + Tareas',
      'priority': 'high',
    },
  ];

  Widget _buildHomePage() {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refreshData,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(theme),
                const SizedBox(height: 24),
                _buildQuickStats(theme),
                const SizedBox(height: 24),
                _buildTodaySection(theme),
                const SizedBox(height: 24),
                _buildNewRequestsSection(theme),
                const SizedBox(height: 80), // Espacio para el navbar
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Método para obtener las páginas dinámicamente
  List<Widget> get _pages => [
    _buildHomePage(),
    const NannyCalendarScreen(),
    const NannyEarningsScreen(),
    const NannyProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _pages[_selectedIndex],
      bottomNavigationBar: NannyGlassNavbar(
        selectedIndex: _selectedIndex,
        onItemSelected: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    final bool isVerified = true; // En una app real, esto vendría de la base de datos

    return Row(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1),
          child: Icon(
            Icons.person,
            color: theme.colorScheme.primary,
            size: 28,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '¡Hola, María!',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              Row(
                children: [
                  if (isVerified) ...[
                    Icon(
                      Icons.verified,
                      color: theme.colorScheme.primary,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Niñera verificada',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ] else ...[
                    Icon(
                      Icons.info_outline,
                      color: Colors.orange,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Completar verificación',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                  const SizedBox(width: 8),
                  Text(
                    '⭐ 4.9',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.notifications_outlined,
            color: theme.colorScheme.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickStats(ThemeData theme) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            '12',
            'Trabajos\neste mes',
            Icons.work_outline,
            theme.colorScheme.primary,
            theme,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            'S/720',
            'Ingresos\neste mes',
            Icons.account_balance_wallet_outlined,
            theme.colorScheme.secondary,
            theme,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            '4.9',
            'Calificación\npromedio',
            Icons.star_outline,
            AppTheme.azulMarino,
            theme,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String value, String label, IconData icon, Color color, ThemeData theme) {
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
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
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

  Widget _buildTodaySection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Trabajos de hoy',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'Ver todos',
                style: GoogleFonts.poppins(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _todayAppointments.isEmpty
            ? _buildEmptyState('No tienes trabajos programados para hoy', Icons.event_available)
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _todayAppointments.length,
                itemBuilder: (context, index) {
                  return _buildAppointmentCard(_todayAppointments[index], theme);
                },
              ),
      ],
    );
  }

  Widget _buildNewRequestsSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Nuevas solicitudes',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: theme.colorScheme.secondary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${_newRequests.length}',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _newRequests.isEmpty
            ? _buildEmptyState('No hay solicitudes pendientes', Icons.inbox_outlined)
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _newRequests.length,
                itemBuilder: (context, index) {
                  return _buildRequestCard(_newRequests[index], theme);
                },
              ),
      ],
    );
  }

  Widget _buildAppointmentCard(Map<String, dynamic> appointment, ThemeData theme) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                appointment['family'],
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: appointment['status'] == 'confirmed'
                    ? AppTheme.rosaClaro
                    : Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  appointment['status'] == 'confirmed' ? 'Confirmado' : 'Pendiente',
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: appointment['status'] == 'confirmed'
                      ? theme.colorScheme.secondary
                      : Colors.orange.shade700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.access_time, size: 16, color: theme.colorScheme.primary),
              const SizedBox(width: 6),
              Text(
                appointment['time'],
                style: GoogleFonts.poppins(fontSize: 14),
              ),
              const SizedBox(width: 16),
              Icon(Icons.child_care, size: 16, color: theme.colorScheme.secondary),
              const SizedBox(width: 6),
              Text(
                '${appointment['children']} niños (${appointment['ages']})',
                style: GoogleFonts.poppins(fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.location_on, size: 16, color: theme.colorScheme.outline),
                  const SizedBox(width: 6),
                  Text(
                    '${appointment['location']} • ${appointment['distance']}',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
              Text(
                appointment['payment'],
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRequestCard(Map<String, dynamic> request, ThemeData theme) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: request['priority'] == 'high'
            ? theme.colorScheme.secondary.withValues(alpha: 0.3)
            : theme.colorScheme.outline,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                request['family'],
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              if (request['priority'] == 'high')
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.secondary,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'URGENTE',
                    style: GoogleFonts.poppins(
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '${request['date']} • ${request['time']}',
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${request['children']} niños (${request['ages']}) • ${request['type']}',
            style: GoogleFonts.poppins(fontSize: 14),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                request['location'],
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
              Text(
                request['payment'],
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: theme.colorScheme.outline),
                  ),
                  child: Text(
                    'Rechazar',
                    style: GoogleFonts.poppins(
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'Aceptar',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(String message, IconData icon) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Icon(
            icon,
            size: 48,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: Colors.grey.shade600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _refreshData() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      // Aquí actualizarías los datos reales
    });
  }
}
