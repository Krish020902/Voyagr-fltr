import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TravelPreferencesContainer extends GetxController {
  var personalityType = 'Ambivert'.obs;
  var travelStyle = <String>[].obs;
  var preferredActivities = <String>[].obs;
  var accommodationType = ''.obs;
  var budgetRange = ''.obs;
  var tripPace = ''.obs;
  var dietaryPreferences = <String>[].obs;
  var languagesSpoken = <String>[].obs;

  void setPersonalityType(String type) {
    personalityType.value = type;
  }

  void toggleTravelStyle(String style) {
    if (travelStyle.contains(style)) {
      travelStyle.remove(style);
    } else {
      travelStyle.add(style);
    }
  }

  void toggleActivity(String activity) {
    if (preferredActivities.contains(activity)) {
      preferredActivities.remove(activity);
    } else {
      preferredActivities.add(activity);
    }
  }

  void setAccommodationType(String type) {
    accommodationType.value = type;
  }

  void setBudgetRange(String range) {
    budgetRange.value = range;
  }

  void setTripPace(String pace) {
    tripPace.value = pace;
  }

  void toggleDietaryPreference(String preference) {
    if (dietaryPreferences.contains(preference)) {
      dietaryPreferences.remove(preference);
    } else {
      dietaryPreferences.add(preference);
    }
  }

  void toggleLanguage(String language) {
    if (languagesSpoken.contains(language)) {
      languagesSpoken.remove(language);
    } else {
      languagesSpoken.add(language);
    }
  }
}

class TravelPreferences extends StatelessWidget {
  final TravelPreferencesContainer travelPreferencesController =
      Get.put(TravelPreferencesContainer());

  TravelPreferences({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Travel Preferences'),

          _buildSubsectionTitle('What best describes your personality?'),
          Obx(() => Column(
                children: ['Introvert', 'Extrovert', 'Ambivert'].map((type) {
                  return RadioListTile<String>(
                    title:
                        Text(type, style: const TextStyle(color: Colors.white)),
                    value: type,
                    groupValue:
                        travelPreferencesController.personalityType.value,
                    activeColor: Colors.teal[300],
                    onChanged: (String? value) {
                      if (value != null) {
                        travelPreferencesController.setPersonalityType(value);
                      }
                    },
                  );
                }).toList(),
              )),

          _buildSubsectionTitle('What\'s your travel style? (Select multiple)'),
          Obx(() => Wrap(
                spacing: 8,
                children: [
                  'Budget',
                  'Luxury',
                  'Adventure',
                  'Cultural',
                  'Relaxation',
                  'Solo',
                  'Group',
                ]
                    .map((style) => FilterChip(
                          label: Text(style),
                          selected: travelPreferencesController.travelStyle
                              .contains(style),
                          onSelected: (_) => travelPreferencesController
                              .toggleTravelStyle(style),
                          selectedColor: Colors.teal[300],
                          checkmarkColor: Colors.white,
                          labelStyle: TextStyle(color: Colors.white),
                          backgroundColor: Colors.grey[800],
                        ))
                    .toList(),
              )),

          _buildSubsectionTitle(
            'Preferred Activities (Select multiple)',
          ),
          Obx(() => Wrap(
                spacing: 8,
                children: [
                  'Hiking',
                  'Photography',
                  'Food Tasting',
                  'Museums',
                  'Shopping',
                  'Beach',
                  'Nightlife',
                  'Sports',
                  'Local Events',
                  'Sightseeing',
                ]
                    .map((activity) => FilterChip(
                          label: Text(activity),
                          selected: travelPreferencesController
                              .preferredActivities
                              .contains(activity),
                          onSelected: (_) => travelPreferencesController
                              .toggleActivity(activity),
                          selectedColor: Colors.teal[300],
                          checkmarkColor: Colors.white,
                          labelStyle: TextStyle(color: Colors.white),
                          backgroundColor: Colors.grey[800],
                        ))
                    .toList(),
              )),

          // Accommodation Section
          _buildSubsectionTitle('Preferred Accommodation Type'),
          Obx(() => Column(
                children: [
                  'Luxury Hotel',
                  'Budget Hotel',
                  'Hostel',
                  'Vacation Rental',
                  'Camping',
                ].map((type) {
                  return RadioListTile<String>(
                    title: Text(type, style: TextStyle(color: Colors.white)),
                    value: type,
                    groupValue:
                        travelPreferencesController.accommodationType.value,
                    activeColor: Colors.teal[300],
                    onChanged: (String? value) {
                      if (value != null) {
                        travelPreferencesController.setAccommodationType(value);
                      }
                    },
                  );
                }).toList(),
              )),

          // Budget Range Section
          _buildSubsectionTitle('Daily Budget Range (excluding flights)'),
          Obx(() => Column(
                children: [
                  'Budget (0-50)',
                  'Moderate (51-150)',
                  'Luxury (151-300)',
                  'Ultra-Luxury (300+)',
                ].map((range) {
                  return RadioListTile<String>(
                    title: Text(range, style: TextStyle(color: Colors.white)),
                    value: range,
                    groupValue: travelPreferencesController.budgetRange.value,
                    activeColor: Colors.teal[300],
                    onChanged: (String? value) {
                      if (value != null) {
                        travelPreferencesController.setBudgetRange(value);
                      }
                    },
                  );
                }).toList(),
              )),

          // Trip Pace Section
          _buildSubsectionTitle('Preferred Trip Pace'),
          Obx(() => Column(
                children: [
                  'Relaxed (Few activities per day)',
                  'Moderate (Balance of activities and rest)',
                  'Fast-paced (Packed schedule)',
                ].map((pace) {
                  return RadioListTile<String>(
                    title: Text(pace, style: TextStyle(color: Colors.white)),
                    value: pace,
                    groupValue: travelPreferencesController.tripPace.value,
                    activeColor: Colors.teal[300],
                    onChanged: (String? value) {
                      if (value != null) {
                        travelPreferencesController.setTripPace(value);
                      }
                    },
                  );
                }).toList(),
              )),

          // Dietary Preferences Section
          _buildSubsectionTitle('Dietary Preferences (Select multiple)'),
          Obx(() => Wrap(
                spacing: 8,
                children: [
                  'Vegetarian',
                  'Vegan',
                  'Halal',
                  'Kosher',
                  'Gluten-free',
                  'No restrictions',
                ]
                    .map((diet) => FilterChip(
                          label: Text(diet),
                          selected: travelPreferencesController
                              .dietaryPreferences
                              .contains(diet),
                          onSelected: (_) => travelPreferencesController
                              .toggleDietaryPreference(diet),
                          selectedColor: Colors.teal[300],
                          checkmarkColor: Colors.white,
                          labelStyle: TextStyle(color: Colors.white),
                          backgroundColor: Colors.grey[800],
                        ))
                    .toList(),
              )),

          // Languages Section
          _buildSubsectionTitle('Languages Spoken (Select multiple)'),
          Obx(() => Wrap(
                spacing: 8,
                children: [
                  'English',
                  'Spanish',
                  'French',
                  'German',
                  'Italian',
                  'Chinese',
                  'Japanese',
                  'Arabic',
                  'Hindi',
                ]
                    .map((language) => FilterChip(
                          label: Text(language),
                          selected: travelPreferencesController.languagesSpoken
                              .contains(language),
                          onSelected: (_) => travelPreferencesController
                              .toggleLanguage(language),
                          selectedColor: Colors.teal[300],
                          checkmarkColor: Colors.white,
                          labelStyle: TextStyle(color: Colors.white),
                          backgroundColor: Colors.grey[800],
                        ))
                    .toList(),
              )),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.grey[100],
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSubsectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(
        title,
        style: TextStyle(
            color: Colors.grey[300], fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
