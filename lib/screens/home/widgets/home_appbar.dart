import 'package:flutter/material.dart';
import '../../../widgets/notification_screen.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int currentIndex;

  const HomeAppBar({super.key, required this.currentIndex});

  String getTitle() {
    switch (currentIndex) {
      case 1:
        return "Publications";
      case 2:
        return "Explore";
      case 3:
        return "My Chats";
      case 4:
        return "My Profile";
      default:
        return "";
    }
  }

  @override
  Size get preferredSize =>
      currentIndex == 0
          ? const Size.fromHeight(100)
          : const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    final title = getTitle();

    return AppBar(
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
              Row(
                children: const [
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
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(_createRoute());
                },
                child: Container(
                  width: 40,
                  height: 40,
                  padding: const EdgeInsets.fromLTRB(7.0, 4.0, 6.0, 4.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    // boxShadow: const [
                    //   BoxShadow(color: Color(0x66000000), blurRadius: 4),
                    // ],
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
    );
  }

  Route _createRoute() {
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
