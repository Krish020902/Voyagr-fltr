import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AgeRangeController extends GetxController {
  var selectedAgeRange = 40.0.obs;

  void updateAgeRange(double value) {
    selectedAgeRange.value = value;
    HapticFeedback.lightImpact();
  }
}

class AgeRangeSelector extends StatelessWidget {
  AgeRangeSelector({super.key});

  final AgeRangeController ageRangeController = Get.put(AgeRangeController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Preferred Age Range',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const Icon(Icons.person, size: 18),
                  const SizedBox(width: 4),
                  Obx(() => Text(
                      '18 - ${ageRangeController.selectedAgeRange.toInt()} years'))
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: Colors.teal,
              inactiveTrackColor: Colors.grey.shade300,
              thumbColor: Colors.teal,
            ),
            child: Obx(
              () => Slider(
                value: ageRangeController.selectedAgeRange.value,
                min: 18,
                max: 100,
                onChanged: (value) {
                  ageRangeController.updateAgeRange(value);
                },
              ),
            )),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: const [
        //     Text('18'),
        //     Text('100'),
        //   ],
        // ),
      ],
    );
  }
}
