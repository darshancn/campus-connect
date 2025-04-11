import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import '../../tabs/buy_credit_tab.dart';
import '../../tabs/credit_history_tab.dart';
import '../../widgets/profile_appbar.dart';

class BuyCreditScreen extends StatefulWidget {
  const BuyCreditScreen({super.key});

  @override
  State<BuyCreditScreen> createState() => _BuyCreditScreenState();
}

class _BuyCreditScreenState extends State<BuyCreditScreen> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF1D97D4),
      appBar: const ProfileAppBar(title: 'Buy Credit'),
      body: Stack(
        children: [
          // Dotted border circle
          Positioned(
            top: screenHeight * 0.017, // ~122px
            left: screenWidth / 2 - 108.5,
            child: DottedBorder(
              borderType: BorderType.Circle,
              color: Colors.white,
              strokeWidth: 1,
              dashPattern: const [10, 10],
              child: Container(
                width: 213,
                height: 213,
                decoration: const BoxDecoration(shape: BoxShape.circle),
              ),
            ),
          ),

          // Gradient circle
          Positioned(
            top: screenHeight * 0.03,
            left: (screenWidth / 2) - 99.5, // Centering the 199 width circle
            child: Container(
              width: 199,
              height: 199,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Color(0xFFFFFFFF), Color(0xFFFFF2E1)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  top:
                      MediaQuery.of(context).size.height *
                      0.04, // 4% of screen height
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text(
                      '950',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: 28,
                        height: 1.0,
                        letterSpacing: 0,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8), // spacing between texts
                    Text(
                      'Your Credit Points',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        height: 1.0,
                        letterSpacing: 0,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Main content container
          Positioned(
            top: screenHeight * 0.15,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(45),
                  topRight: Radius.circular(45),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 30),

                  // Tab buttons
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildTabButton('Buy Credit', 0, isLeft: true),
                        _buildTabButton('Credit History', 1, isLeft: false),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Selected Tab Content
                  Expanded(
                    child:
                        selectedTab == 0
                            ? const BuyCreditTab()
                            : const CreditHistoryTab(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String text, int index, {required bool isLeft}) {
    final isSelected = selectedTab == index;

    return GestureDetector(
      onTap: () => setState(() => selectedTab = index),
      child: Container(
        width: 161,
        height: 52,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1D97D4) : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(isLeft ? 52 : 0),
            bottomLeft: Radius.circular(isLeft ? 52 : 0),
            topRight: Radius.circular(!isLeft ? 52 : 0),
            bottomRight: Radius.circular(!isLeft ? 52 : 0),
          ),
          boxShadow: const [BoxShadow(color: Color(0x40000000), blurRadius: 4)],
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
