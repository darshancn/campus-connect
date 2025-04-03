import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:campus_connect/screens/chat/chat_screen.dart';

class MyChatsTabScreen extends StatelessWidget {
  const MyChatsTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SearchBar(),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  SizedBox(height: 5.h),
                  ChatProfile(
                    imagePath: 'assets/images/chat_image1.png',
                    name: 'Aya Kazlauskas',
                    status: 'Hello',
                    time: '1m ago',
                    online: true,
                  ),
                  ChatProfile(
                    imagePath: 'assets/images/chat_image2.png',
                    name: 'John Doe',
                    status: 'How are you?',
                    time: '2m ago',
                    online: false,
                  ),
                  ChatProfile(
                    imagePath: 'assets/images/chat_image3.png',
                    name: 'Emma Black',
                    status: 'Let’s catch up!',
                    time: '5m ago',
                    online: true,
                  ),
                  const AdvertisementBanner(),
                  // Additional user chat profiles
                  ChatProfile(
                    imagePath: 'assets/images/chat_image4.png',
                    name: 'Sophia Green',
                    status: 'What’s up?',
                    time: '10m ago',
                    online: false,
                  ),
                  ChatProfile(
                    imagePath: 'assets/images/chat_image5.png',
                    name: 'Michael Johnson',
                    status: 'See you soon!',
                    time: '15m ago',
                    online: true,
                  ),
                  ChatProfile(
                    imagePath: 'assets/images/chat_image6.png',
                    name: 'Lisa Brown',
                    status: 'Meeting at 3 PM?',
                    time: '20m ago',
                    online: false,
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 🔍 Search Bar Widget
class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50.h,
      margin: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4.r)],
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: Colors.grey.shade600, size: 22.sp),
          SizedBox(width: 10.w),
          Expanded(
            child: TextField(
              style: TextStyle(fontSize: 16.sp, color: Colors.black),
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 16.sp,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 👤 Chat Profile Widget with Proper Layout
class ChatProfile extends StatelessWidget {
  final String imagePath, name, status, time;
  final bool online;

  const ChatProfile({
    super.key,
    required this.imagePath,
    required this.name,
    required this.status,
    required this.time,
    required this.online,
  });

  void _navigateToChat(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (_, __, ___) => ChatScreen(name: name, imagePath: imagePath),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToChat(context),
      child: Container(
        width: double.infinity,
        height: 72.h,
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4.r)],
        ),
        child: Row(
          children: [
            CircleAvatar(radius: 28.w, backgroundImage: AssetImage(imagePath)),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          name,
                          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        time,
                        style: TextStyle(fontSize: 14.sp, color: Colors.black),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      if (online)
                        Container(
                          width: 10.w,
                          height: 10.h,
                          margin: EdgeInsets.only(right: 5.w),
                          decoration: const BoxDecoration(
                            color: Color(0xFF30C37C),
                            shape: BoxShape.circle,
                          ),
                        ),
                      Expanded(
                        child: Text(
                          status,
                          style: TextStyle(fontSize: 14.sp, color: Colors.black),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 📢 Advertisement Banner Widget
class AdvertisementBanner extends StatelessWidget {
  const AdvertisementBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80.h,
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF797979),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4.r)],
      ),
      child: const Center(
        child: Text(
          'Advertisements',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

