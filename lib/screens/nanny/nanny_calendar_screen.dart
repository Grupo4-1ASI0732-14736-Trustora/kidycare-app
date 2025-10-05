import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_theme.dart';

class NannyCalendarScreen extends StatefulWidget {
  const NannyCalendarScreen({super.key});

  @override
  State<NannyCalendarScreen> createState() => _NannyCalendarScreenState();
}

class _NannyCalendarScreenState extends State<NannyCalendarScreen> {
  DateTime _selectedDate = DateTime.now();

  final Map<DateTime, List<Map<String, dynamic>>> _appointments = {
    DateTime(2024, 10, 15): [
      {
        'id': '1',
        'family': 'Familia Mendoza',
        'time': '15:00 - 19:00',
        'children': 2,
        'location': 'San Isidro',
        'type': 'Cuidado diario',
        'payment': 'S/48',
        'status': 'confirmed',
      },
    ],
    DateTime(2024, 10, 16): [
      {
        'id': '2',
        'family': 'Familia García',
        'time': '09:00 - 13:00',
        'children': 1,
        'location': 'Miraflores',
        'type': 'Emergencia',
        'payment': 'S/60',
        'status': 'confirmed',
      },
    ],
    DateTime(2024, 10, 18): [
      {
        'id': '3',
        'family': 'Familia Rodríguez',
        'time': '18:00 - 22:00',
        'children': 3,
        'location': 'San Borja',
        'type': 'Fin de semana',
        'payment': 'S/56',
        'status': 'pending',
      },
    ],
    DateTime(2024, 10, 20): [
      {
        'id': '4',
        'family': 'Familia Torres',
        'time': '08:00 - 12:00',
        'children': 1,
        'location': 'Surco',
        'type': 'Cuidado diario',
        'payment': 'S/48',
        'status': 'confirmed',
      },
      {
        'id': '5',
        'family': 'Familia López',
        'time': '14:00 - 18:00',
        'children': 2,
        'location': 'La Molina',
        'type': 'Actividades educativas',
        'payment': 'S/64',
        'status': 'confirmed',
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'Mi Calendario',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: theme.colorScheme.primary,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => _showAvailabilitySettings(theme),
            icon: Icon(Icons.settings, color: Colors.white),
            tooltip: 'Configurar disponibilidad',
          ),
        ],
      ),
      body: Column(
        children: [
          // Header con estadísticas del mes
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
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatItem('12', 'Trabajos\neste mes', Colors.white),
                    _buildStatItem('48h', 'Horas\ntrabajadas', Colors.white),
                    _buildStatItem('S/720', 'Ingresos\neste mes', Colors.white),
                  ],
                ),
              ],
            ),
          ),

          // Calendario mensual compacto
          Container(
            padding: const EdgeInsets.all(20),
            child: _buildCalendarGrid(theme),
          ),

          // Lista de citas del día seleccionado
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _formatSelectedDate(),
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: _buildAppointmentsList(theme),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showBlockTimeDialog(theme),
        backgroundColor: theme.colorScheme.secondary,
        child: Icon(Icons.block, color: Colors.white),
        tooltip: 'Bloquear horario',
      ),
    );
  }

  Widget _buildStatItem(String value, String label, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 10,
            color: color.withValues(alpha: 0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildCalendarGrid(ThemeData theme) {
    final now = DateTime.now();
    final firstDayOfMonth = DateTime(now.year, now.month, 1);
    final startDate = firstDayOfMonth.subtract(Duration(days: firstDayOfMonth.weekday - 1));

    return Column(
      children: [
        // Header con días de la semana
        Row(
          children: ['L', 'M', 'X', 'J', 'V', 'S', 'D'].map((day) {
            return Expanded(
              child: Center(
                child: Text(
                  day,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 8),

        // Grid de días
        ...List.generate(6, (weekIndex) {
          return Row(
            children: List.generate(7, (dayIndex) {
              final date = startDate.add(Duration(days: weekIndex * 7 + dayIndex));
              final isCurrentMonth = date.month == now.month;
              final isToday = _isSameDay(date, now);
              final isSelected = _isSameDay(date, _selectedDate);
              final hasAppointments = _appointments.containsKey(DateTime(date.year, date.month, date.day));

              return Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _selectedDate = date),
                  child: Container(
                    margin: const EdgeInsets.all(2),
                    height: 40,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? theme.colorScheme.primary
                          : isToday
                              ? theme.colorScheme.primary.withValues(alpha: 0.1)
                              : null,
                      borderRadius: BorderRadius.circular(8),
                      border: hasAppointments && !isSelected
                          ? Border.all(color: theme.colorScheme.secondary, width: 1)
                          : null,
                    ),
                    child: Center(
                      child: Text(
                        date.day.toString(),
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: isSelected
                              ? Colors.white
                              : isCurrentMonth
                                  ? theme.colorScheme.onSurface
                                  : theme.colorScheme.onSurface.withValues(alpha: 0.3),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          );
        }),
      ],
    );
  }

  Widget _buildAppointmentsList(ThemeData theme) {
    final selectedDateKey = DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day);
    final appointments = _appointments[selectedDateKey] ?? [];

    if (appointments.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.free_breakfast,
              size: 48,
              color: AppTheme.azulMarino.withValues(alpha: 0.4),
            ),
            const SizedBox(height: 16),
            Text(
              'No hay citas programadas',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: AppTheme.azulMarino.withValues(alpha: 0.6),
              ),
            ),
            Text(
              'Disfruta tu día libre',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: AppTheme.azulMarino.withValues(alpha: 0.5),
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        final appointment = appointments[index];
        return _buildAppointmentCard(appointment, theme);
      },
    );
  }

  Widget _buildAppointmentCard(Map<String, dynamic> appointment, ThemeData theme) {
    final isConfirmed = appointment['status'] == 'confirmed';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isConfirmed ? theme.colorScheme.primary : theme.colorScheme.secondary,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appointment['family'],
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.access_time, size: 14, color: theme.colorScheme.primary),
                        const SizedBox(width: 4),
                        Text(
                          appointment['time'],
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    appointment['payment'],
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: isConfirmed ? AppTheme.rosaClaro : AppTheme.rosaClaro.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      isConfirmed ? 'Confirmado' : 'Pendiente',
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.secondary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Icon(Icons.child_care, size: 14, color: theme.colorScheme.onSurface.withValues(alpha: 0.6)),
              const SizedBox(width: 4),
              Text(
                '${appointment['children']} ${appointment['children'] == 1 ? 'niño' : 'niños'}',
                style: GoogleFonts.poppins(fontSize: 12, color: theme.colorScheme.onSurface.withValues(alpha: 0.6)),
              ),
              const SizedBox(width: 16),
              Icon(Icons.location_on, size: 14, color: theme.colorScheme.onSurface.withValues(alpha: 0.6)),
              const SizedBox(width: 4),
              Text(
                appointment['location'],
                style: GoogleFonts.poppins(fontSize: 12, color: theme.colorScheme.onSurface.withValues(alpha: 0.6)),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: theme.colorScheme.secondary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              appointment['type'],
              style: GoogleFonts.poppins(
                fontSize: 11,
                color: theme.colorScheme.secondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _showAppointmentDetails(appointment, theme),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: theme.colorScheme.primary),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text(
                    'Ver detalles',
                    style: GoogleFonts.poppins(
                      color: theme.colorScheme.primary,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => _contactFamily(appointment),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text(
                    'Contactar',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 12,
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

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }

  String _formatSelectedDate() {
    final months = [
      'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
      'Juli', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'
    ];

    final weekdays = [
      'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo'
    ];

    return '${weekdays[_selectedDate.weekday - 1]}, ${_selectedDate.day} de ${months[_selectedDate.month - 1]}';
  }

  void _showAvailabilitySettings(ThemeData theme) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Configurar disponibilidad',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.schedule),
              title: Text('Horarios de trabajo'),
              subtitle: Text('Lun-Vie: 8:00-18:00, Sáb: 9:00-15:00'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Configurar horarios de trabajo')),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.block),
              title: Text('Días no disponibles'),
              subtitle: Text('Bloquear fechas específicas'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pop(context);
                _showBlockTimeDialog(theme);
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Recordatorios'),
              subtitle: Text('Configurar notificaciones'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Configurar recordatorios')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showBlockTimeDialog(ThemeData theme) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Bloquear horario',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        content: Text(
          'Selecciona el día y horario que deseas bloquear para no recibir solicitudes.',
          style: GoogleFonts.poppins(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Horario bloqueado exitosamente')),
              );
            },
            child: Text('Bloquear'),
          ),
        ],
      ),
    );
  }

  void _showAppointmentDetails(Map<String, dynamic> appointment, ThemeData theme) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        maxChildSize: 0.8,
        minChildSize: 0.4,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppTheme.azulMarino.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Detalles de la cita',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  children: [
                    Text('Familia: ${appointment['family']}'),
                    const SizedBox(height: 8),
                    Text('Horario: ${appointment['time']}'),
                    const SizedBox(height: 8),
                    Text('Ubicación: ${appointment['location']}'),
                    const SizedBox(height: 8),
                    Text('Tipo de servicio: ${appointment['type']}'),
                    const SizedBox(height: 8),
                    Text('Pago: ${appointment['payment']}'),
                    const SizedBox(height: 8),
                    Text('Estado: ${appointment['status'] == 'confirmed' ? 'Confirmado' : 'Pendiente'}'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _contactFamily(Map<String, dynamic> appointment) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Contactando a ${appointment['family']}')),
    );
  }
}
