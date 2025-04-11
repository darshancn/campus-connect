import 'package:flutter/material.dart';
import '../profile_detail_screen.dart'; // <-- Import the screen

class ProfileCard extends StatefulWidget {
  const ProfileCard({super.key});

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  final PageController _pageController = PageController(viewportFraction: 0.95);

  final List<String> imagePaths = [
    'assets/images/sample_image1.png',
    'assets/images/sample_image2.png',
    'assets/images/sample_image3.png',
  ];

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      itemCount: imagePaths.length,
      physics: const PageScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: _buildCard(imagePaths[index]),
        );
      },
    );
  }

  Widget _buildCard(String imagePath) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTapUp: (details) {
        final RenderBox box = context.findRenderObject() as RenderBox;
        final localPosition = box.globalToLocal(details.globalPosition);

        final double buttonAreaTop = MediaQuery.of(context).size.height * 0.65;

        // If user taps ABOVE the button area, navigate
        if (localPosition.dy < buttonAreaTop) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => PageDetailsScreen(imagePath: imagePath),
            ),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(color: Color(0x66000000), blurRadius: 4.5),
          ],
        ),
        child: Column(
          children: [
            // 🖼️ Image section
            Expanded(
              flex: 4,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: SizedBox.expand(
                  child: Image.asset(imagePath, fit: BoxFit.cover),
                ),
              ),
            ),

            // 🎯 Button section
            Expanded(
              flex: 1,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _circleButton(
                      backgroundColor: Colors.black,
                      icon: Icons.close,
                      iconSize: 18,
                      iconColor: Colors.white,
                      onPressed: () {},
                    ),
                    _circleButton(
                      backgroundColor: const Color(0xFF1D97D4),
                      icon: Icons.favorite,
                      iconSize: 25,
                      iconColor: Colors.white,
                      onPressed: () {
                        // Favorite pressed
                      },
                    ),
                    _circleButton(
                      backgroundColor: const Color(0xFFFF9500),
                      icon: Icons.card_giftcard,
                      iconSize: 25,
                      iconColor: Colors.white,
                      onPressed: () {
                        // Gift pressed
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _circleButton({
    required Color backgroundColor,
    required IconData icon,
    required double iconSize,
    required Color iconColor,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
          boxShadow: const [
            BoxShadow(
              color: Color(0x66000000),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Center(child: Icon(icon, size: iconSize, color: iconColor)),
      ),
    );
  }
}
