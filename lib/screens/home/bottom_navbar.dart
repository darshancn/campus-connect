import 'package:flutter/material.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home, color: Colors.orange), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.public, color: Colors.white), label: "Publications"),
        BottomNavigationBarItem(icon: Icon(Icons.search, color: Colors.black, size: 33), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.chat, color: Colors.white), label: "My Chats"),
        BottomNavigationBarItem(icon: Icon(Icons.person, color: Colors.white), label: "My Profile"),
      ],
    );
  }
}
