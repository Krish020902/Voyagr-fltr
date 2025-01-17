import 'package:Voyagr/component/match_card.dart';
import 'package:flutter/material.dart';

import '../data/matches.dart';

class MatchesPage extends StatelessWidget {
  const MatchesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // backgroundColor: _tealColor,
          automaticallyImplyLeading: false,
          title: Text('My Matches',
              style: TextStyle(
                color: Colors.teal,
                fontSize: 24,
                // fontWeight: FontWeight.bold,
              ))),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: matches.length,
        itemBuilder: (context, index) {
          return MatchCard(match: matches[index]);
        },
      ),
    );
  }
}
