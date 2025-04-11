import 'package:flutter/material.dart';
import 'comment_drawer.dart';
import 'share_drawer.dart';

class AdvertisementScreen extends StatefulWidget {
  const AdvertisementScreen({super.key});

  @override
  State<AdvertisementScreen> createState() => _AdvertisementScreenState();
}

class _AdvertisementScreenState extends State<AdvertisementScreen> {
  bool isLiked = false;
  int likeCount = 15;
  int commentCount = 8;
  int shareCount = 5;

  void _toggleLike() {
    setState(() {
      isLiked = !isLiked;
      likeCount += isLiked ? 1 : -1;
    });
  }

  void _openBottomDrawer(Widget drawerContent) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => drawerContent,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  'assets/images/advertisement_image1.png',
                  width: screenWidth,
                  height: 450,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 40,
                  left: 16,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 50,
                  right: 10,
                  child: Column(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.thumb_up,
                          size: 28,
                          color:
                              isLiked ? const Color(0xFF1D97D4) : Colors.white,
                        ),
                        onPressed: _toggleLike,
                      ),
                      Text(
                        '$likeCount',
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      IconButton(
                        icon: const Icon(
                          Icons.comment,
                          size: 28,
                          color: Colors.white,
                        ),
                        onPressed:
                            () => _openBottomDrawer(const CommentDrawer()),
                      ),
                      Text(
                        '$commentCount',
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      IconButton(
                        icon: const Icon(
                          Icons.share,
                          size: 28,
                          color: Colors.white,
                        ),
                        onPressed: () => _openBottomDrawer(const ShareDrawer()),
                      ),
                      Text(
                        '$shareCount',
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  const Text(
                    "Advertisement Title 1",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 69,
                    height: 24,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1D97D4),
                      borderRadius: BorderRadius.circular(32),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      "Targeted",
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Description",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum mollis nunc a molestie dictum. "
                "Mauris venenatis, felis scelerisque aliquet lacinia, nulla nisi venenatis odio, id blandit mauris ipsum id sapien. "
                "Vestibulum malesuada orci sit amet pretium facilisis. In lobortis congue augue, a commodo libero tincidunt scelerisque.",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
