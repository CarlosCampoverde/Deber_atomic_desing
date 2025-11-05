import 'package:flutter/material.dart';
import 'design_system/template/templates.dart';
import 'design_system/Organismo/match_list.dart';
import 'design_system/Organismo/mach_tiked_selector.dart';
import 'design_system/Organismo/seat_selection_summary.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sistema de Tickets - Atomic Design',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MatchesHomePage(),
    );
  }
}

/// Página principal que muestra la lista de partidos
/// Usa el template MatchesHomeTemplate
class MatchesHomePage extends StatelessWidget {
  const MatchesHomePage({super.key});

  // Datos de ejemplo para los partidos
  List<MatchData> get _sampleMatches => [
    MatchData(
      homeTeam: 'Barcelona',
      awayTeam: 'Emelec',
      homeColor: Colors.yellow,
      awayColor: Colors.blue,
      date: '15 de Marzo, 2024',
      stadium: 'Estadio Monumental',
      status: 'Disponible',
      statusColor: Colors.green,
      id: '1',
    ),
    MatchData(
      homeTeam: 'Liga de Quito',
      awayTeam: 'Independiente',
      homeColor: Colors.white,
      awayColor: Colors.red,
      date: '20 de Marzo, 2024',
      stadium: 'Estadio Rodrigo Paz',
      status: 'Disponible',
      statusColor: Colors.green,
      id: '2',
    ),
    MatchData(
      homeTeam: 'Universidad Católica',
      awayTeam: 'Deportivo Cuenca',
      homeColor: Colors.blue.shade900,
      awayColor: Colors.orange,
      date: '25 de Marzo, 2024',
      stadium: 'Estadio Olímpico Atahualpa',
      status: 'Agotado',
      statusColor: Colors.red,
      id: '3',
    ),
  ];

  void _onMatchSelected(BuildContext context, MatchData match) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TicketSelectionPage(match: match),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MatchesHomeTemplate(
      matches: _sampleMatches,
      title: ' Partidos Disponibles',
      onMatchSelected: (match) => _onMatchSelected(context, match),
    );
  }
}

/// Página de selección de tickets
/// Usa el template TicketSelectionTemplate
class TicketSelectionPage extends StatefulWidget {
  final MatchData match;

  const TicketSelectionPage({
    super.key,
    required this.match,
  });

  @override
  State<TicketSelectionPage> createState() => _TicketSelectionPageState();
}

class _TicketSelectionPageState extends State<TicketSelectionPage> {
  Map<String, int> _selectedSeats = {};

  // Zonas de asientos disponibles
  List<SeatZoneData> get _seatZones => [
    SeatZoneData(zone: 'General', price: 20.0),
    SeatZoneData(zone: 'Preferencial', price: 35.0),
    SeatZoneData(zone: 'VIP', price: 60.0),
    SeatZoneData(zone: 'Plata', price: 45.0),
  ];

  void _onSelectionChanged(Map<String, int> selections) {
    setState(() {
      _selectedSeats = selections;
    });
  }

  void _onContinue() {
    // Convertir las selecciones al formato de SeatSummaryData
    Map<String, SeatSummaryData> summaryData = {};
    
    for (var zoneData in _seatZones) {
      final count = _selectedSeats[zoneData.zone] ?? 0;
      if (count > 0) {
        summaryData[zoneData.zone] = SeatSummaryData(
          quantity: count,
          price: zoneData.price,
        );
      }
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CheckoutPage(
          match: widget.match,
          selections: summaryData,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TicketSelectionTemplate(
      homeTeam: widget.match.homeTeam,
      awayTeam: widget.match.awayTeam,
      homeColor: widget.match.homeColor,
      awayColor: widget.match.awayColor,
      date: widget.match.date,
      stadium: widget.match.stadium,
      status: widget.match.status,
      statusColor: widget.match.statusColor,
      seatZones: _seatZones,
      onSelectionChanged: _onSelectionChanged,
      onContinue: _onContinue,
    );
  }
}

/// Página de checkout/resumen final
/// Usa el template CheckoutTemplate
class CheckoutPage extends StatelessWidget {
  final MatchData match;
  final Map<String, SeatSummaryData> selections;

  const CheckoutPage({
    super.key,
    required this.match,
    required this.selections,
  });

  void _onEdit(BuildContext context) {
    Navigator.pop(context);
  }

  void _onConfirm(BuildContext context) {
    // Calcular total
    double total = selections.values.fold(
      0.0,
      (sum, data) => sum + (data.price * data.quantity),
    );

    // Mostrar diálogo de confirmación
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('¡Compra Exitosa!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Partido: ${match.homeTeam} vs ${match.awayTeam}'),
            Text('Fecha: ${match.date}'),
            const SizedBox(height: 8),
            Text(
              'Total pagado: \$${total.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Tu compra ha sido procesada exitosamente. '
              'Recibirás un email con los detalles de tus tickets.',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Cerrar diálogo
              Navigator.of(context).popUntil((route) => route.isFirst); // Volver al inicio
            },
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }

  Widget _buildMatchInfo() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Información del Partido',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: match.homeColor,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          match.homeTeam[0].toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      match.homeTeam,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const Text('VS', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Column(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: match.awayColor,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          match.awayTeam[0].toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      match.awayTeam,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 16, color: Colors.grey.shade600),
                const SizedBox(width: 8),
                Text(match.date, style: TextStyle(color: Colors.grey.shade700)),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.location_on, size: 16, color: Colors.grey.shade600),
                const SizedBox(width: 8),
                Text(match.stadium, style: TextStyle(color: Colors.grey.shade700)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CheckoutTemplate(
      selections: selections,
      matchInfo: _buildMatchInfo(),
      onEdit: () => _onEdit(context),
      onConfirm: () => _onConfirm(context),
    );
  }
}
