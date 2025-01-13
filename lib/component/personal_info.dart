import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonalInfoContainer extends GetxController {
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();
  var selectedGender = 'Prefer not to say'.obs;

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.onClose();
  }
}

class PersonalInfo extends StatelessWidget {
  final PersonalInfoContainer personalInfoController =
      Get.put(PersonalInfoContainer());

  PersonalInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Personal Information',
          style: TextStyle(
            color: Colors.grey[100],
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24),
        TextFormField(
          controller: personalInfoController.firstNameController,
          style: const TextStyle(color: Colors.white),
          decoration: _buildInputDecoration('First Name', Icons.person),
          validator: (value) =>
              value?.isEmpty ?? true ? 'Please enter your first name' : null,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: personalInfoController.lastNameController,
          style: const TextStyle(color: Colors.white),
          decoration: _buildInputDecoration('Last Name', Icons.person_outline),
          validator: (value) =>
              value?.isEmpty ?? true ? 'Please enter your last name' : null,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: personalInfoController.phoneController,
          style: const TextStyle(color: Colors.white),
          decoration: _buildInputDecoration('Phone Number', Icons.phone),
          keyboardType: TextInputType.phone,
          validator: (value) =>
              value?.isEmpty ?? true ? 'Please enter your phone number' : null,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: personalInfoController.addressController,
          style: const TextStyle(color: Colors.white),
          decoration: _buildInputDecoration('Address', Icons.home),
          maxLines: 2,
          validator: (value) =>
              value?.isEmpty ?? true ? 'Please enter your address' : null,
        ),
        const SizedBox(height: 16),
        Obx(() => DropdownButtonFormField<String>(
              value: personalInfoController.selectedGender.value,
              style: const TextStyle(color: Colors.white),
              dropdownColor: Colors.grey[800],
              decoration: _buildInputDecoration('Gender', Icons.people),
              items: ['Male', 'Female', 'Non-binary', 'Prefer not to say']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  personalInfoController.selectedGender.value = newValue;
                }
              },
            )),
      ],
    );
  }

  InputDecoration _buildInputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.grey[400]),
      prefixIcon: Icon(icon, color: Colors.teal.withOpacity(0.7)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.grey[700]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.teal, width: 2),
      ),
      filled: true,
      fillColor: Colors.grey[800]!.withOpacity(0.5),
    );
  }
}
