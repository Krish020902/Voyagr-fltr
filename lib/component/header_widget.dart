import 'package:Voyagr/pages/filter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({Key? key}) : super(key: key);

  void _filterPressed() {
    print('Filter Pressed');
    Get.to(FilterPage());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(Icons.location_on, color: Colors.grey[600]),
                  const SizedBox(width: 8),
                  Text(
                    'location...',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
          Text(
            'VOYAGR',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.teal[700],
              letterSpacing: 1,
            ),
          ),
          const SizedBox(width: 16),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 4,
                  ),
                ],
              ),
              child: GestureDetector(
                onTap: _filterPressed,
                child: Row(
                  children: [
                    Icon(Icons.tune, color: Colors.grey[600]),
                    const SizedBox(width: 5),
                    Text(
                      'Filters',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
