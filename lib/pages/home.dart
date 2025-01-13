import 'package:Voyagr/component/bottom_navigation.dart';
import 'package:Voyagr/component/card_swipper.dart';
import 'package:Voyagr/component/header_widget.dart';
import 'package:Voyagr/pages/chat.dart';
import 'package:Voyagr/pages/post.dart';
import 'package:flutter/material.dart';
import 'package:Voyagr/pages/profile.dart';
import 'package:Voyagr/pages/matches.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // List of pages to display based on the selected index
  final List<Widget> _pages = [
    Column(
      children: [
        HeaderWidget(),
        Expanded(
          child: CardSwipperWidget(),
        ),
      ],
    ),
    MatchesPage(),
    Center(child: ChatPage()),
    Center(child: TravelPostPage()),
    ProfilePage(),
  ];

  // Update the selected index when navigation item is tapped
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          children: [
            // HeaderWidget(),
            Expanded(
              child: _pages[_selectedIndex],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
