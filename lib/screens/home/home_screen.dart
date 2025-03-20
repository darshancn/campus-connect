import 'package:flutter/material.dart';
import 'navbar.dart';
import 'search_bar.dart';
import 'filter_screen.dart';
import 'map_view_screen.dart';
import 'home_card.dart';
import 'bottom_navbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const Navbar(),
          const SizedBox(height: 10),
          const SearchBarWidget(),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1D97D4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const FilterScreen()));
                  },
                  icon: const Icon(Icons.filter_list, color: Colors.white, size: 24),
                  label: const Text("Filter", style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                      side: const BorderSide(color: Color(0xFF1D97D4)),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const MapViewScreen()));
                  },
                  icon: const Icon(Icons.map, color: Color(0xFF1D97D4), size: 16.5),
                  label: const Text("Map View", style: TextStyle(color: Color(0xFF1D97D4))),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Expanded(child: HomeCard()),
        ],
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
