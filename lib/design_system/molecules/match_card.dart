import 'package:flutter/material.dart';
import '../atoms/team_logo.dart';
import '../atoms/match_status.dart';

class MatchCard extends StatelessWidget {
  final String homeTeam;
  final String awayTeam;
  final Color homeColor;
  final Color awayColor;
  final String date;
  final String stadium;
  final String status;
  final Color statusColor;
  final VoidCallback onTap;

  const MatchCard({
    super.key,
    required this.homeTeam,
    required this.awayTeam,
    required this.homeColor,
    required this.awayColor,
    required this.date,
    required this.stadium,
    required this.status,
    required this.statusColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TeamLogo(teamName: homeTeam, backgroundColor: homeColor),
                  const Text('VS', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  TeamLogo(teamName: awayTeam, backgroundColor: awayColor),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                '$homeTeam vs $awayTeam',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(date, style: const TextStyle(color: Colors.grey)),
              Text(stadium, style: const TextStyle(color: Colors.grey)),
              const SizedBox(height: 8),
              MatchStatus(status: status, color: statusColor),
            ],
          ),
        ),
      ),
    );
  }
}