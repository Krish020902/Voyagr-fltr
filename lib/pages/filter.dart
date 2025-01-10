import 'package:Voyagr/component/age_range_selector.dart';
import 'package:Voyagr/component/budget_selector.dart';
import 'package:Voyagr/component/distance_selector.dart';
import 'package:Voyagr/component/gender_selector.dart';
import 'package:Voyagr/component/place_selector.dart';
import 'package:Voyagr/component/preferences.dart';
import 'package:flutter/material.dart';

class FilterPage extends StatefulWidget {
  FilterPage({super.key});

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  List<String> selectedGender = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GenderSelector(
                // Uncomment the line below if you want to pass an initial value
                // initialValue: selectedGender,
                onGenderSelected: (genders) {
                  setState(() {
                    selectedGender = genders; // Update the parent state
                  });
                },
              ),
              const SizedBox(height: 12),
              Divider(height: 10),
              const SizedBox(height: 12),
              AgeRangeSelector(),
              const SizedBox(height: 12),
              Divider(height: 10),
              const SizedBox(height: 12),
              DistanceSelector(),
              const SizedBox(height: 12),
              Divider(height: 10),
              const SizedBox(height: 12),
              BudgetSelector(),
              const SizedBox(height: 12),
              Divider(height: 10),
              const SizedBox(height: 12),
              PreferencesGrid(),
              const SizedBox(height: 12),
              Divider(height: 10),
              const SizedBox(height: 12),
              PlaceSelector()
            ],
          ),
        ),
      ),
    );
  }
}
