import 'package:flutter/material.dart';
import 'carousel_slider.dart';
import 'action_buttons.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(51), // Equivalent to 0.2 opacity
            offset: Offset(0, 0),
            blurRadius: 4.5,
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CarouselSliderWidget(),

          const ActionButtons(),
        ],
      ),
    );
  }
}
