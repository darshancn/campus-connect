import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import '../../../../widgets/notification_screen.dart';
import 'basic_subscription.dart';
import 'gold_subscription.dart';
import 'pro_subscription.dart';

class MySubscriptionScreen extends StatelessWidget {
  const MySubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double topPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildCustomAppBar(context, 'My Subscription', topPadding),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Column(
            children: [
              _buildGradientBox(),
              const SizedBox(height: 20),
              _buildDottedLine(),
              const SizedBox(height: 15),

              // Basic Plan
              _buildSubscriptionOption(
                context,
                borderColor: Colors.black,
                backgroundColor: Colors.white,
                textColor: Colors.black,
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder:
                          (context, animation, secondaryAnimation) =>
                              const BasicSubscriptionScreen(),
                      transitionDuration: Duration.zero,
                    ),
                  );
                },
                planName: "Basic",
                planPrice: "Free",
                planDescription: "Basic Profile creation and browsing",
              ),
              const SizedBox(height: 15),

              // Premium Plan
              _buildSubscriptionOption(
                context,
                backgroundColor: const Color(0xFF1D97D4),
                borderColor: Colors.white,
                textColor: Colors.white,
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder:
                          (context, animation, secondaryAnimation) =>
                              const ProSubscriptionScreen(),
                      transitionDuration: Duration.zero,
                    ),
                  );
                },
                planName: "Premium",
                planPrice: "€10/Month",
                planDescription: "Increase visibility",
              ),
              const SizedBox(height: 15),

              // Gold Plan
              _buildSubscriptionOption(
                context,
                backgroundColor: const Color(0xFFE8B903),
                borderColor: Colors.white,
                textColor: Colors.white,
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder:
                          (context, animation, secondaryAnimation) =>
                              const GoldSubscriptionScreen(),
                      transitionDuration: Duration.zero,
                    ),
                  );
                },
                planName: "Gold",
                planPrice: "€120/Year",
                planDescription: "Direct Messaging Without Matching 3x/month",
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildCustomAppBar(
    BuildContext context,
    String title,
    double topPadding,
  ) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(70),
      child: Container(
        color: const Color(0xFF1D97D4),
        padding: EdgeInsets.only(
          top: topPadding + 12,
          left: 15,
          right: 15,
          bottom: 12,
        ),
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
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(_createRoute());
              },
              child: Container(
                width: 40,
                height: 40,
                padding: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: const [
                    BoxShadow(color: Color(0x66000000), blurRadius: 4),
                    BoxShadow(color: Color(0x66000000), blurRadius: 5),
                  ],
                ),
                child: const Center(
                  child: Icon(
                    Icons.notifications,
                    size: 24,
                    color: Color(0xFF1D97D4),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGradientBox() {
    return Container(
      width: double.infinity,
      height: 320,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF6ECBF9),
            Color(0xFF2F9DD4),
            Color(0xFF1D97D4),
            Color(0xFF2F9DD4),
            Color(0xFF6ECBF9),
          ],
          stops: [-0.2412, 0.2772, 0.4801, 0.7572, 1.1382],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xA6279ED9),
            blurRadius: 7.8,
            offset: Offset.zero,
          ),
        ],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "My Plan",
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8B903),
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: const [
                      BoxShadow(color: Color(0x66000000), blurRadius: 4),
                    ],
                  ),
                  child: const Text(
                    "Upgrade",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Row 1
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _infoColumn("Subscription Name", "Subscription 1"),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: _infoColumn(
                    "Subscription Type",
                    "Premium",
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Row 2
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _infoColumn(
                    "Transaction ID",
                    "Trans123456",
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: _infoColumn(
                    "Date of Purchase",
                    "30-01-2025",
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Row 3
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _infoColumn(
                    "Date of Expiry",
                    "28-02-2025",
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: _infoColumn(
                    "Payment Amount",
                    "25",
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Row 4 (custom for Payment Status)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _infoColumn(
                    "Payment Method",
                    "Online",
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Payment Status",
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: Color(0xFFF8F2F8),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Text(
                          "Success",
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: Color(0xFF14AE5C),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Reusable info column
  Widget _infoColumn(
    String label,
    String value, {
    FontWeight fontWeight = FontWeight.w400,
    double fontSize = 16,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            fontSize: 15,
            color: Color(0xFFF8F2F8),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: fontWeight,
            fontSize: fontSize,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  // ✅ FIXED: Now a clean, single dotted horizontal line
  Widget _buildDottedLine() {
    return SizedBox(
      width: double.infinity,
      height: 1,
      child: CustomPaint(painter: _DottedLinePainter()),
    );
  }

  Widget _buildSubscriptionOption(
    BuildContext context, {
    required Color backgroundColor,
    required Color borderColor,
    required Color textColor,
    required VoidCallback onTap,
    String planName = "Basic",
    String planPrice = "Free",
    String planDescription = "Basic Profile creation and browsing",
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Color(0x66000000),
              blurRadius: 7.8,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: DottedBorder(
          dashPattern: const [2, 2],
          color: borderColor,
          strokeWidth: 1,
          borderType: BorderType.RRect,
          radius: const Radius.circular(10),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Row: Plan name and price
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      planName,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        height: 1.0,
                        color: textColor,
                      ),
                    ),
                    Text(
                      planPrice,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        height: 1.0,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Bottom: Left-aligned Plan Description
                Text(
                  planDescription,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    height: 1.0,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder:
          (context, animation, secondaryAnimation) =>
              const NotificationScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }
}

// 🎯 Custom painter for a single dotted horizontal line
class _DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const double dashWidth = 2;
    const double dashSpace = 2;
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
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
