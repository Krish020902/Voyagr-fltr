import 'package:Voyagr/component/ratings_chart.dart';
import 'package:flutter/material.dart';

class RatingsPage extends StatelessWidget {
  const RatingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ratings',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: RatingChart(),
    );
  }
}
