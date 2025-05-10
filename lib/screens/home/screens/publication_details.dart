import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:latlong2/latlong.dart';
import '../../../widgets/comment_drawer.dart';
import '../../../widgets/share_drawer.dart';
import '../widgets/advertisement_screen.dart';

class PublicationDetailsScreen extends StatefulWidget {
  const PublicationDetailsScreen({super.key});

  @override
  _PublicationDetailsScreenState createState() =>
      _PublicationDetailsScreenState();
}

class _PublicationDetailsScreenState extends State<PublicationDetailsScreen> {
  final LatLng eventLocation = LatLng(37.7749, -122.4194); // San Francisco

  final String eventKey = "event1";
  final Map<String, String> buttonTypes = {"event1": "Join"};
  final Map<String, String> publishDates = {"event1": "April 5, 2025"};
  final Map<String, bool> likedImages = {"event1": false};
  final Map<String, int> likeCounts = {"event1": 100};
  final Map<String, int> commentCounts = {"event1": 25};
  final Map<String, int> shareCounts = {"event1": 10};

  int currentIndex = 1;

  void _navigateToDetails() {
    debugPrint("Navigating to event details...");
  }

  void _toggleLike(String eventKey) {
    setState(() {
      likedImages[eventKey] = !likedImages[eventKey]!;
      likeCounts[eventKey] =
          likedImages[eventKey]!
              ? likeCounts[eventKey]! + 1
              : likeCounts[eventKey]! - 1;
    });
  }

  void _openCommentDrawer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => const CommentDrawer(),
    );
  }

  void _openShareDrawer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => const ShareDrawer(),
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
        margin: const EdgeInsets.symmetric(horizontal: 12),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 500,
                      child: Image.asset(
                        'assets/images/publication_image1.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 60,
                      left: 16,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      top: 60,
                      right: 16,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(7),
                          boxShadow: const [
                            BoxShadow(color: Color(0x40000000), blurRadius: 4),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () => _toggleLike(eventKey),
                          child: Icon(
                            Icons.favorite,
                            size: 24,
                            color:
                                likedImages[eventKey]!
                                    ? const Color(0xFFFF001E)
                                    : Color(0xFFFF001E),
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      bottom: 20,
                      left: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: _navigateToDetails,
                            child: Row(
                              children: [
                                const Text(
                                  "Event title 123",
                                  style: TextStyle(
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
                                    buttonTypes[eventKey]!,
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
                          Row(
                            children: [
                              const Icon(
                                Icons.event,
                                color: Colors.white,
                                size: 20,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                publishDates[eventKey]!,
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
                    Positioned(
                      bottom: 50,
                      right: 5,
                      child: Column(
                        children: [
                          IconButton(
                            icon: Icon(
                              likedImages[eventKey]!
                                  ? Icons.thumb_up
                                  : Icons.thumb_up_outlined,
                              size: 28,
                              color:
                                  likedImages[eventKey]!
                                      ? const Color(0xFF1D97D4)
                                      : Colors.white,
                            ),
                            onPressed: () => _toggleLike(eventKey),
                          ),
                          Text(
                            '${likeCounts[eventKey]}',
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
                            onPressed: () => _openCommentDrawer(context),
                          ),
                          Text(
                            '${commentCounts[eventKey]}',
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
                            '${shareCounts[eventKey]}',
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
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: const Text(
                    "Description",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: const Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum mollis nunc a molestie dictum. Mauris venenatis, felis scelerisque aliquet lacinia, nulla nisi venenatis odio, id blandit mauris ipsum id sapien. Vestibulum malesuada orci sit amet pretium facilisis. In lobortis congue augue, a commodo libero tincidunt scelerisque. ",
                    textAlign: TextAlign.justify,
                  ),
                ),
                const SizedBox(height: 20),
                _buildAdvertisementBox(),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    width: double.infinity,
                    height: 138,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade400),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: FlutterMap(
                        options: MapOptions(
                          initialCenter: eventLocation,
                          initialZoom: 15,
                        ),
                        children: [
                          TileLayer(
                            urlTemplate:
                                "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                            subdomains: ['a', 'b', 'c'],
                          ),
                          MarkerLayer(
                            markers: [
                              Marker(
                                point: eventLocation,
                                width: 40,
                                height: 40,
                                child: const Icon(
                                  Icons.location_pin,
                                  color: Colors.red,
                                  size: 40,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
