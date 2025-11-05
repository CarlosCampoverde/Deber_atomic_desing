import 'package:flutter/material.dart';
import '../Organismo/seat_selection_summary.dart';

/// Template para la página de checkout/resumen final
/// 
/// Este template define la estructura de la página de checkout usando:
/// - AppBar con título
/// - El organismo SeatSelectionSummary para mostrar el resumen
/// - Posibilidad de mostrar información adicional del partido
/// - Layout con scroll para contenido largo
class CheckoutTemplate extends StatelessWidget {
  final Map<String, SeatSummaryData> selections;
  final VoidCallback? onEdit;
  final VoidCallback? onConfirm;
  final VoidCallback? onBack;
  final Widget? matchInfo;
  final String? title;

  const CheckoutTemplate({
    super.key,
    required this.selections,
    this.onEdit,
    this.onConfirm,
    this.onBack,
    this.matchInfo,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title ?? 'Resumen de Compra'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: onBack ?? () => Navigator.of(context).pop(),
        ),
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Información del partido (opcional)
            if (matchInfo != null) ...[
              matchInfo!,
              const SizedBox(height: 24),
            ],
            
            // Resumen de selección usando el organismo SeatSelectionSummary
            SeatSelectionSummary(
              selections: selections,
              onEdit: onEdit,
              onConfirm: onConfirm,
            ),
            
            const SizedBox(height: 24),
            
            // Información adicional o términos (opcional)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info_outline, color: Colors.blue.shade700),
                        const SizedBox(width: 8),
                        const Text(
                          'Información Importante',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '• Los tickets son válidos solo para el partido seleccionado\n'
                      '• No se permiten reembolsos después de la compra\n'
                      '• Presenta tu identificación al ingresar al estadio',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

