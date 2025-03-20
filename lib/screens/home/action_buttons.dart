import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white, // White background
          // borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              spreadRadius: 2,
              offset: const Offset(0, 9),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildButton(Colors.black, Icons.close, Colors.white),
            const SizedBox(width: 20),
            _buildButton(const Color(0xFF1D97D4), Icons.favorite, Colors.white),
            const SizedBox(width: 20),
            _buildButton(const Color(0xFFFF9500), Icons.card_giftcard, Colors.white),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(Color bgColor, IconData icon, Color iconColor) {
    return CircleAvatar(
      radius: 33.5,
      backgroundColor: bgColor,
      child: Icon(icon, size: 25, color: iconColor),
    );
  }
}
