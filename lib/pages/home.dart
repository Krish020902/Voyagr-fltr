import 'package:Voyagr/component/bottom_navigation.dart';
import 'package:Voyagr/component/card_swipper.dart';
import 'package:Voyagr/component/header_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          children: [
            HeaderWidget(),
            Expanded(
              child: CardSwipperWidget(),
            ),
            BottomNavigation()
          ],
        ),
      ),
    );
  }
}
