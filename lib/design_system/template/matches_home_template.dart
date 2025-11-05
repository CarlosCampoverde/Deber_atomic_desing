import 'package:flutter/material.dart';
import '../Organismo/match_list.dart';

/// Template para la página principal que muestra la lista de partidos disponibles
/// 
/// Este template define la estructura de la página principal usando:
/// - AppBar con título
/// - El organismo MatchList para mostrar la lista de partidos
/// - Layout responsive con scroll
class MatchesHomeTemplate extends StatelessWidget {
  final List<MatchData> matches;
  final Function(MatchData)? onMatchSelected;
  final String? title;
  final Widget? floatingActionButton;
  final Widget? drawer;

  const MatchesHomeTemplate({
    super.key,
    required this.matches,
    this.onMatchSelected,
    this.title,
    this.floatingActionButton,
    this.drawer,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title ?? 'Partidos Disponibles'),
        elevation: 2,
      ),
      drawer: drawer,
      body: MatchList(
        matches: matches,
        onMatchSelected: onMatchSelected,
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}

