import 'package:flutter/material.dart';
import '../../../widgets/advertisement_screen.dart';
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: onBackPressed,
        ),
        title: const Text(
          'Search',
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Replaced search container with the advertisement box
          _buildAdvertisementBox(context),

          const SizedBox(height: 5),

          // Profile card section
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

  void _navigateToAdvertisement(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AdvertisementScreen()),
    );
  }

  Widget _buildAdvertisementBox(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToAdvertisement(context),
      child: Container(
        width: double.infinity,
        height: 80,
        margin: const EdgeInsets.symmetric(vertical: 12 ,  horizontal: 12),
        decoration: BoxDecoration(
          color: Color(0xFF797979),
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: const Text(
          "Advertisements",
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
