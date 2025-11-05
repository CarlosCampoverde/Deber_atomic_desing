import 'package:flutter/material.dart';
import '../molecules/match_card.dart';
import '../molecules/seat_option.dart';

/// Organismo que combina la información del partido con las opciones de selección de asientos
/// 
/// Este organismo reúne:
/// - La molécula MatchCard para mostrar información del partido
/// - Múltiples moléculas SeatOption para seleccionar asientos de diferentes zonas
class MatchTicketSelector extends StatefulWidget {
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

  const MatchTicketSelector({
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
  });

  @override
  State<MatchTicketSelector> createState() => _MatchTicketSelectorState();
}

class _MatchTicketSelectorState extends State<MatchTicketSelector> {
  late Map<String, int> _selectedSeats;

  @override
  void initState() {
    super.initState();
    _selectedSeats = {
      for (var zone in widget.seatZones) zone.zone: 0
    };
  }

  void _updateSelection(String zone, int count) {
    setState(() {
      _selectedSeats[zone] = count;
    });
    widget.onSelectionChanged?.call(Map.from(_selectedSeats));
  }

  int _getTotalSeats() {
    return _selectedSeats.values.fold(0, (sum, count) => sum + count);
  }

  double _getTotalPrice() {
    double total = 0;
    for (var zoneData in widget.seatZones) {
      final count = _selectedSeats[zoneData.zone] ?? 0;
      total += zoneData.price * count;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Información del partido usando la molécula MatchCard
        MatchCard(
          homeTeam: widget.homeTeam,
          awayTeam: widget.awayTeam,
          homeColor: widget.homeColor,
          awayColor: widget.awayColor,
          date: widget.date,
          stadium: widget.stadium,
          status: widget.status,
          statusColor: widget.statusColor,
          onTap: () {}, // No acción adicional aquí
        ),
        
        const SizedBox(height: 24),
        
        // Título de selección de asientos
        const Text(
          'Selecciona tus asientos',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Lista de opciones de asientos usando múltiples moléculas SeatOption
        ...widget.seatZones.map((zoneData) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: SeatOption(
            zone: zoneData.zone,
            price: zoneData.price,
            selectedCount: _selectedSeats[zoneData.zone] ?? 0,
            onIncrement: () {
              _updateSelection(zoneData.zone, (_selectedSeats[zoneData.zone] ?? 0) + 1);
            },
            onDecrement: () {
              final currentCount = _selectedSeats[zoneData.zone] ?? 0;
              if (currentCount > 0) {
                _updateSelection(zoneData.zone, currentCount - 1);
              }
            },
          ),
        )),
        
        const SizedBox(height: 24),
        
        // Resumen de la selección
        Card(
          color: Colors.blue.shade50,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Resumen',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total de asientos: ${_getTotalSeats()}'),
                    Text(
                      'Total: \$${_getTotalPrice().toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        
        if (widget.onContinue != null) ...[
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _getTotalSeats() > 0 ? widget.onContinue : null,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Continuar',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ],
    );
  }
}

/// Clase de datos para representar una zona de asientos
class SeatZoneData {
  final String zone;
  final double price;

  SeatZoneData({
    required this.zone,
    required this.price,
  });
}

