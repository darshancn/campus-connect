import 'package:flutter/material.dart';
import '../../../widgets/filter_screen.dart';
import '../../../widgets/notification_screen.dart';
import '../widgets/profile_card.dart';

class HomeTab1 extends StatelessWidget {
  final VoidCallback onFilterTap;
  final VoidCallback onMapViewTap;

  const HomeTab1({
    super.key,
    required this.onFilterTap,
    required this.onMapViewTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF1D97D4),
        elevation: 1,
        centerTitle: true,
        flexibleSpace: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Text(
                      'Paris',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(Icons.location_on, color: Colors.white, size: 21),
                  ],
                ),
                const Text(
                  'Campus Connect',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(_createNotificationRoute());
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    padding: const EdgeInsets.fromLTRB(7.0, 4.0, 6.0, 4.0),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.notifications,
                        size: 24,
                        color: Color(0xFF1D97D4),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: const Color(0xFF1D97D4),
            padding: const EdgeInsets.all(15),
            child: Container(
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
              child: const TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                  isDense: true,
                  hintText: 'Search my_profile',
                  hintStyle: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    color: Color(0xFFDCDCDC),
                  ),
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.search,
                    size: 28,
                    color: Color(0xFFDCDCDC),
                  ),
                ),
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14,
                  color: Colors.black,
                ),
                cursorColor: Color(0xFF1D97D4),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                _buildButton(
                  label: 'Filter',
                  icon: Icons.tune,
                  onPressed: onFilterTap,
                ),
                const SizedBox(width: 10),
                _buildButton(
                  label: 'Map View',
                  icon: Icons.map,
                  onPressed: onMapViewTap,
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
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

  Widget _buildButton({
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18, color: Colors.white),
      label: Text(
        label,
        style: const TextStyle(
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      ),
    );
  }

  Route _createNotificationRoute() {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder:
          (context, animation, secondaryAnimation) =>
              const NotificationScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }
}
