
import 'package:flutter/material.dart';
import 'design_system/atoms/team_logo.dart';
import 'design_system/atoms/price_tag.dart';
import 'design_system/atoms/match_status.dart';

void main() => runApp(const AtomTestApp());

class AtomTestApp extends StatelessWidget {
  const AtomTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('ÁTOMOS')),
        body: const Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('1. TeamLogo', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Row(
                children: [
                  TeamLogo(teamName: 'Barcelona', backgroundColor: Colors.yellow),
                  SizedBox(width: 20),
                  TeamLogo(teamName: 'Emelec', backgroundColor: Colors.blue),
                ],
              ),
              SizedBox(height: 30),

              Text('2. PriceTag', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Wrap(
                spacing: 10,
                children: [
                  PriceTag(price: 20),
                  PriceTag(price: 35, highlighted: true),
                  PriceTag(price: 60),
                ],
              ),
              SizedBox(height: 30),

              Text('3. MatchStatus', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Wrap(
                spacing: 10,
                children: [
                  MatchStatus(status: 'Disponible', color: Colors.green),
                  MatchStatus(status: 'Agotado', color: Colors.red),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}