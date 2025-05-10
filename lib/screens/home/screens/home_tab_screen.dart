import 'package:flutter/material.dart';

import '../../filter_screen.dart';
import '../../map_view_screen.dart';
import '../widgets/profile_card.dart';

class HomeTabScreen extends StatelessWidget {
  const HomeTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔵 Blue background just for the search bar
          Container(
            color: const Color(0xFF1D97D4),
            padding: const EdgeInsets.all(15),
            child: Container(
              width: double.infinity,
              height: 52,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.25),
                    blurRadius: 4,
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Center(
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    isDense: true,
                    hintText: 'Search profile',
                    hintStyle: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Color(0xFFDCDCDC),
                    ),
                    border: InputBorder.none,
                    prefixIcon: const Icon(
                      Icons.search,
                      size: 28,
                      color: Color(0xFFDCDCDC),
                    ),
                  ),
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                  cursorColor: Color(0xFF1D97D4),
                ),
              ),
            ),
          ),

          const SizedBox(height: 5),

          // 🔘 Buttons Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                // Filter Button with smooth transition
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(
                      context,
                    ).push(_createRoute(const FilterScreen()));
                  },
                  icon: Icon(Icons.tune, size: 18, color: Colors.white),
                  label: Text(
                    'Filter',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1D97D4),
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    minimumSize: const Size(78, 32),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                  ),
                ),
                const SizedBox(width: 10),

                // Map View Button with smooth transition
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(
                      context,
                    ).push(_createRoute(const MapViewScreen()));
                  },
                  icon: Icon(Icons.map, size: 16.5, color: Colors.white),
                  label: Text(
                    'Map View',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1D97D4),
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    minimumSize: const Size(113, 32),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 5),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                children: const [
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

  Route _createRoute(Widget screen) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 3),
      reverseTransitionDuration: const Duration(milliseconds: 20),
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final tween = Tween<Offset>(
          begin: const Offset(1.0, 0.0), // Slide from right
          end: Offset.zero,
        ).chain(CurveTween(curve: Curves.easeInOut));

        return SlideTransition(position: animation.drive(tween), child: child);
      },
    );
  }
}
