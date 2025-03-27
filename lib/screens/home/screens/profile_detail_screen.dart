import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PageDetailsScreen extends StatefulWidget {
  final String imagePath;

  const PageDetailsScreen({super.key, required this.imagePath});

  @override
  State<PageDetailsScreen> createState() => _PageDetailsScreenState();
}

class _PageDetailsScreenState extends State<PageDetailsScreen>
    with SingleTickerProviderStateMixin {
  final DraggableScrollableController _controller =
      DraggableScrollableController();
  bool showOverlayDrawer = false;
  late AnimationController _overlayController;

  @override
  void initState() {
    super.initState();
    _overlayController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
  }

  void _toggleOverlayDrawer() {
    setState(() {
      showOverlayDrawer = true;
    });
    _overlayController.forward();
  }

  @override
  void dispose() {
    _overlayController.dispose();
    super.dispose();
  }

  Widget _dot() => Container(
    width: 3.46,
    height: 4.5,
    decoration: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.circular(24),
    ),
  );

  Widget _galleryImage(String assetPath) => Container(
    margin: const EdgeInsets.only(right: 10),
    width: 80,
    height: 80,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
    child: SvgPicture.asset(
      assetPath,
      fit: BoxFit.cover,
      width: 80,
      height: 80,
    ),
  );

  Widget _interestIcon(String assetPath) => Container(
    width: 32,
    height: 32,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
    child: SvgPicture.asset(
      assetPath,
      width: 32,
      height: 32,
      fit: BoxFit.contain,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset(widget.imagePath, fit: BoxFit.cover),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  GestureDetector(
                    onTap: _toggleOverlayDrawer,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _dot(),
                            const SizedBox(height: 2),
                            _dot(),
                            const SizedBox(height: 2),
                            _dot(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          DraggableScrollableSheet(
            controller: _controller,
            initialChildSize: 0.66,
            minChildSize: 0.66,
            maxChildSize: 0.95,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        'assets/images/gold_member_icon.svg',
                        width: 80,
                        height: 28,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Bence Borg, 24',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 24,
                                  color: Colors.black,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                              const SizedBox(width: 6),
                              SvgPicture.asset(
                                'assets/images/green_tick.svg',
                                width: 24,
                                height: 24,
                              ),
                            ],
                          ),
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(7),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.favorite,
                                color: Color(0xFFFF001E),
                                size: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Container(
                        width: 84,
                        height: 25,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFAE8FF),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.location_on,
                              size: 12,
                              color: Colors.black,
                            ),
                            SizedBox(width: 4),
                            Text(
                              '2km Away',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: Colors.black,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'About',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          color: Colors.black,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum mollis nunc a molestie dictum.',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Colors.black,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Gallery',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Colors.black,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 100,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            _galleryImage('assets/images/gallery_image1.svg'),
                            _galleryImage('assets/images/gallery_image2.svg'),
                            _galleryImage('assets/images/gallery_image3.svg'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/images/interests_icon.svg',
                            width: 18,
                            height: 18,
                          ),
                          const SizedBox(width: 6),
                          const Text(
                            'Interests',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Colors.black,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          _interestIcon('assets/images/cricket.svg'),
                          _interestIcon('assets/images/music.svg'),
                          _interestIcon('assets/images/book.svg'),
                          _interestIcon('assets/images/photography.svg'),
                          _interestIcon('assets/images/swimming.svg'),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/images/relation_sought.svg',
                            width: 18,
                            height: 18,
                          ),
                          const SizedBox(width: 6),
                          const Text(
                            'Relation Sought',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Colors.black,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SvgPicture.asset(
                        'assets/images/friendship.svg',
                        height: 32,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
