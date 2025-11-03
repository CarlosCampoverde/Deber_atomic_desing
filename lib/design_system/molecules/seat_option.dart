import 'package:flutter/material.dart';
import '../atoms/price_tag.dart';

class SeatOption extends StatelessWidget {
  final String zone;
  final double price;
  final int selectedCount;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const SeatOption({
    super.key,
    required this.zone,
    required this.price,
    required this.selectedCount,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(zone, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                PriceTag(price: price),
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: selectedCount > 0 ? onDecrement : null,
                  icon: const Icon(Icons.remove_circle_outline),
                  color: Colors.red,
                ),
                Text('$selectedCount', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                IconButton(
                  onPressed: onIncrement,
                  icon: const Icon(Icons.add_circle_outline),
                  color: Colors.green,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}