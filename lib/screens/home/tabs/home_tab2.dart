import 'package:flutter/material.dart';
import '../widgets/advertisements_box.dart';
import '../widgets/profile_card.dart';

class HomeTab2 extends StatelessWidget {
  final VoidCallback onBackPressed;

  const HomeTab2({super.key, required this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1D97D4),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'Search',
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            fontSize: 20,
            height: 1.0,
            letterSpacing: 0,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: onBackPressed,
        ),
      ),
      body: Column(
        children: [
          const AdvertisementsBox(),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Column(
                children: [
                  Expanded(child: ProfileCard()),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
