import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NannyEarningsScreen extends StatefulWidget {
  const NannyEarningsScreen({super.key});

  @override
  State<NannyEarningsScreen> createState() => _NannyEarningsScreenState();
}

class _NannyEarningsScreenState extends State<NannyEarningsScreen> {
  String _selectedPeriod = 'Este mes';
  final List<String> _periods = ['Esta semana', 'Este mes', 'Últimos 3 meses', 'Este año'];

  final Map<String, Map<String, dynamic>> _earningsData = {
    'Esta semana': {
      'total': 168.0,
      'trabajos': 4,
      'horas': 14,
      'promedio': 12.0,
      'cambio': 12.5,
    },
    'Este mes': {
      'total': 720.0,
      'trabajos': 15,
      'horas': 60,
      'promedio': 12.0,
      'cambio': 8.2,
    },
    'Últimos 3 meses': {
      'total': 2160.0,
      'trabajos': 45,
      'horas': 180,
      'promedio': 12.0,
      'cambio': 15.3,
    },
    'Este año': {
      'total': 8640.0,
      'trabajos': 180,
      'horas': 720,
      'promedio': 12.0,
      'cambio': 22.1,
    },
  };

  final List<Map<String, dynamic>> _recentPayments = [
    {
      'family': 'Familia Mendoza',
      'date': '15 Oct 2024',
      'hours': 4,
      'rate': 12.0,
      'amount': 48.0,
      'status': 'paid',
      'method': 'Transferencia',
    },
    {
      'family': 'Familia García',
      'date': '14 Oct 2024',
      'hours': 3,
      'rate': 15.0,
      'amount': 45.0,
      'status': 'paid',
      'method': 'Efectivo',
    },
    {
      'family': 'Familia Rodríguez',
      'date': '13 Oct 2024',
      'hours': 5,
      'rate': 12.0,
      'amount': 60.0,
      'status': 'pending',
      'method': 'Yape',
    },
    {
      'family': 'Familia Torres',
      'date': '12 Oct 2024',
      'hours': 4,
      'rate': 14.0,
      'amount': 56.0,
      'status': 'paid',
      'method': 'Plin',
    },
    {
      'family': 'Familia López',
      'date': '11 Oct 2024',
      'hours': 6,
      'rate': 12.0,
      'amount': 72.0,
      'status': 'paid',
      'method': 'Transferencia',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentData = _earningsData[_selectedPeriod]!;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'Mis Ganancias',
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
            onPressed: () => _showEarningsReport(theme),
            icon: Icon(Icons.download, color: Colors.white),
            tooltip: 'Descargar reporte',
          ),
        ],
      ),
      body: Column(
        children: [
          // Header con selector de período
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
                // Selector de período
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedPeriod,
                      items: _periods.map((period) {
                        return DropdownMenuItem(
                          value: period,
                          child: Text(
                            period,
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedPeriod = value!;
                        });
                      },
                      dropdownColor: theme.colorScheme.primary,
                      icon: Icon(Icons.keyboard_arrow_down, color: Colors.white),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Total ganado
                Text(
                  'S/${currentData['total'].toStringAsFixed(0)}',
                  style: GoogleFonts.poppins(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      currentData['cambio'] > 0 ? Icons.trending_up : Icons.trending_down,
                      color: currentData['cambio'] > 0 ? Colors.green[300] : Colors.red[300],
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${currentData['cambio'].toStringAsFixed(1)}% vs período anterior',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Estadísticas rápidas
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    '${currentData['trabajos']}',
                    'Trabajos completados',
                    Icons.work,
                    theme.colorScheme.primary,
                    theme,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    '${currentData['horas']}h',
                    'Horas trabajadas',
                    Icons.access_time,
                    theme.colorScheme.secondary,
                    theme,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    'S/${currentData['promedio'].toStringAsFixed(0)}',
                    'Tarifa promedio',
                    Icons.monetization_on,
                    Colors.green,
                    theme,
                  ),
                ),
              ],
            ),
          ),

          // Métodos de pago más usados
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Métodos de pago populares',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                TextButton(
                  onPressed: () => _showPaymentMethods(theme),
                  child: Text('Configurar'),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(child: _buildPaymentMethodCard('Yape', '45%', Colors.purple, theme)),
                const SizedBox(width: 8),
                Expanded(child: _buildPaymentMethodCard('Plin', '30%', Colors.blue, theme)),
                const SizedBox(width: 8),
                Expanded(child: _buildPaymentMethodCard('Efectivo', '25%', Colors.green, theme)),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Lista de pagos recientes
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Pagos recientes',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      TextButton(
                        onPressed: () => _showAllPayments(theme),
                        child: Text('Ver todos'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _recentPayments.length,
                      itemBuilder: (context, index) {
                        final payment = _recentPayments[index];
                        return _buildPaymentCard(payment, theme);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
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
            color: theme.colorScheme.primary.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 10,
              color: theme.colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodCard(String method, String percentage, Color color, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Text(
            method,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            percentage,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentCard(Map<String, dynamic> payment, ThemeData theme) {
    final isPaid = payment['status'] == 'paid';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isPaid ? Colors.green.withOpacity(0.3) : Colors.orange.withOpacity(0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 50,
            decoration: BoxDecoration(
              color: isPaid ? Colors.green : Colors.orange,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        payment['family'],
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                    ),
                    Text(
                      'S/${payment['amount'].toStringAsFixed(0)}',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isPaid ? Colors.green : Colors.orange,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      payment['date'],
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: theme.colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '• ${payment['hours']}h',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: theme.colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '• ${payment['method']}',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: theme.colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: isPaid ? Colors.green[100] : Colors.orange[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    isPaid ? 'Pagado' : 'Pendiente',
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: isPaid ? Colors.green[700] : Colors.orange[700],
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (!isPaid)
            IconButton(
              onPressed: () => _sendPaymentReminder(payment),
              icon: Icon(Icons.notification_important, color: Colors.orange),
              tooltip: 'Recordar pago',
            ),
        ],
      ),
    );
  }

  void _showEarningsReport(ThemeData theme) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Descargar reporte',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        content: Text(
          'Selecciona el formato para descargar tu reporte de ganancias.',
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
                SnackBar(content: Text('Descargando reporte en PDF...')),
              );
            },
            child: Text('Descargar PDF'),
          ),
        ],
      ),
    );
  }

  void _showPaymentMethods(ThemeData theme) {
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
              'Métodos de pago',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.account_balance),
              title: Text('Cuenta bancaria'),
              subtitle: Text('BCP - ****1234'),
              trailing: Icon(Icons.edit),
            ),
            ListTile(
              leading: Icon(Icons.phone_android),
              title: Text('Yape'),
              subtitle: Text('+51 987 654 321'),
              trailing: Icon(Icons.edit),
            ),
            ListTile(
              leading: Icon(Icons.phone_android),
              title: Text('Plin'),
              subtitle: Text('+51 987 654 321'),
              trailing: Icon(Icons.edit),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Añadir nuevo método de pago')),
                  );
                },
                child: Text('Añadir método de pago'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAllPayments(ThemeData theme) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Mostrando historial completo de pagos')),
    );
  }

  void _sendPaymentReminder(Map<String, dynamic> payment) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Recordatorio enviado a ${payment['family']}'),
        backgroundColor: Colors.orange,
      ),
    );
  }
}
