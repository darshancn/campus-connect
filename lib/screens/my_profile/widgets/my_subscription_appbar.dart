import 'package:flutter/material.dart';

class MySubscriptionAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const MySubscriptionAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: const Color(0xFF1D97D4),
      elevation: 1,
      centerTitle: true,
      flexibleSpace: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Back Button
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 25,
                ),
              ),

              // Title
              const Text(
                'My Subscription',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),

              // Invisible placeholder to balance the layout
              const SizedBox(width: 24),
            ],
          ),
        ),
      ),
    );
  }
}
