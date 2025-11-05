import 'package:flutter/material.dart';
import '../atoms/price_tag.dart';

/// Organismo que muestra un resumen detallado de la selección de asientos
/// 
/// Este organismo combina múltiples átomos PriceTag y muestra información
/// consolidada sobre las zonas seleccionadas
class SeatSelectionSummary extends StatelessWidget {
  final Map<String, SeatSummaryData> selections;
  final VoidCallback? onEdit;
  final VoidCallback? onConfirm;

  const SeatSelectionSummary({
    super.key,
    required this.selections,
    this.onEdit,
    this.onConfirm,
  });

  int _getTotalSeats() {
    return selections.values.fold(0, (sum, data) => sum + data.quantity);
  }

  double _getTotalPrice() {
    return selections.values.fold(
      0.0,
      (sum, data) => sum + (data.price * data.quantity),
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedZones = selections.entries.where((e) => e.value.quantity > 0).toList();

    if (selectedZones.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Icon(Icons.event_seat, size: 48, color: Colors.grey.shade400),
              const SizedBox(height: 16),
              Text(
                'No hay asientos seleccionados',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Resumen de Selección',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (onEdit != null)
                  TextButton.icon(
                    onPressed: onEdit,
                    icon: const Icon(Icons.edit, size: 18),
                    label: const Text('Editar'),
                  ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 8),
            
            // Detalle por zona usando átomos PriceTag
            ...selectedZones.map((entry) {
              final data = entry.value;
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            entry.key,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${data.quantity} ${data.quantity == 1 ? "asiento" : "asientos"} × \$${data.price.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    PriceTag(
                      price: data.price * data.quantity,
                      highlighted: true,
                    ),
                  ],
                ),
              );
            }),
            
            const Divider(),
            const SizedBox(height: 8),
            
            // Totales
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total de asientos',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      '$_getTotalSeats()',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Total a pagar',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      '\$${_getTotalPrice().toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            
            if (onConfirm != null) ...[
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onConfirm,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Confirmar Compra',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Clase de datos para representar el resumen de una zona seleccionada
class SeatSummaryData {
  final int quantity;
  final double price;

  SeatSummaryData({
    required this.quantity,
    required this.price,
  });
}

