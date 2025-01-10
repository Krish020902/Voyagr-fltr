import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? _token;
  Map<String, dynamic>? _userData;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      // _token = prefs.getString('token');
      // print(_token);
      _userData = jsonDecode(prefs.getString('user') ?? '{}');
      print(_userData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: _userData == null
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 16),
                  Text('User Data:'),
                  Text('ID: ${_userData?['id']}'),
                  Text('Email: ${_userData?['email']}'),
                  Text('First Name: ${_userData?['first_name']}'),
                  Text('Last Name: ${_userData?['last_name']}'),
                  // Add more fields as needed
                ],
              ),
      ),
    );
  }
}
