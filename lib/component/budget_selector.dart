import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class BudgetController extends GetxController {
  var selectedBudget = 100000.0.obs;
  var maxBudget = 100000.0.obs;
  var increaseBudget = false.obs;

  void updateBudget(double value) {
    selectedBudget.value = value;
  }

  void toggleIncreaseBudget(bool value) {
    if (value) {
      maxBudget.value = 500000.0;
    } else {
      selectedBudget.value = 100000.0;
      maxBudget.value = 100000.0;
    }
    increaseBudget.value = value;

    HapticFeedback.mediumImpact();
  }
}

class BudgetSelector extends StatelessWidget {
  final BudgetController budgetController = Get.put(BudgetController());

  BudgetSelector({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Budget Range',
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
                  const Icon(Icons.account_balance_wallet, size: 18),
                  const SizedBox(width: 4),
                  Obx(() => Text('₹${budgetController.selectedBudget.toInt()}'))
                  // Text('₹${_value.toInt()}'),
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
                value: budgetController.selectedBudget.value,
                min: 0,
                max: budgetController.maxBudget.value,
                divisions: 200,
                onChanged: (double newValue) {
                  budgetController.updateBudget(newValue);
                  HapticFeedback.lightImpact();
                  ;
                },
              ),
            )),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: const [
        //     Text('₹0'),
        //     Text('₹1,00,000'),
        //   ],
        // ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Increase budget range?'),
            Obx(
              () => Switch(
                value: budgetController.increaseBudget.value,
                onChanged: budgetController.toggleIncreaseBudget,
                activeColor: Colors.teal,
              ),
            )
          ],
        ),
      ],
    );
  }
}
