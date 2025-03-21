import 'package:flutter/material.dart';
import '../widgets/custom_bottom_navbar.dart';
import '../widgets/home_appbar.dart';
import 'home/explore_tab_screen.dart';
import 'home/home_tab_screen.dart';
import 'home/my_chats_tab_screen.dart';
import 'home/my_profile_tab_screen.dart';
import 'home/publication_tab_screen.dart';

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