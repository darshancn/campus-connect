import 'package:flutter/material.dart';

class CustomBottomNavbar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavbar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 80,
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          navItem(icon: Icons.home, label: "Home", index: 0),
          navItem(icon: Icons.description, label: "Publications", index: 1),
          const SizedBox(width: 64), // Leave space for the FAB
          navItem(icon: Icons.chat, label: "My Chats", index: 3),
          navItem(icon: Icons.person, label: "My Profile", index: 4),
        ],
      ),
    );
  }

  Widget navItem({required IconData icon, required String label, required int index}) {
    final isSelected = currentIndex == index;
    final color = isSelected ? const Color(0xFFFF9500) : Colors.white;

    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 24, color: color),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  /// Center FAB with shadow and no border
  static Widget floatingNavButton({
    required bool isSelected,
    required VoidCallback onPressed,
  }) {
    return Container(
      margin: const EdgeInsets.only(top: 35),
      height: 80,
      width: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: const Color(0x66000000),
            blurRadius: 6.6,
            spreadRadius: 0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: FloatingActionButton(
        backgroundColor: Colors.white,
        elevation: 0,
        onPressed: onPressed,
        shape: const CircleBorder(), // No border now
        child: Icon(
          Icons.search,
          size: 33,
          color: isSelected ? const Color(0xFFFF9500) : Colors.black,
        ),
      ),
    );
  }
}