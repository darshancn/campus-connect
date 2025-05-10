import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../widgets/comment_drawer.dart';
import '../../../widgets/share_drawer.dart';
import '../widgets/advertisement_screen.dart';
import 'publication_details.dart';

class PublicationTabScreen extends StatefulWidget {
  const PublicationTabScreen({super.key});

  @override
  _PublicationTabScreenState createState() => _PublicationTabScreenState();
}

class _PublicationTabScreenState extends State<PublicationTabScreen> {
  Map<String, bool> likedImages = {};
  Map<String, int> likeCounts = {"image1": 12, "image2": 20, "image3": 15};
  Map<String, int> commentCounts = {"image1": 8, "image2": 10, "image3": 6};
  Map<String, int> shareCounts = {"image1": 5, "image2": 7, "image3": 3};
  Map<String, String> publishDates = {
    "image1": "24-12-2024",
    "image2": "15-01-2025",
    "image3": "05-02-2025",
  };
  Map<String, String> buttonTypes = {
    "image1": "Event",
    "image2": "News",
    "image3": "Event",
  };

  void _toggleLike(String key) {
    setState(() {
      likedImages[key] = !(likedImages[key] ?? false);
    });
  }

  void _openCommentDrawer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => const CommentDrawer(),
    );
  }

  void _openShareDrawer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black,
      isScrollControlled: true,
      builder: (_) => const ShareDrawer(),
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

  void _navigateToDetails() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PublicationDetailsScreen()),
    );
  }

  Widget _buildImage(String imagePath, String key) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width - 32,
          height: 500,
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),

        // Bottom Left Elements (Title, Button, Calendar, Views)
        Positioned(
          bottom: 20,
          left: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: _navigateToDetails,
                // ✅ Now both the text and button are clickable
                child: Row(
                  children: [
                    Text(
                      "Event title 123",
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width: 62,
                      height: 24,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1D97D4),
                        borderRadius: BorderRadius.circular(32),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        buttonTypes[key]!,
                        style: const TextStyle(
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
              const SizedBox(height: 8),

              // Calendar Icon and Date
              Row(
                children: [
                  const Icon(Icons.event, color: Colors.white, size: 20),
                  const SizedBox(width: 6),
                  Text(
                    publishDates[key]!,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Views, Blue Dot, View Text
              Row(
                children: [
                  const Icon(
                    Icons.remove_red_eye_outlined,
                    color: Color(0xFF1D97D4),
                    size: 12,
                  ),
                  const SizedBox(width: 6),
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF1D97D4),
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Text(
                    "View",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Color(0xFF1D97D4),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Right-side icons (Like, Comment, Share)
        Positioned(
          bottom: 50,
          right: 5,
          child: Column(
            children: [
              IconButton(
                icon: Icon(
                  Icons.thumb_up,
                  size: 28,
                  color:
                      likedImages[key] ?? false
                          ? const Color(0xFF1D97D4)
                          : Colors.white,
                ),
                onPressed: () => _toggleLike(key),
              ),
              Text(
                '${likeCounts[key]}',
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              IconButton(
                icon: const Icon(Icons.comment, size: 28, color: Colors.white),
                onPressed: () => _openCommentDrawer(context),
              ),
              Text(
                '${commentCounts[key]}',
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => _openShareDrawer(context),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: SvgPicture.asset(
                    'assets/images/share_icon.svg',
                    width: 25,
                    height: 25,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${shareCounts[key]}',
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            _buildImage('assets/images/publication_image1.png', 'image1'),
            _buildAdvertisementBox(),
            _buildImage('assets/images/publication_image2.png', 'image2'),
            _buildImage('assets/images/publication_image3.png', 'image3'),
          ],
        ),
      ),
    );
  }
}
