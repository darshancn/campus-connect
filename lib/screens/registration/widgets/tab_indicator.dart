import 'package:flutter/material.dart';

class TabIndicator extends StatelessWidget {
  final int currentIndex;
  final int totalTabs;

  const TabIndicator({super.key, required this.currentIndex, required this.totalTabs});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            totalTabs,
                (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              width: index == currentIndex ? 34 : 18,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: index == currentIndex ? const Color(0xFFD31F34) : const Color(0xFFD9D9D9),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
