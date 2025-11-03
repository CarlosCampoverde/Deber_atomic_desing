import 'package:flutter/material.dart';
import 'design_system/molecules/seat_option.dart';

void main() => runApp(const MoleculeTestApp());

class MoleculeTestApp extends StatefulWidget {
  const MoleculeTestApp({super.key});
  @override
  State<MoleculeTestApp> createState() => _MoleculeTestAppState();
}

class _MoleculeTestAppState extends State<MoleculeTestApp> {
  int count = 2;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('MOLÉCULA: SeatOption')),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: SeatOption(
            zone: 'General',
            price: 20,
            selectedCount: count,
            onIncrement: () => setState(() => count++),
            onDecrement: () => setState(() => count > 0 ? count-- : null),
          ),
        ),
      ),
    );
  }
}