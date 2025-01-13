import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TravelPostController extends GetxController {
  final formKey = GlobalKey<FormState>();
  Rx<DateTime?> startDate = Rx<DateTime?>(null);
  Rx<DateTime?> endDate = Rx<DateTime?>(null);
  RxString selectedTransport = 'Air'.obs;
  RxList<String> interests = <String>[].obs;

  final List<String> transportOptions = ['Air', 'Train', 'Road', 'Sea'];
  final List<String> interestOptions = [
    'Adventure',
    'Culture',
    'Food',
    'History',
    'Nature',
    'Photography',
    'Shopping',
    'Sightseeing',
    'Sports',
    'Relaxation'
  ];
}

class TravelPostPage extends StatelessWidget {
  final TravelPostController controller = Get.put(TravelPostController());

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
              _buildCard([
                TextFormField(
                  decoration: _inputDecoration('Budget per person (in \₹)'),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Required field' : null,
                ),
              ]),
              SizedBox(height: 20),
              _buildSectionTitle('Travel Dates'),
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
              _buildSectionTitle('Travel Interests'),
              _buildCard([
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Obx(() => Wrap(
                        spacing: 8,
                        children: controller.interestOptions.map((interest) {
                          bool isSelected =
                              controller.interests.contains(interest);
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
                      )),
                ),
              ]),
              SizedBox(height: 20),
              _buildSectionTitle('Additional Information'),
              _buildCard([
                TextFormField(
                  decoration:
                      _inputDecoration('Any specific plans or requirements?'),
                  maxLines: 3,
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
