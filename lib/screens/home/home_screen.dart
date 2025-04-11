// import 'package:campus_connect/screens/home/screens/explore_tab_screen.dart';
// import 'package:campus_connect/screens/home/screens/home_tab_screen.dart';
// import 'package:campus_connect/screens/home/screens/my_chats_tab_screen.dart';
// import 'package:campus_connect/screens/home/screens/my_profile_tab_screen.dart';
// import 'package:campus_connect/screens/home/screens/publication_tab_screen.dart';
// import 'package:campus_connect/screens/home/widgets/custom_bottom_navbar.dart';
// import 'package:campus_connect/screens/home/widgets/home_appbar.dart';
// import 'package:flutter/material.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   int currentIndex = 0;
//
//   final List<Widget> _tabs = const [
//     HomeTabScreen(),
//     PublicationTabScreen(),
//     ExploreTabScreen(),
//     MyChatsTabScreen(),
//     MyProfileTabScreen(),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: Colors.white,
//       appBar:
//           currentIndex == 4
//               ? null
//               : PreferredSize(
//                 preferredSize: const Size.fromHeight(70),
//                 child: HomeAppBar(currentIndex: currentIndex),
//               ),
//       body: _tabs[currentIndex],
//       bottomNavigationBar: CustomBottomNavbar(
//         currentIndex: currentIndex,
//         onTap: (index) => setState(() => currentIndex = index),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       floatingActionButton: CustomBottomNavbar.floatingNavButton(
//         isSelected: currentIndex == 2,
//         onPressed: () => setState(() => currentIndex = 2),
//       ),
//     );
//   }
// }







// ---------------------------------------------------------------------------






import 'package:campus_connect/screens/explore/explore_tab_screen.dart';
import 'package:campus_connect/screens/home/home_tab_screen.dart';
import 'package:campus_connect/screens/chat/tab/my_chats_tab_screen.dart';
import 'package:campus_connect/screens/my_profile/my_profile_tab_screen.dart';
import 'package:campus_connect/screens/publication/publication_tab_screen.dart';
import 'package:campus_connect/widgets/custom_bottom_navbar.dart';
import 'package:campus_connect/screens/home/widgets/home_appbar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  final GlobalKey<MyProfileTabScreenState> profileKey =
      GlobalKey<MyProfileTabScreenState>();

  @override
  Widget build(BuildContext context) {
    final List<Widget> tabs = [
      const HomeTabScreen(),
      const PublicationTabScreen(),
      const ExploreTabScreen(),
      const MyChatsTabScreen(),
      MyProfileTabScreen(key: profileKey),
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: (currentIndex == 0 || currentIndex == 4)
          ? null
          : PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: HomeAppBar(currentIndex: currentIndex),
      ),
      body: tabs[currentIndex],
      bottomNavigationBar: CustomBottomNavbar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
            if (index == 4) {
              profileKey.currentState?.resetToMain();
            }
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CustomBottomNavbar.floatingNavButton(
        isSelected: currentIndex == 2,
        onPressed: () => setState(() => currentIndex = 2),
      ),
    );
  }
}
