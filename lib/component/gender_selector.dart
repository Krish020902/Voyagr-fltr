import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GenderController extends GetxController {
  var selectedGenders = <String>[].obs;

  void toggleGender(String gender) {
    if (selectedGenders.contains(gender)) {
      selectedGenders.remove(gender);
    } else {
      selectedGenders.add(gender);
    }
  }
}

class GenderSelector extends StatelessWidget {
  final GenderController genderController = Get.put(GenderController());
  final Function(List<String>) onGenderSelected;

  GenderSelector({super.key, required this.onGenderSelected});

  void _showGenderBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select Gender',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              Obx(() => _GenderOption(
                    label: 'Male',
                    icon: Icons.male,
                    isSelected:
                        genderController.selectedGenders.contains('Male'),
                    onTap: () {
                      genderController.toggleGender('Male');
                      onGenderSelected(genderController.selectedGenders);
                    },
                  )),
              const SizedBox(height: 16),
              Obx(() => _GenderOption(
                    label: 'Female',
                    icon: Icons.female,
                    isSelected:
                        genderController.selectedGenders.contains('Female'),
                    onTap: () {
                      genderController.toggleGender('Female');
                      onGenderSelected(genderController.selectedGenders);
                    },
                  )),
              const SizedBox(height: 16),
              Obx(() => _GenderOption(
                    label: 'Non-binary',
                    icon: Icons.transgender,
                    isSelected:
                        genderController.selectedGenders.contains('Non-binary'),
                    onTap: () {
                      genderController.toggleGender('Non-binary');
                      onGenderSelected(genderController.selectedGenders);
                    },
                  )),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showGenderBottomSheet(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  genderController.selectedGenders.isNotEmpty
                      ? genderController.selectedGenders.join(', ')
                      : 'Select Preferred Genders',
                  style: TextStyle(
                    color: genderController.selectedGenders.isNotEmpty
                        ? Colors.black
                        : Colors.grey,
                    fontSize: 16,
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.grey.shade600,
                ),
              ],
            )),
      ),
    );
  }
}

class _GenderOption extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _GenderOption({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.teal.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Colors.teal : Colors.grey.shade300,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.teal : Colors.grey.shade600,
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                color: isSelected ? Colors.teal : Colors.black,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
