import 'package:flutter/material.dart';

class AdvertisementsBox extends StatelessWidget {
  const AdvertisementsBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(16),
      height: 80,
      decoration: BoxDecoration(
        color: const Color(0xFF797979),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(
        child: Text(
          'Advertisements',
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
