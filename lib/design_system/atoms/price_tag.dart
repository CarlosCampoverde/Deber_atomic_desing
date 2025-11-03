import 'package:flutter/material.dart';

class PriceTag extends StatelessWidget {
  final double price;
  final bool highlighted;

  const PriceTag({
    super.key,
    required this.price,
    this.highlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: highlighted ? Colors.green : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        '\$${price.toStringAsFixed(0)}',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: highlighted ? Colors.white : Colors.black,
          fontSize: 14,
        ),
      ),
    );
  }
}