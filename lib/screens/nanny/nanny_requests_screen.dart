import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NannyRequestsScreen extends StatefulWidget {
  const NannyRequestsScreen({super.key});

  @override
  State<NannyRequestsScreen> createState() => _NannyRequestsScreenState();
}

class _NannyRequestsScreenState extends State<NannyRequestsScreen> {
  final List<Map<String, dynamic>> _requests = [
    {
      'id': '1',
      'familyName': 'Familia Mendoza',
      'parentName': 'Carlos Mendoza',
      'children': 2,
      'childrenAges': ['3 años', '6 años'],
      'date': '15 Oct 2024',
      'time': '3:00 PM - 7:00 PM',
      'duration': '4 horas',
      'rate': 'S/12/hora',
      'total': 'S/48',
      'location': 'San Isidro',
      'address': 'Av. Conquistadores 456',
      'serviceType': 'Cuidado diario',
      'description': 'Necesito cuidado para mis 2 hijos mientras trabajo. Son muy tranquilos y ya conocen rutinas.',
      'requirements': ['Experiencia con niños pequeños', 'Referencias verificables'],
      'status': 'pending', // pending, accepted, rejected
      'requestTime': '2 horas',
      'parentRating': 4.7,
      'urgency': 'normal', // urgent, normal
    },
    {
      'id': '2',
      'familyName': 'Familia García',
      'parentName': 'María García',
      'children': 1,
      'childrenAges': ['5 años'],
      'date': '16 Oct 2024',
      'time': '9:00 AM - 1:00 PM',
      'duration': '4 horas',
      'rate': 'S/15/hora',
      'total': 'S/60',
      'location': 'Miraflores',
      'address': 'Calle Las Flores 123',
      'serviceType': 'Emergencia',
      'description': 'Emergencia familiar, necesito niñera urgente para mañana en la mañana.',
      'requirements': ['Disponibilidad inmediata', 'Certificado de primeros auxilios'],
      'status': 'pending',
      'requestTime': '30 min',
      'parentRating': 4.9,
      'urgency': 'urgent',
    },
    {
      'id': '3',
      'familyName': 'Familia Rodríguez',
      'parentName': 'Ana Rodríguez',
      'children': 3,
      'childrenAges': ['2 años', '4 años', '7 años'],
      'date': '18 Oct 2024',
      'time': '6:00 PM - 10:00 PM',
      'duration': '4 horas',
      'rate': 'S/14/hora',
      'total': 'S/56',
      'location': 'San Borja',
      'address': 'Jr. San Luis 789',
      'serviceType': 'Fin de semana',
      'description': 'Salida de noche de los padres. Los niños cenarán antes, solo necesitan supervisión.',
      'requirements': ['Experiencia con múltiples niños', 'Disponibilidad nocturna'],
      'status': 'pending',
      'requestTime': '1 hora',
      'parentRating': 4.5,
      'urgency': 'normal',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'Solicitudes',
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
            onPressed: () {
              setState(() {
                // Simular actualización de solicitudes
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Actualizando solicitudes...')),
              );
            },
            icon: Icon(Icons.refresh, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        children: [
          // Header con estadísticas
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
                    _buildHeaderStat('${_requests.length}', 'Nuevas', Colors.white),
                    _buildHeaderStat('2', 'Urgentes', Colors.orange[100]!),
                    _buildHeaderStat('85%', 'Tasa aceptación', Colors.green[100]!),
                  ],
                ),
              ],
            ),
          ),

          // Lista de solicitudes
          Expanded(
            child: _requests.isEmpty
                ? _buildEmptyState(theme)
                : ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: _requests.length,
                    itemBuilder: (context, index) {
                      final request = _requests[index];
                      return _buildRequestCard(request, theme);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderStat(String value, String label, Color color) {
    return Column(
      children: [
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
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: color.withOpacity(0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox_outlined,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No hay solicitudes nuevas',
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          Text(
            'Las nuevas solicitudes aparecerán aquí',
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequestCard(Map<String, dynamic> request, ThemeData theme) {
    final isUrgent = request['urgency'] == 'urgent';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: isUrgent ? Border.all(color: Colors.orange, width: 2) : null,
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header de la tarjeta
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isUrgent ? Colors.orange[50] : theme.colorScheme.surfaceContainerHighest,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            request['familyName'],
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                          if (isUrgent) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                'URGENTE',
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.star, size: 14, color: Colors.amber),
                          const SizedBox(width: 4),
                          Text(
                            request['parentRating'].toString(),
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: theme.colorScheme.onSurface.withOpacity(0.7),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Icon(Icons.access_time, size: 14, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(
                            'Hace ${request['requestTime']}',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: theme.colorScheme.onSurface.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Text(
                  request['total'],
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),

          // Contenido de la tarjeta
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Información básica
                Row(
                  children: [
                    Expanded(
                      child: _buildInfoItem(
                        Icons.calendar_today,
                        'Fecha',
                        request['date'],
                        theme,
                      ),
                    ),
                    Expanded(
                      child: _buildInfoItem(
                        Icons.access_time,
                        'Horario',
                        request['time'],
                        theme,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(
                      child: _buildInfoItem(
                        Icons.child_care,
                        'Niños',
                        '${request['children']} (${request['childrenAges'].join(', ')})',
                        theme,
                      ),
                    ),
                    Expanded(
                      child: _buildInfoItem(
                        Icons.location_on,
                        'Ubicación',
                        request['location'],
                        theme,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Tipo de servicio
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.secondary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    request['serviceType'],
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.secondary,
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // Descripción
                Text(
                  request['description'],
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: theme.colorScheme.onSurface.withOpacity(0.8),
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 16),

                // Botones de acción
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => _handleReject(request['id']),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.red),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Rechazar',
                          style: GoogleFonts.poppins(
                            color: Colors.red,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _handleAccept(request),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Aceptar',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // Botón de más detalles
                const SizedBox(height: 8),
                Center(
                  child: TextButton(
                    onPressed: () => _showRequestDetails(request, theme),
                    child: Text(
                      'Ver más detalles',
                      style: GoogleFonts.poppins(
                        color: theme.colorScheme.primary,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String label, String value, ThemeData theme) {
    return Row(
      children: [
        Icon(icon, size: 16, color: theme.colorScheme.primary),
        const SizedBox(width: 6),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _handleAccept(Map<String, dynamic> request) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          '¿Aceptar solicitud?',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        content: Text(
          'Confirma que aceptas el trabajo con ${request['familyName']} el ${request['date']}.',
          style: GoogleFonts.poppins(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _requests.removeWhere((r) => r['id'] == request['id']);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Solicitud aceptada exitosamente'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: Text('Aceptar'),
          ),
        ],
      ),
    );
  }

  void _handleReject(String requestId) {
    setState(() {
      _requests.removeWhere((r) => r['id'] == requestId);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Solicitud rechazada'),
        backgroundColor: Colors.orange,
      ),
    );
  }

  void _showRequestDetails(Map<String, dynamic> request, ThemeData theme) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
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
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Detalles de la solicitud',
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
                    Text('Dirección completa: ${request['address']}'),
                    const SizedBox(height: 12),
                    Text('Requisitos:'),
                    ...request['requirements'].map<Widget>((req) =>
                      Padding(
                        padding: const EdgeInsets.only(left: 16, top: 4),
                        child: Row(
                          children: [
                            Icon(Icons.check_circle_outline, size: 16),
                            const SizedBox(width: 8),
                            Expanded(child: Text(req)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
