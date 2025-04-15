import 'package:flutter/material.dart';
import 'advertisement_screen.dart';
import 'custom_bottom_navbar.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  int currentIndex = 0;

  // Dummy chat data
  final List<Map<String, dynamic>> chats = [
    {
      'imagePath': 'assets/images/chat_image1.png',
      'name': 'Aya Kazlauskas',
      'status': 'Hello',
      'time': '1m ago',
      'online': true,
    },
    {
      'imagePath': 'assets/images/chat_image2.png',
      'name': 'John Doe',
      'status': 'How are you?',
      'time': '2m ago',
      'online': false,
    },
    {
      'imagePath': 'assets/images/chat_image3.png',
      'name': 'Emma Black',
      'status': 'Let’s catch up!',
      'time': '5m ago',
      'online': true,
    },
    {
      'imagePath': 'assets/images/chat_image4.png',
      'name': 'Sophia Green',
      'status': 'What’s up?',
      'time': '10m ago',
      'online': false,
    },
    {
      'imagePath': 'assets/images/chat_image5.png',
      'name': 'Michael Johnson',
      'status': 'See you soon!',
      'time': '15m ago',
      'online': true,
    },
    {
      'imagePath': 'assets/images/chat_image6.png',
      'name': 'Lisa Brown',
      'status': 'Meeting at 3 PM?',
      'time': '20m ago',
      'online': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1D97D4),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Notifications',
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Column(
          children: [
            const SizedBox(height: 10),

            // Recent Section Text aligned to the left
            Align(
              alignment: Alignment.centerLeft,
              child: const Text(
                'Recent',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ),

            const SizedBox(height: 10),
            for (var chat in chats.where((chat) => chat['online'])) ...[
              _ChatProfile(
                imagePath: chat['imagePath'],
                name: chat['name'],
                status: chat['status'],
                time: chat['time'],
                online: chat['online'],
              ),
            ],

            const SizedBox(height: 20),

            // Recent Activity Section Text aligned to the left
            Align(
              alignment: Alignment.centerLeft,
              child: const Text(
                'Recent Activity',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 10),
            for (var chat in chats.where((chat) => !chat['online'])) ...[
              _ChatProfile(
                imagePath: chat['imagePath'],
                name: chat['name'],
                status: chat['status'],
                time: chat['time'],
                online: chat['online'],
              ),
            ],

            const SizedBox(height: 20),

            // Advertisement Section
            _buildAdvertisementBox(),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavbar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CustomBottomNavbar.floatingNavButton(
        isSelected: currentIndex == 2,
        onPressed: () => setState(() => currentIndex = 2),
      ),
    );
  }

  void _navigateToAdvertisement(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AdvertisementScreen()),
    );
  }

  Widget _buildAdvertisementBox() {
    return GestureDetector(
      onTap: () => _navigateToAdvertisement(context),
      child: Container(
        width: double.infinity,
        height: 80,
        margin: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Color(0xFF797979),
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: const Text(
          "Advertisements",
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

// Chat Profile Widget
class _ChatProfile extends StatelessWidget {
  final String imagePath, name, status, time;
  final bool online;

  const _ChatProfile({
    required this.imagePath,
    required this.name,
    required this.status,
    required this.time,
    required this.online,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 72,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Row(
        children: [
          CircleAvatar(radius: 28, backgroundImage: AssetImage(imagePath)),
          const SizedBox(width: 16),
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
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      time,
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ],
                ),
                Row(
                  children: [
                    if (online)
                      Container(
                        width: 10,
                        height: 10,
                        margin: const EdgeInsets.only(right: 5),
                        decoration: const BoxDecoration(
                          color: Color(0xFF30C37C),
                          shape: BoxShape.circle,
                        ),
                      ),
                    Expanded(
                      child: Text(
                        status,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
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
    );
  }
}
