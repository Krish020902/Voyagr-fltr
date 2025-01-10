import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class DistanceController extends GetxController {
  var selectedDistance = 50.0.obs;

  void updateDistance(double value) {
    selectedDistance.value = value;
    HapticFeedback.lightImpact();
  }
}

class DistanceSelector extends StatelessWidget {
  final DistanceController distanceController = Get.put(DistanceController());
  DistanceSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Maximum Distance',
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
                  const Icon(Icons.location_on, size: 18),
                  const SizedBox(width: 4),
                  Obx(() => Text(
                      '${distanceController.selectedDistance.toInt()} km')),
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
                value: distanceController.selectedDistance.value,
                min: 0,
                max: 500,
                onChanged: (value) {
                  distanceController.updateDistance(value);
                },
              ),
            )),
      ],
    );
  }
}
