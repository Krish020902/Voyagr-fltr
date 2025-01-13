import 'package:Voyagr/component/personal_info.dart';
import 'package:Voyagr/component/travel_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  int _currentStep = 0;

  String _personalityType = 'Ambivert';

  Widget _buildProgressBar() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: (_currentStep + 1) / 2,
                  backgroundColor: Colors.grey[700],
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.teal[300]!),
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Step ${_currentStep + 1} of 2',
                style: TextStyle(color: Colors.grey[400]),
              ),
              Text(
                _currentStep == 0 ? 'Personal Info' : 'Travel Preferences',
                style: TextStyle(color: Colors.teal[300]),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTravelPreferencesStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Travel Preferences',
          style: TextStyle(
            color: Colors.grey[100],
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'What best describes your personality?',
          style: TextStyle(color: Colors.grey[300], fontSize: 16),
        ),
        const SizedBox(height: 16),
        _buildPersonalitySelector(),
        const SizedBox(height: 24),
        // Add more travel preferences here
      ],
    );
  }

  Widget _buildPersonalitySelector() {
    return Column(
      children: ['Introvert', 'Extrovert', 'Ambivert'].map((type) {
        return RadioListTile<String>(
          title: Text(type, style: const TextStyle(color: Colors.white)),
          value: type,
          groupValue: _personalityType,
          activeColor: Colors.teal[300],
          onChanged: (String? value) {
            setState(() {
              _personalityType = value!;
            });
          },
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.grey[900]!,
              Colors.grey[850]!,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProgressBar(),
                    const SizedBox(height: 20),
                    _currentStep == 0 ? PersonalInfo() : TravelPreferences(),
                    const SizedBox(height: 32),
                    Row(
                      children: [
                        if (_currentStep > 0)
                          Expanded(
                            child: Container(
                              height: 56,
                              margin: const EdgeInsets.only(right: 8),
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _currentStep--;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey[800],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: const Text(
                                  'Back',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.teal),
                                ),
                              ),
                            ),
                          ),
                        Expanded(
                          child: Container(
                            height: 56,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.teal, Colors.teal.shade400],
                              ),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.teal.withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  if (_currentStep < 1) {
                                    setState(() {
                                      _currentStep++;
                                    });
                                  } else {
                                    // Handle signup completion
                                    print('Signup Complete');
                                    // Add your signup logic here
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                foregroundColor: Colors.white,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: Text(
                                _currentStep < 1 ? 'Next' : 'Sign Up',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
