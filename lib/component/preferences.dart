import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PreferenceContainer extends GetxController {
  var selectedPreferences = <String>[].obs;

  void togglePreference(String preference) {
    if (selectedPreferences.contains(preference)) {
      selectedPreferences.remove(preference);
    } else {
      selectedPreferences.add(preference);
    }
  }
}

class PreferencesGrid extends StatelessWidget {
  PreferencesGrid({super.key});
  final PreferenceContainer preferenceContainer =
      Get.put(PreferenceContainer());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () => preferenceContainer.togglePreference('Smoking'),
              child: Obx(
                () => _PreferenceItem(
                  icon: preferenceContainer.selectedPreferences
                          .contains("Smoking")
                      ? Icons.smoking_rooms
                      : Icons.smoke_free,
                  label: 'Smoking',
                  isSelected: preferenceContainer.selectedPreferences
                      .contains("Smoking"),
                ),
              ),
            ),
            InkWell(
              onTap: () => preferenceContainer.togglePreference('Drinking'),
              child: Obx(
                () => _PreferenceItem(
                  icon: preferenceContainer.selectedPreferences
                          .contains("Drinking")
                      ? Icons.local_bar
                      : Icons.no_drinks,
                  label: 'Drinking',
                  isSelected: preferenceContainer.selectedPreferences
                      .contains("Drinking"),
                ),
              ),
            ),
            InkWell(
              onTap: () => preferenceContainer.togglePreference('Pets'),
              child: Obx(
                () => _PreferenceItem(
                  icon: preferenceContainer.selectedPreferences.contains("Pets")
                      ? Icons.pets
                      : Icons.do_not_disturb_alt,
                  label: 'Pets',
                  isSelected:
                      preferenceContainer.selectedPreferences.contains("Pets"),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _PreferenceItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;

  const _PreferenceItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isSelected ? Colors.teal.withOpacity(0.7) : Colors.transparent,
        border: Border.all(
          color: isSelected ? Colors.white : Colors.teal,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: isSelected ? Colors.white : Colors.teal,
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.teal,
            ),
          ),
        ],
      ),
    );
  }
}
