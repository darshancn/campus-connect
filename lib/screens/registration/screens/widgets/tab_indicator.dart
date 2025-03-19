import 'package:flutter/material.dart';

class TabIndicator extends StatelessWidget {
  final int currentIndex;
  final int totalTabs;

  const TabIndicator({super.key, required this.currentIndex, required this.totalTabs});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        totalTabs,
            (index) => Container(
          width: index == currentIndex ? 34 : 18,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: index == currentIndex ? const Color(0xFFD31F34) : Colors.grey,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
