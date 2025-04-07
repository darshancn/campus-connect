import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../screens/explore_detail_screen.dart';

class RejectedByMeTab extends StatelessWidget {
  const RejectedByMeTab({super.key});

  final List<Map<String, String>> users = const [
    {
      'image': 'assets/images/rejected_user1.png',
      'name': 'Léa Rossi, 36',
      'distance': '2km',
      'tag': 'none',
    },
    {
      'image': 'assets/images/rejected_user2.png',
      'name': 'Sofia Lee, 29',
      'distance': '4km',
      'tag': 'none',
    },
    {
      'image': 'assets/images/rejected_user3.png',
      'name': 'Maria Kim, 31',
      'distance': '3km',
      'tag': 'premium',
    },
    {
      'image': 'assets/images/rejected_user4.png',
      'name': 'Isabelle Wu, 28',
      'distance': '6km',
      'tag': 'gold',
    },
    {
      'image': 'assets/images/new_match5.png',
      'name': 'Nina Singh, 30',
      'distance': '5km',
      'tag': 'none',
    },
    {
      'image': 'assets/images/new_match6.png',
      'name': 'Zara Chen, 27',
      'distance': '1.5km',
      'tag': 'none',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.75,
      ),
      itemCount: users.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final user = users[index];

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 150),
                pageBuilder: (_, __, ___) => const ExploreDetailScreen(),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: AssetImage(user['image']!),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromARGB(0, 0, 0, 0),
                        Color.fromARGB(179, 0, 0, 0),
                      ],
                      stops: [0.3, 1],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                ),
                Positioned(
                  top: 12,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFAE8FF),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
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
                ),
                Positioned(
                  left: 12,
                  right: 12,
                  bottom: 12,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (user['tag'] == 'premium')
                        const PremiumTag()
                      else if (user['tag'] == 'gold')
                        const GoldTag(),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Text(
                              user['name']!,
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: Colors.white,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 6),
                          SvgPicture.asset(
                            'assets/images/green_tick.svg',
                            width: 18,
                            height: 18,
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'About',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w300,
                          fontSize: 9,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class PremiumTag extends StatelessWidget {
  const PremiumTag({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 24,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/images/crown_black.png', width: 10, height: 10),
          const SizedBox(width: 4),
          const Text(
            'Premium',
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              fontSize: 8,
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
      width: 61,
      height: 24,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Color(0xFFE8B903),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/images/crown_white.png', width: 14, height: 14),
          const SizedBox(width: 4),
          const Text(
            'Gold',
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              fontSize: 10,
              color: Colors.white,
              height: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}
