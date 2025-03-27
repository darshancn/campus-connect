import 'package:campus_connect/screens/home/screens/explore_tab_screen.dart';
import 'package:campus_connect/screens/home/screens/home_tab_screen.dart';
import 'package:campus_connect/screens/home/screens/my_chats_tab_screen.dart';
import 'package:campus_connect/screens/home/screens/my_profile_tab_screen.dart';
import 'package:campus_connect/screens/home/screens/publication_tab_screen.dart';
import 'package:campus_connect/screens/home/widgets/custom_bottom_navbar.dart';
import 'package:campus_connect/screens/home/widgets/home_appbar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  final List<Widget> _tabs = const [
    HomeTabScreen(),
    PublicationTabScreen(),
    ExploreTabScreen(),
    MyChatsTabScreen(),
    MyProfileTabScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: HomeAppBar(currentIndex: currentIndex),
      ),
      body: _tabs[currentIndex],
      bottomNavigationBar: CustomBottomNavbar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CustomBottomNavbar.floatingNavButton(
        isSelected: currentIndex == 2,
        onPressed: () => setState(() => currentIndex = 2),
      ),
    );
  }
}