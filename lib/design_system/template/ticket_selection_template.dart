import 'package:flutter/material.dart';
import '../Organismo/mach_tiked_selector.dart';

/// Template para la página de selección de tickets de un partido
/// 
/// Este template define la estructura de la página de selección usando:
/// - AppBar con botón de retroceso
/// - El organismo MatchTicketSelector para seleccionar asientos
/// - Layout con scroll para contenido largo
class TicketSelectionTemplate extends StatelessWidget {
  final String homeTeam;
  final String awayTeam;
  final Color homeColor;
  final Color awayColor;
  final String date;
  final String stadium;
  final String status;
  final Color statusColor;
  final List<SeatZoneData> seatZones;
  final Function(Map<String, int>)? onSelectionChanged;
  final VoidCallback? onContinue;
  final VoidCallback? onBack;

  const TicketSelectionTemplate({
    super.key,
    required this.homeTeam,
    required this.awayTeam,
    required this.homeColor,
    required this.awayColor,
    required this.date,
    required this.stadium,
    required this.status,
    required this.statusColor,
    required this.seatZones,
    this.onSelectionChanged,
    this.onContinue,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seleccionar Tickets'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: onBack ?? () => Navigator.of(context).pop(),
        ),
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: MatchTicketSelector(
          homeTeam: homeTeam,
          awayTeam: awayTeam,
          homeColor: homeColor,
          awayColor: awayColor,
          date: date,
          stadium: stadium,
          status: status,
          statusColor: statusColor,
          seatZones: seatZones,
          onSelectionChanged: onSelectionChanged,
          onContinue: onContinue,
        ),
      ),
    );
  }
}

