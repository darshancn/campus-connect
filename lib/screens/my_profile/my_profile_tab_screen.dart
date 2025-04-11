import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/badges_and_rewards/badges_rewards_screen.dart';
import 'screens/buy_credit/buy_credit_screen.dart';
import 'screens/your_profile/my_profile_screen.dart';
import 'screens/my_subscription/my_subscription_screen.dart';
import 'screens/privacy/privacy_screen.dart';
import 'widgets/logout_modal.dart';

enum ProfileSection { main, mySubscription, privacy, badgesRewards }

class MyProfileTabScreen extends StatefulWidget {
  const MyProfileTabScreen({super.key});

  @override
  State<MyProfileTabScreen> createState() => MyProfileTabScreenState();
}

class MyProfileTabScreenState extends State<MyProfileTabScreen> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  ProfileSection selectedSection = ProfileSection.main;

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }

  void resetToMain() {
    setState(() {
      selectedSection = ProfileSection.main;
    });
  }

  Future<void> _loadProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    final imagePath = prefs.getString('profile_image');
    if (imagePath != null) {
      final file = File(imagePath);
      if (await file.exists()) {
        setState(() {
          _image = file;
        });
      }
    }
  }

  Future<void> _saveImage(File image) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('profile_image', image.path);
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      setState(() {
        _image = file;
      });
      _saveImage(file);
    }
  }

  Widget _buildProfilePicture() {
    return Center(
      child: Stack(
        alignment: Alignment.bottomCenter,
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            radius: 57,
            backgroundColor: const Color(0xFF343434),
            backgroundImage: _image != null ? FileImage(_image!) : null,
            child:
                _image == null
                    ? const Icon(Icons.person, size: 40, color: Colors.white)
                    : null,
          ),
          Positioned(
            bottom: -14,
            child: GestureDetector(
              onTap: _pickImage,
              child: const CircleAvatar(
                radius: 16,
                backgroundColor: Color(0xFF797979),
                child: Icon(Icons.camera_alt, size: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionTile(IconData icon, String text, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 8),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(color: Color(0x40000000), blurRadius: 4),
            ],
          ),
          child: Row(
            children: [
              const SizedBox(width: 20),
              Icon(icon, size: 24),
              const SizedBox(width: 20),
              Text(text, style: const TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainProfileMenu() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 40),
          _buildProfilePicture(),
          const SizedBox(height: 30),
          _buildOptionTile(Icons.person, 'Your Profile', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const YourProfileScreen()),
            );
          }),
          _buildOptionTile(Icons.subscriptions, 'My Subscription', () {
            setState(() {
              selectedSection = ProfileSection.mySubscription;
            });
          }),
          _buildOptionTile(Icons.privacy_tip, 'Privacy', () {
            setState(() {
              selectedSection = ProfileSection.privacy;
            });
          }),
          _buildOptionTile(Icons.credit_score, 'Buy Credit', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const BuyCreditScreen()),
            );
          }),
          _buildOptionTile(Icons.emoji_events, 'Badges and Rewards', () {
            setState(() {
              selectedSection = ProfileSection.badgesRewards;
            });
          }),
        ],
      ),
    );
  }

  Widget _buildCustomAppBar() {
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
                'My Profile',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              GestureDetector(
                onTap:
                    () => showDialog(
                      context: context,
                      builder: (context) => const LogoutModal(),
                    ),
                child: Image.asset(
                  'assets/images/logout.png',
                  width: 28,
                  height: 28,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBodyContent() {
    switch (selectedSection) {
      case ProfileSection.mySubscription:
        return const MySubscriptionScreen();
      case ProfileSection.privacy:
        return const PrivacyScreen();
      case ProfileSection.badgesRewards:
        return const BadgesRewardsScreen();
      case ProfileSection.main:
      default:
        return _buildMainProfileMenu();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:
          selectedSection == ProfileSection.main
              ? PreferredSize(
                preferredSize: const Size.fromHeight(70),
                child: _buildCustomAppBar(),
              )
              : null,
      body: SizedBox.expand(child: _buildBodyContent()),
    );
  }
}






// ----------------------------------------------------------






// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:campus_connect/screens/my_profile/screens/my_profile_screen.dart';
// import 'package:campus_connect/screens/my_profile/screens/buy_credit_screen.dart';
// import 'package:campus_connect/screens/my_profile/screens/my_subscription_screen.dart';
// import 'package:campus_connect/screens/my_profile/screens/privacy_screen.dart';
// import 'package:campus_connect/screens/my_profile/screens/badges_rewards_screen.dart';
// import '../../my_profile/widgets/logout_modal.dart';
//
// enum ProfileSection { main, mySubscription, privacy, badgesRewards }
//
// class MyProfileTabScreen extends StatefulWidget {
//   const MyProfileTabScreen({super.key});
//
//   @override
//   State<MyProfileTabScreen> createState() => _MyProfileTabScreenState();
// }
//
// class _MyProfileTabScreenState extends State<MyProfileTabScreen> {
//   File? _image;
//   final ImagePicker _picker = ImagePicker();
//   ProfileSection selectedSection = ProfileSection.main;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadProfileImage();
//   }
//
//   Future<void> _loadProfileImage() async {
//     final prefs = await SharedPreferences.getInstance();
//     final imagePath = prefs.getString('profile_image');
//
//     if (imagePath != null) {
//       final file = File(imagePath);
//       if (await file.exists()) {
//         setState(() {
//           _image = file;
//         });
//       }
//     }
//   }
//
//   Future<void> _saveImage(File image) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('profile_image', image.path);
//   }
//
//   Future<void> _pickImage() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       final file = File(pickedFile.path);
//       setState(() {
//         _image = file;
//       });
//       _saveImage(file);
//     }
//   }
//
//   Widget _buildProfilePicture() {
//     return Center(
//       child: Stack(
//         alignment: Alignment.bottomCenter,
//         clipBehavior: Clip.none,
//         children: [
//           CircleAvatar(
//             radius: 57,
//             backgroundColor: const Color(0xFF343434),
//             backgroundImage: _image != null ? FileImage(_image!) : null,
//             child:
//                 _image == null
//                     ? const Icon(Icons.person, size: 40, color: Colors.white)
//                     : null,
//           ),
//           Positioned(
//             bottom: -14,
//             child: GestureDetector(
//               onTap: _pickImage,
//               child: const CircleAvatar(
//                 radius: 16,
//                 backgroundColor: Color(0xFF797979),
//                 child: Icon(Icons.camera_alt, size: 16, color: Colors.white),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildOptionTile(IconData icon, String text, VoidCallback onTap) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 8),
//       child: InkWell(
//         onTap: onTap,
//         child: Container(
//           height: 60,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(10),
//             boxShadow: const [
//               BoxShadow(color: Color(0x40000000), blurRadius: 4),
//             ],
//           ),
//           child: Row(
//             children: [
//               const SizedBox(width: 20),
//               Icon(icon, size: 24),
//               const SizedBox(width: 20),
//               Text(text, style: const TextStyle(fontSize: 16)),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildMainProfileMenu() {
//     return Column(
//       children: [
//         const SizedBox(height: 40),
//         _buildProfilePicture(),
//         const SizedBox(height: 30),
//         _buildOptionTile(Icons.person, 'Your Profile', () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (_) => const YourProfileScreen()),
//           );
//         }),
//         _buildOptionTile(Icons.subscriptions, 'My Subscription', () {
//           setState(() {
//             selectedSection = ProfileSection.mySubscription;
//           });
//         }),
//         _buildOptionTile(Icons.privacy_tip, 'Privacy', () {
//           setState(() {
//             selectedSection = ProfileSection.privacy;
//           });
//         }),
//         _buildOptionTile(Icons.credit_score, 'Buy Credit', () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (_) => const BuyCreditScreen()),
//           );
//         }),
//         _buildOptionTile(Icons.emoji_events, 'Badges and Rewards', () {
//           setState(() {
//             selectedSection = ProfileSection.badgesRewards;
//           });
//         }),
//       ],
//     );
//   }
//
//   Widget _buildBackButton() {
//     return Padding(
//       padding: const EdgeInsets.only(top: 40, left: 16),
//       child: Align(
//         alignment: Alignment.centerLeft,
//         child: IconButton(
//           icon: const Icon(Icons.arrow_back, size: 28),
//           onPressed: () {
//             setState(() {
//               selectedSection = ProfileSection.main;
//             });
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget _buildCustomAppBar() {
//     return AppBar(
//       automaticallyImplyLeading: false,
//       backgroundColor: const Color(0xFF1D97D4),
//       elevation: 1,
//       centerTitle: true,
//       flexibleSpace: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Row(
//                 children: [
//                   Text(
//                     'Paris',
//                     style: TextStyle(
//                       fontFamily: 'Inter',
//                       fontWeight: FontWeight.w500,
//                       fontSize: 16,
//                       color: Colors.white,
//                     ),
//                   ),
//                   SizedBox(width: 4),
//                   Icon(Icons.location_on, color: Colors.white, size: 21),
//                 ],
//               ),
//               const Text(
//                 'My Profile',
//                 style: TextStyle(
//                   fontFamily: 'Inter',
//                   fontWeight: FontWeight.w700,
//                   fontSize: 20,
//                   color: Colors.white,
//                 ),
//               ),
//               GestureDetector(
//                 onTap:
//                     () => showDialog(
//                       context: context,
//                       builder: (context) => const LogoutModal(),
//                     ),
//                 child: Image.asset(
//                   'assets/images/logout.png',
//                   width: 28,
//                   height: 28,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildInnerContent() {
//     switch (selectedSection) {
//       case ProfileSection.mySubscription:
//         return Column(
//           children: [_buildBackButton(), const MySubscriptionScreen()],
//         );
//       case ProfileSection.privacy:
//         return Column(children: [_buildBackButton(), const PrivacyScreen()]);
//       case ProfileSection.badgesRewards:
//         return Column(
//           children: [_buildBackButton(), const BadgesRewardsScreen()],
//         );
//       case ProfileSection.main:
//       default:
//         return _buildMainProfileMenu();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar:
//           selectedSection == ProfileSection.main
//               ? PreferredSize(
//                 preferredSize: const Size.fromHeight(70),
//                 child: _buildCustomAppBar(),
//               )
//               : null,
//       body: SingleChildScrollView(child: _buildInnerContent()),
//     );
//   }
// }
