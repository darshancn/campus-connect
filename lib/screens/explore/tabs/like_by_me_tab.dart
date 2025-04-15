import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../explore_detail_screen.dart';

class LikeByMeTab extends StatelessWidget {
  const LikeByMeTab({super.key});

  final List<Map<String, String>> users = const [
    {
      'image': 'assets/images/like_by_me1.png',
      'name': 'Luna Taylor, 25',
      'distance': '2.5km',
      'tag': 'gold',
    },
    {
      'image': 'assets/images/like_by_me2.png',
      'name': 'Jasmine Brooks, 30',
      'distance': '1.7km',
      'tag': 'none',
    },
    {
      'image': 'assets/images/like_by_me3.png',
      'name': 'Naomi Reed, 28',
      'distance': '3km',
      'tag': 'premium',
    },
    {
      'image': 'assets/images/like_by_me4.png',
      'name': 'Claire Bennett, 33',
      'distance': '4.2km',
      'tag': 'premium',
    },
    {
      'image': 'assets/images/like_me1.png',
      'name': 'Emily Park, 26',
      'distance': '3.2km',
      'tag': 'none',
    },
    {
      'image': 'assets/images/like_me2.png',
      'name': 'Alicia Stone, 32',
      'distance': '1.8km',
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
                pageBuilder: (_, __, ___) =>  ExploreDetailScreen(imagePath: user['image']!,),
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
