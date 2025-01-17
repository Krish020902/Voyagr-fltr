import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TravelPostController extends GetxController {
  final formKey = GlobalKey<FormState>();
  Rx<DateTime?> startDate = Rx<DateTime?>(null);
  Rx<DateTime?> endDate = Rx<DateTime?>(null);
  RxString selectedTransport = 'Air'.obs;
  RxList<String> interests = <String>[].obs;
  RxList<String> travelActivities = <String>[].obs;
  final List<String> transportOptions = ['Air', 'Train', 'Road', 'Sea'];
  final List<String> interestOptions = [
    'Adventure',
    'Cultural',
    'Food',
    'History',
    'Nature',
    'Photography',
    'Shopping',
    'Sightseeing',
    'Sports',
    'Budget',
    'Luxury',
    'Relaxation',
    'Solo',
    'Group',
  ];
  final List<String> travelActivitiesOptions = [
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
  ];
  final List<String> accommodationOptions = [
    "Ashram",
    "Beach Hut",
    "Beach Resort",
    "Beachside Homestay",
    "Budget Hotel",
    "Camp",
    "Cottage",
    "Guest House",
    "Heritage Hotel",
    "Heritage Stay",
    "Homestay",
    "Hostel",
    "Houseboat",
    "Luxury Hotel",
    "Luxury Resort",
    "Resort",
    "Ski Resort"
  ];

  final List<String> dietaryPreferencesOptions = [
    'Vegetarian',
    'Non-Vegetarian',
    'Jain',
    'Swaminarayan',
    'Eggetarian',
    'Vegan',
    'Halal',
    'Kosher',
    'Gluten-free',
    'No restrictions',
  ];
  RxList<String> dietaryPreferences = <String>[].obs;

  RxList<String> selectedAccommodation = <String>[].obs;

  final destinationController = TextEditingController();
  final minBudgetController = TextEditingController();
  final maxBudgetController = TextEditingController();
  final additionalInfoController = TextEditingController();

  @override
  void onClose() {
    destinationController.dispose();
    minBudgetController.dispose();
    maxBudgetController.dispose();
    additionalInfoController.dispose();
    super.onClose();
  }

  // void printPostData() {
  //   print('\n=== Travel Post Data ===');
  //   print('Destination: ${destinationController.text}');
  //   print(
  //       'Budget Range: ₹${minBudgetController.text} - ₹${maxBudgetController.text}');

  //   if (startDate.value != null) {
  //     print(
  //         'Start Date: ${DateFormat('MMM dd, yyyy').format(startDate.value!)}');
  //   }
  //   if (endDate.value != null) {
  //     print('End Date: ${DateFormat('MMM dd, yyyy').format(endDate.value!)}');
  //   }

  //   print('Transport Mode: ${selectedTransport.value}');
  //   print('Activities: ${travelActivities.join(", ")}');
  //   print('Interests: ${interests.join(", ")}');
  //   print('Accommodation: ${selectedAccommodation.value}');
  //   print('Dietary Preferences: ${dietaryPreferences.join(", ")}');
  //   print('Additional Info: ${additionalInfoController.text}');
  //   print('========================\n');
  // }
}

class TravelPostPage extends StatelessWidget {
  final TravelPostController controller = Get.put(TravelPostController());

  TravelPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Post Travel Advertisement',
            style: TextStyle(
              color: Colors.teal,
              fontSize: 24,
            )),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.teal.shade50, Colors.grey.shade100],
          ),
        ),
        child: Form(
          key: controller.formKey,
          child: ListView(
            padding: EdgeInsets.all(16),
            children: [
              _buildSectionTitle('Destination Details'),
              _buildCard([
                TextFormField(
                  decoration: _inputDecoration('Where do you want to go?'),
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Required field' : null,
                ),
              ]),
              SizedBox(height: 20),
              _buildSectionTitle('Budget Information'),
              Row(children: [
                Expanded(
                  child: TextFormField(
                    controller: controller.minBudgetController,
                    decoration: _inputDecoration('Min Budget').copyWith(
                      prefixText: '₹ ',
                      prefixStyle: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Required';
                      }
                      if (double.tryParse(value!) == null) {
                        return 'Invalid amount';
                      }
                      return null;
                    },
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'to',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    controller: controller.maxBudgetController,
                    decoration: _inputDecoration('Max Budget').copyWith(
                      prefixText: '₹ ',
                      prefixStyle: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Required';
                      }
                      if (double.tryParse(value!) == null) {
                        return 'Invalid amount';
                      }
                      final minBudget = double.tryParse(
                              controller.minBudgetController.text) ??
                          0;
                      final maxBudget = double.tryParse(value) ?? 0;
                      if (maxBudget < minBudget) {
                        return 'Should be greater than min budget';
                      }
                      return null;
                    },
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ]),
              SizedBox(height: 20),
              _buildSectionTitle('Estimated Travel Dates'),
              _buildCard([
                Obx(() => ListTile(
                      title: Text(controller.startDate.value == null
                          ? 'Select Start Date'
                          : 'Start: ${DateFormat('MMM dd, yyyy').format(controller.startDate.value!)}'),
                      trailing: Icon(Icons.calendar_today, color: Colors.teal),
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(Duration(days: 365)),
                        );
                        if (date != null) controller.startDate.value = date;
                      },
                    )),
                Divider(),
                Obx(() => ListTile(
                      title: Text(controller.endDate.value == null
                          ? 'Select End Date'
                          : 'End: ${DateFormat('MMM dd, yyyy').format(controller.endDate.value!)}'),
                      trailing: Icon(Icons.calendar_today, color: Colors.teal),
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate:
                              controller.startDate.value ?? DateTime.now(),
                          firstDate:
                              controller.startDate.value ?? DateTime.now(),
                          lastDate: DateTime.now().add(Duration(days: 365)),
                        );
                        if (date != null) controller.endDate.value = date;
                      },
                    )),
              ]),
              SizedBox(height: 20),
              _buildSectionTitle('Transportation'),
              _buildCard([
                Obx(() => DropdownButtonFormField<String>(
                      decoration:
                          _inputDecoration('Preferred mode of transport'),
                      value: controller.selectedTransport.value,
                      items: controller.transportOptions.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        controller.selectedTransport.value = value!;
                      },
                    )),
              ]),
              SizedBox(height: 20),
              _buildSectionTitle('Preferred Activities (Select multiple)'),
              Obx(() => Wrap(
                    spacing: 8,
                    children:
                        controller.travelActivitiesOptions.map((interest) {
                      bool isSelected =
                          controller.travelActivities.contains(interest);
                      return FilterChip(
                        label: Text(interest),
                        selected: isSelected,
                        selectedColor: Colors.teal.withOpacity(0.3),
                        checkmarkColor: Colors.teal,
                        onSelected: (bool selected) {
                          if (selected) {
                            controller.travelActivities.add(interest);
                          } else {
                            controller.travelActivities.remove(interest);
                          }
                        },
                      );
                    }).toList(),
                  )),
              _buildSectionTitle('Travel Interests'),
              Obx(
                () => Wrap(
                  spacing: 8,
                  children: controller.interestOptions.map((interest) {
                    bool isSelected = controller.interests.contains(interest);
                    return FilterChip(
                      label: Text(interest),
                      selected: isSelected,
                      selectedColor: Colors.teal.withOpacity(0.3),
                      checkmarkColor: Colors.teal,
                      onSelected: (bool selected) {
                        if (selected) {
                          controller.interests.add(interest);
                        } else {
                          controller.interests.remove(interest);
                        }
                      },
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 20),
              _buildSectionTitle('Preferred Accommodation Type'),
              Obx(() => Wrap(
                    spacing: 8,
                    children: controller.accommodationOptions.map((type) {
                      bool isSelected =
                          controller.selectedAccommodation.contains(type);
                      return FilterChip(
                        label: Text(type),
                        selected: isSelected,
                        selectedColor: Colors.teal.withOpacity(0.3),
                        checkmarkColor: Colors.teal,
                        onSelected: (bool selected) {
                          if (selected) {
                            controller.selectedAccommodation.add(type);
                          } else {
                            controller.selectedAccommodation.remove(type);
                          }
                        },
                      );
                    }).toList(),
                  )),
              SizedBox(height: 20),
              _buildSectionTitle('Dietary Preferences (Select multiple)'),
              Obx(() => Wrap(
                    spacing: 8,
                    children: controller.dietaryPreferencesOptions.map((diet) {
                      bool isSelected =
                          controller.dietaryPreferences.contains(diet);
                      return FilterChip(
                        label: Text(diet),
                        selected: isSelected,
                        selectedColor: Colors.teal.withOpacity(0.3),
                        checkmarkColor: Colors.teal,
                        onSelected: (bool selected) {
                          if (selected) {
                            controller.dietaryPreferences.add(diet);
                          } else {
                            controller.dietaryPreferences.remove(diet);
                          }
                        },
                      );
                    }).toList(),
                  )),
              SizedBox(height: 20),
              _buildSectionTitle('Additional Information'),
              _buildCard([
                TextFormField(
                  controller: controller.additionalInfoController,
                  decoration:
                      _inputDecoration('Any specific plans or requirements?'),
                  maxLines: 3,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                  textCapitalization: TextCapitalization.sentences,
                  keyboardType: TextInputType.multiline,
                ),
              ]),
              SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  if (controller.formKey.currentState!.validate()) {
                    // controller.printPostData();
                    Get.snackbar(
                        "Congratulations!", "Travel Post Created Successfully",
                        backgroundColor: Colors.blueGrey,
                        colorText: Colors.white);
                    HapticFeedback.mediumImpact();
                    // Handle form submission
                  }
                },
                child: Text(
                  'Find Travel Buddies',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.teal.shade700,
        ),
      ),
    );
  }

  Widget _buildCard(List<Widget> children) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: children,
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.grey.shade700),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.teal),
      ),
    );
  }
}
