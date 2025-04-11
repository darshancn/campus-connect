import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'subscription_summary_screen.dart';
import '../../widgets/my_subscription_appbar.dart';

class GoldSubscriptionScreen extends StatefulWidget {
  const GoldSubscriptionScreen({super.key});

  @override
  State<GoldSubscriptionScreen> createState() => _GoldSubscriptionScreenState();
}

class _GoldSubscriptionScreenState extends State<GoldSubscriptionScreen> {
  int selectedIndex = 0;

  Widget _buildSelectableBox({
    required String label,
    required String price,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.all(8.0),
          height: 115,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected ? const Color(0xFFE8B903) : Colors.grey,
              width: isSelected ? 2 : 1,
            ),
            boxShadow:
                isSelected
                    ? [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 4,
                      ),
                    ]
                    : [],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 28,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                ),
                alignment: Alignment.center,
                child: Text(
                  label,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(8),
                  ),
                  child: Container(
                    width: double.infinity,
                    color: Colors.black,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Gold',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          price,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 4),
            child: Icon(Icons.circle, size: 8, color: Colors.white),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDottedLine() {
    return SizedBox(
      width: double.infinity,
      height: 2,
      child: CustomPaint(painter: _DottedLinePainter()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MySubscriptionAppBar(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      _buildSelectableBox(
                        label: '1 Month',
                        price: '€ 40 for 1 Month',
                        isSelected: selectedIndex == 0,
                        onTap: () => setState(() => selectedIndex = 0),
                      ),
                      _buildSelectableBox(
                        label: '3 Month',
                        price: '€ 100 for 3 Month',
                        isSelected: selectedIndex == 1,
                        onTap: () => setState(() => selectedIndex = 1),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      _buildSelectableBox(
                        label: '6 Month',
                        price: '€ 190 for 6 Month',
                        isSelected: selectedIndex == 2,
                        onTap: () => setState(() => selectedIndex = 2),
                      ),
                      _buildSelectableBox(
                        label: '1 Year',
                        price: '€ 200 for 1 Year',
                        isSelected: selectedIndex == 3,
                        onTap: () => setState(() => selectedIndex = 3),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildDottedLine(),
                  const SizedBox(height: 20),
                  Container(
                    width: 383,
                    height: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF6ECBF9),
                          Color(0xFF2F9DD4),
                          Color(0xFF1D97D4),
                          Color(0xFF2F9DD4),
                          Color(0xFF6ECBF9),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 7,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(6),
                    child: DottedBorder(
                      color: Colors.white,
                      strokeWidth: 1,
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(10),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Golden',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8),
                            _buildFeatureItem(
                              'Increase visibility',
                              'Appear at the top of match suggestions once every month.',
                            ),
                            _buildFeatureItem(
                              'Direct Messaging Without Matching 3x/month',
                              'Message three people directly without needing a match.',
                            ),
                            _buildFeatureItem(
                              'See more than the my_profile photo 3x/month',
                              'Unlock full profiles beyond the photo three times a month.',
                            ),
                            _buildFeatureItem(
                              'Unlimited Swipes 1x/month',
                              'Enjoy unlimited swiping once every month.',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    height: 80,
                    decoration: BoxDecoration(
                      color: const Color(0xFF797979),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Advertisements',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width:
                        constraints.maxWidth < 420
                            ? constraints.maxWidth - 40
                            : 400,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const SubscriptionSummaryScreen(),
                            transitionDuration: Duration.zero,
                            reverseTransitionDuration: Duration.zero,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE8B903),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                      child: const Text(
                        'Continue',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const double dashWidth = 3;
    const double dashSpace = 3;
    double startX = 0;

    final paint =
        Paint()
          ..color = const Color(0xFF797979)
          ..strokeWidth = 1;

    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
