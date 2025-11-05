import 'package:flutter/material.dart';
import '../molecules/match_card.dart';

/// Organismo que muestra una lista de partidos usando múltiples moléculas MatchCard
/// 
/// Este organismo agrupa múltiples MatchCard para crear una vista de lista
/// de partidos disponibles
class MatchList extends StatelessWidget {
  final List<MatchData> matches;
  final Function(MatchData)? onMatchSelected;

  const MatchList({
    super.key,
    required this.matches,
    this.onMatchSelected,
  });

  @override
  Widget build(BuildContext context) {
    if (matches.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: Text(
            'No hay partidos disponibles',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: matches.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final match = matches[index];
        return MatchCard(
          homeTeam: match.homeTeam,
          awayTeam: match.awayTeam,
          homeColor: match.homeColor,
          awayColor: match.awayColor,
          date: match.date,
          stadium: match.stadium,
          status: match.status,
          statusColor: match.statusColor,
          onTap: () {
            onMatchSelected?.call(match);
          },
        );
      },
    );
  }
}

/// Clase de datos para representar un partido
class MatchData {
  final String homeTeam;
  final String awayTeam;
  final Color homeColor;
  final Color awayColor;
  final String date;
  final String stadium;
  final String status;
  final Color statusColor;
  final String? id;

  MatchData({
    required this.homeTeam,
    required this.awayTeam,
    required this.homeColor,
    required this.awayColor,
    required this.date,
    required this.stadium,
    required this.status,
    required this.statusColor,
    this.id,
  });
}

