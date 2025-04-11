import 'package:campus_connect/screens/chat/chat_screen.dart';
import 'package:campus_connect/widgets/report_block_modal.dart';
import '../../widgets/badge_popup.dart';
import '../../widgets/toast_modals.dart';
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
  late Animation<Offset> _drawerAnimation;

  @override
  void initState() {
    super.initState();
    _overlayController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _drawerAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _overlayController, curve: Curves.easeOut),
    );
  }

  void _toggleOverlayDrawer() {
    setState(() {
      showOverlayDrawer = true;
    });
    _overlayController.forward();
  }

  void _closeOverlayDrawer() {
    _overlayController.reverse().then((_) {
      setState(() {
        showOverlayDrawer = false;
      });
    });
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
    height: 100,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.grey[200],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.asset(assetPath, fit: BoxFit.cover),
    ),
  );

  Widget _interestIcon(String assetPath) => Container(
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
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * (2 / 3),
              child: Image.asset(widget.imagePath, fit: BoxFit.cover),
            ),
          ),
          // Top navigation buttons
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
          // Draggable details sheet
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
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            'assets/images/gold_member_icon.svg',
                            width: screenWidth * 0.3,
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
                            decoration: BoxDecoration(
                              color: const Color(0xFFFAE8FF),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
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
                                _galleryImage(
                                  'assets/images/gallery_image1.png',
                                ),
                                _galleryImage(
                                  'assets/images/gallery_image2.png',
                                ),
                                _galleryImage(
                                  'assets/images/gallery_image3.png',
                                ),
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
                          const SizedBox(height: 20),
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
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/images/community_icon.svg',
                                width: 18,
                                height: 18,
                              ),
                              const SizedBox(width: 6),
                              const Text(
                                'Community Details',
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
                          _infoRow('Religion', 'Christian'),
                          const SizedBox(height: 6),
                          _infoRow('Community', 'Christian'),
                          const SizedBox(height: 6),
                          _infoRow('Sub-Community', 'Christian'),

                          const SizedBox(height: 24),
                          // Personality Type
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/images/person_icon.svg',
                                width: 18,
                                height: 18,
                              ),
                              const SizedBox(width: 6),
                              const Text(
                                'Personality Type',
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

                          const SizedBox(height: 24),
                          // Profession and Studies
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/images/book_icon.svg',
                                width: 18,
                                height: 18,
                              ),
                              const SizedBox(width: 6),
                              const Text(
                                'Profession and Studies',
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
                          _infoRow(
                            'Current/Intended Occupation',
                            'Software Developer',
                            isBoldRight: true,
                          ),
                          const SizedBox(height: 6),
                          _infoRow(
                            'Academic Field',
                            'Data Science',
                            isBoldRight: true,
                          ),
                          const SizedBox(height: 6),
                          _infoRow(
                            'University Course',
                            'Artificial Intelligence',
                            isBoldRight: true,
                          ),
                          const SizedBox(height: 6),
                          _infoRow(
                            'Level of Studies',
                            'Bachelors degree 1,2,3',
                            isBoldRight: true,
                          ),
                          const SizedBox(height: 6),
                          _infoRow(
                            'University/School Attended',
                            'XYZ University',
                            isBoldRight: true,
                          ),

                          const SizedBox(height: 24),
                          // Physical Criteria
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/images/fitness_icon.svg',
                                width: 18,
                                height: 18,
                              ),
                              const SizedBox(width: 6),
                              const Text(
                                'Physical Criteria',
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
                          _infoRow('Size', 'Small', isBoldRight: true),
                          const SizedBox(height: 6),
                          _infoRow('Weight', '50 kg', isBoldRight: true),

                          // Personal Information
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/images/personal_info_icon.svg',
                                width: 18,
                              ),
                              const SizedBox(width: 6),
                              const Text(
                                'Personal Information',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 12),
                          _infoRow('Height (cm)', '5.3'),
                          _infoRow('Any Disability', 'No'),
                          _infoRow('Complexion', 'Fair'),
                          _infoRow('Body Type', 'Fit'),

                          // Lifestyle
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/images/lifestyle_icon.svg',
                                width: 18,
                              ),
                              const SizedBox(width: 6),
                              const Text(
                                'Life Style',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 12),
                          _infoRow('Diet', 'Non-Vegetarian'),
                          _infoRow('Drink', 'Alcoholic'),
                          _infoRow('Smoker', 'Smoker'),

                          // Badges
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/images/badges_icon.svg',
                                width: 18,
                              ),
                              const SizedBox(width: 6),
                              const Text(
                                'Badges',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 12),
                          Row(
                            children: [
                              GestureDetector(
                                onTap:
                                    () => showDialog(
                                      context: context,
                                      builder:
                                          (_) => const BadgePopup(
                                            badgeImage:
                                                'assets/images/badge1.png',
                                          ),
                                    ),
                                child: Image.asset(
                                  'assets/images/badge1.png',
                                  width: 90,
                                  height: 90,
                                ),
                              ),
                              const SizedBox(width: 12),
                              GestureDetector(
                                onTap:
                                    () => showDialog(
                                      context: context,
                                      builder:
                                          (_) => const BadgePopup(
                                            badgeImage:
                                                'assets/images/badge2.png',
                                          ),
                                    ),
                                child: Image.asset(
                                  'assets/images/badge1.png',
                                  width: 90,
                                  height: 90,
                                ),
                              ),
                            ],
                          ),

                          // 👇 Rewards Row
                          const SizedBox(height: 20),
                          const Text(
                            'Rewards',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              GestureDetector(
                                onTap:
                                    () => showDialog(
                                      context: context,
                                      builder: (_) => const RewardPopup(),
                                    ),
                                child: Image.asset(
                                  'assets/images/reward1.png',
                                  width: 90,
                                  height: 90,
                                ),
                              ),
                              // Add more rewards here if needed
                            ],
                          ),

                          const SizedBox(height: 100),
                        ],
                      );
                    },
                  ),
                ),
              );
            },
          ),
          // Background behind sticky container
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(height: 100, color: Colors.white),
          ),
          // Sticky container with action buttons
          Positioned(
            bottom: 15,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: screenWidth * 0.9 > 400 ? 400 : screenWidth * 0.9,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(80),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x66000000),
                      blurRadius: 8,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Send Message Button
                      Flexible(
                        flex: 6,
                        child: GestureDetector(
                          onTap: () {
                            String name =
                                'Bence Borg'; // Replace with actual dynamic name
                            String imagePath =
                                'assets/images/bence_borg.png'; // Replace with actual imagePath

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (_) => ChatScreen(
                                      name: name,
                                      imagePath: imagePath,
                                    ),
                              ),
                            );
                          },
                          child: Container(
                            height: 52,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(42),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Icon(
                                  Icons.chat_bubble,
                                  size: 16,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'Send Message',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Colors.white,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      // Reject Button (shows error toast)
                      Flexible(
                        flex: 4,
                        child: GestureDetector(
                          onTap: () => showErrorToast(context),
                          child: Container(
                            height: 52,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: const Color(0xFFD31F34),
                              borderRadius: BorderRadius.circular(42),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  radius: 10,
                                  child: Icon(
                                    Icons.block,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'Reject',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Colors.white,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      // Circular Blue Button (shows success toast)
                      Flexible(
                        flex: 2,
                        child: GestureDetector(
                          onTap: () => showSuccessToast(context),
                          child: Container(
                            width: 52,
                            height: 52,
                            decoration: const BoxDecoration(
                              color: Color(0xFF1D97D4),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                'assets/images/person_add.svg',
                                width: 16,
                                height: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Custom overlay drawer with modal triggers for Block and Report actions
          if (showOverlayDrawer)
            Positioned.fill(
              child: GestureDetector(
                onTap: _closeOverlayDrawer,
                child: Container(
                  color: Colors.transparent,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SlideTransition(
                      position: _drawerAnimation,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 24,
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(24),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Block option
                            GestureDetector(
                              onTap: () {
                                _closeOverlayDrawer();
                                showDialog(
                                  context: context,
                                  builder:
                                      (_) => BlockConfirmationModal(
                                        onNo: () => Navigator.pop(context),
                                        onYes: () {
                                          Navigator.pop(context);
                                          showDialog(
                                            context: context,
                                            builder:
                                                (_) =>
                                                    const BlockSuccessModal(),
                                          );
                                          Future.delayed(
                                            const Duration(milliseconds: 1400),
                                            () {
                                              Navigator.pop(context);
                                            },
                                          );
                                        },
                                      ),
                                );
                              },
                              child: Row(
                                children: const [
                                  Icon(Icons.block, color: Colors.white),
                                  SizedBox(width: 12),
                                  Text(
                                    "Block",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            // Report option
                            GestureDetector(
                              onTap: () {
                                _closeOverlayDrawer();
                                showDialog(
                                  context: context,
                                  builder:
                                      (_) => ReportConfirmationModal(
                                        onNo: () => Navigator.pop(context),
                                        onYes: () {
                                          Navigator.pop(context);
                                          showDialog(
                                            context: context,
                                            builder:
                                                (_) =>
                                                    const ReportSuccessModal(),
                                          );
                                          Future.delayed(
                                            const Duration(milliseconds: 1400),
                                            () {
                                              Navigator.pop(context);
                                            },
                                          );
                                        },
                                      ),
                                );
                              },
                              child: Row(
                                children: const [
                                  Icon(Icons.report, color: Colors.white),
                                  SizedBox(width: 12),
                                  Text(
                                    "Report",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

Widget _infoRow(String left, String right, {bool isBoldRight = false}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        left,
        style: const TextStyle(
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: Colors.black,
          decoration: TextDecoration.none,
        ),
      ),
      Text(
        right,
        style: TextStyle(
          fontFamily: 'Inter',
          fontWeight: isBoldRight ? FontWeight.w700 : FontWeight.w400,
          fontSize: 14,
          color: Colors.black,
          decoration: TextDecoration.none,
        ),
      ),
    ],
  );
}

Widget _infoRow1(String left, String right) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          left,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          right,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}
