// gift_drawer.dart
import 'package:flutter/material.dart';

class GiftDrawer extends StatelessWidget {
  const GiftDrawer({super.key});

  final List<String> giftImages = const [
    'assets/images/rose.png',
    'assets/images/teddy.png',
    'assets/images/chips.png',
    'assets/images/love.png',
    'assets/images/gift1.png',
    'assets/images/gift2.png',
  ];

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Container(
      width: mq.width,
      height: mq.height * 0.4,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  "Virtual Gifts",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                width: 79,
                height: 28,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: const [
                    BoxShadow(color: Color(0x66000000), blurRadius: 4),
                  ],
                ),
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/star_label.png',
                      width: 20,
                      height: 20,
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      '10000',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children:
                  giftImages.map((path) {
                    return GestureDetector(
                      onTap: () => _showGiftPopup(context),
                      child: Image.asset(path, fit: BoxFit.contain),
                    );
                  }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  void _showGiftPopup(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierLabel: "GiftPopup",
      barrierDismissible: true,
      barrierColor: Colors.transparent,
      // 👈 Keeps background clear
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, anim1, anim2) {
        return const SizedBox.shrink(); // Not used, required by API
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return FadeTransition(
          opacity: anim1,
          child: Center(
            child: Material(
              color: Colors.transparent, // 👈 Don't apply material background
              child: Container(
                width: 350,
                height: 303.33,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage('assets/images/send_gift.png'),
                    fit: BoxFit.contain,
                    opacity: 0.9,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
