import 'package:flutter/material.dart';
import '../tabs/like_me_tab.dart';
import '../tabs/favorite_publication_tab.dart';
import '../tabs/favorites_tab.dart';
import '../tabs/like_by_me_tab.dart';
import '../tabs/match_profile_tab.dart';
import '../tabs/new_match_tab.dart';
import '../tabs/rejected_by_me_tab.dart';

class ExploreTabScreen extends StatefulWidget {
  const ExploreTabScreen({super.key});

  @override
  State<ExploreTabScreen> createState() => _ExploreTabScreenState();
}

class _ExploreTabScreenState extends State<ExploreTabScreen> {
  final List<String> tabTitles = [
    'New Match',
    'Like Me',
    'Like By Me',
    'Match Profile',
    'Favorites',
    'Favorite Publication',
    'Rejected by me',
  ];

  int selectedIndex = 0;

  final List<Widget> tabs = const [
    NewMatchTab(),
    LikeMeTab(),
    LikeByMeTab(),
    MatchProfileTab(),
    FavoritesTab(),
    FavoritePublicationTab(),
    RejectedByMeTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),

        // Tab Bar
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16 , vertical: 5),

          child: Row(
            children: List.generate(tabTitles.length, (index) {
              final isSelected = index == selectedIndex;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: GestureDetector(
                  onTap: () => setState(() => selectedIndex = index),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFFFF9500) : Colors.white,
                      borderRadius: BorderRadius.circular(37),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x40000000),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Text(
                      tabTitles[index],
                      style: TextStyle(
                        fontSize: 14,
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),

        const SizedBox(height: 5),

        // Tab Content
        Expanded(
          child: Container(
            child: tabs[selectedIndex],
          ),
        ),
      ],
    );
  }
}
