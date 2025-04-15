import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../profile_detail_screen.dart';
import 'gift_drawer.dart';

final List<Map<String, dynamic>> users = [
  {'tag': 'premium', 'name': 'Elise Öztürk', 'age': '28', 'distance': '1.5 km'},
  {'tag': 'gold', 'name': 'James Smith', 'age': '32', 'distance': '2.8 km'},
  {'tag': 'premium', 'name': 'Anna Lee', 'age': '26', 'distance': '0.8 km'},
  {'tag': 'gold', 'name': 'Robert Brown', 'age': '35', 'distance': '3.0 km'},
  {
    'tag': 'premium',
    'name': 'Linda Johnson',
    'age': '29',
    'distance': '1.9 km',
  },
  {'tag': 'gold', 'name': 'David Wilson', 'age': '31', 'distance': '2.5 km'},
];

final List<String> imagePaths = [
  'assets/images/sample_image1.png',
  'assets/images/sample_image2.png',
  'assets/images/sample_image3.png',
  'assets/images/like.png',
  'assets/images/like_by_me1.png',
  'assets/images/like_by_me2.png',
];

class ProfileCard extends StatefulWidget {
  const ProfileCard({super.key});

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  final PageController _pageController = PageController(viewportFraction: 0.95);

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
          child: _buildCard(imagePaths[index], users[index]),
        );
      },
    );
  }

  Widget _buildCard(String imagePath, Map<String, dynamic> user) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTapUp: (details) {
        final RenderBox box = context.findRenderObject() as RenderBox;
        final localPosition = box.globalToLocal(details.globalPosition);
        final double buttonAreaTop = MediaQuery.of(context).size.height * 0.65;
        if (localPosition.dy < buttonAreaTop) {
          _navigateToDetailsInstantly(imagePath);
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
            // Image section with overlays
            Expanded(
              flex: 4,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Stack(
                      children: [
                        // Background image
                        SizedBox.expand(
                          child: Image.asset(imagePath, fit: BoxFit.cover),
                        ),
                        // Bottom left overlay: user details
                        Positioned(
                          left: constraints.maxWidth * 0.03,
                          right: constraints.maxWidth * 0.03,
                          bottom: constraints.maxHeight * 0.03,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Tag display (Premium or Gold)
                              if (user['tag'] == 'premium')
                                const PremiumTag()
                              else if (user['tag'] == 'gold')
                                const GoldTag(),
                              const SizedBox(height: 6),
                              // User name, age, verification tick and location info
                              Stack(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          '${user['name']}, ${user['age']}',
                                          style: const TextStyle(
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 24,
                                            color: Colors.white,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      SvgPicture.asset(
                                        'assets/images/green_tick.svg',
                                        width: 24,
                                        height: 24,
                                      ),
                                    ],
                                  ),
                                  // Fixed location container at the utmost right of the row
                                  Positioned(
                                    right: 0,
                                    top: 0,
                                    bottom: 0,
                                    child: Container(
                                      width: 90,
                                      height: 25,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFAE8FF),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.location_on,
                                            size: 12,
                                            color: Colors.black,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            '${user['distance']} Away',
                                            style: const TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'About',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 2),
                              const Text(
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w300,
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            // Action buttons section
            Expanded(
              flex: 1,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _circleButton(
                      backgroundColor: Colors.black,
                      icon: Icons.close,
                      iconSize: 18,
                      iconColor: Colors.white,
                      onPressed: () => _navigateToDetailsInstantly(imagePath),
                    ),
                    const SizedBox(width: 16),
                    _circleButton(
                      backgroundColor: const Color(0xFF1D97D4),
                      icon: Icons.favorite,
                      iconSize: 25,
                      iconColor: Colors.white,
                      onPressed: () {
                        // Favorite pressed
                      },
                    ),
                    const SizedBox(width: 16),
                    _circleButton(
                      backgroundColor: const Color(0xFFFF9500),
                      icon: Icons.card_giftcard,
                      iconSize: 25,
                      iconColor: Colors.white,
                      onPressed:
                          () => showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (_) => const GiftDrawer(),
                          ),
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

  void _navigateToDetailsInstantly(String imagePath) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => PageDetailsScreen(imagePath: imagePath),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );
  }
}

class PremiumTag extends StatelessWidget {
  const PremiumTag({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 28,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/images/crown_black.png', width: 15, height: 15),
          const SizedBox(width: 4),
          const Text(
            'Premium',
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Colors.black,
              height: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}

class GoldTag extends StatelessWidget {
  const GoldTag({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 28,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFE8B903),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/images/crown_white.png', width: 18, height: 18),
          const SizedBox(width: 4),
          const Text(
            'Gold',
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Colors.white,
              height: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}
