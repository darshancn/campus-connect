import 'package:flutter/material.dart';
import '../../widgets/filter_screen.dart';
import 'tabs/home_tab1.dart';
import 'tabs/home_tab2.dart';

class HomeTabScreen extends StatefulWidget {
  const HomeTabScreen({super.key});

  @override
  State<HomeTabScreen> createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTabScreen> {
  bool showTab2 = false;

  void switchToTab2() {
    if (!mounted) return;
    setState(() => showTab2 = true);
  }

  void switchToTab1() {
    if (!mounted) return;
    setState(() => showTab2 = false);
  }

  Future<void> openFilterScreen(BuildContext context) async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => const FilterScreen()),
    );

    // Ensure we only switch if the result is true
    if (result == true) {
      switchToTab2();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: showTab2
          ? HomeTab2(onBackPressed: switchToTab1)
          : HomeTab1(onSwitchTab: () => openFilterScreen(context)),
    );
  }
}
