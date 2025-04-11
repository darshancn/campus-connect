import 'package:flutter/material.dart';
import '../../widgets/badge_modal.dart';
import '../../widgets/reward_modal.dart';
import '../../widgets/reward_blur_modal.dart'; // <-- Add this import

class BadgesRewardsScreen extends StatelessWidget {
  const BadgesRewardsScreen({super.key});

  void _showBadgeModal(BuildContext context) {
    showDialog(context: context, builder: (context) => const BadgeModal());
  }

  void _showRewardModal(BuildContext context) {
    showDialog(context: context, builder: (context) => const RewardModal());
  }

  void _showRewardBlurModal(BuildContext context) {
    showDialog(context: context, builder: (context) => const RewardBlurModal());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          backgroundColor: const Color(0xFF1D97D4),
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Badges and Rewards',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, size: 24, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.only(
              top: 30,
              bottom: 16,
              left: 16,
              right: 16,
            ),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                top: 16,
                bottom: 16,
                left: 10,
                right: 10,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(color: Color(0x66000000), blurRadius: 4),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionHeader(
                    icon: 'assets/images/badge_icon.png',
                    title: 'Badges',
                  ),
                  const SizedBox(height: 12),
                  _imageRow(
                    context: context,
                    imagePaths: const [
                      'assets/images/badge1.png',
                      'assets/images/badge2.png',
                      'assets/images/badge3.png',
                      'assets/images/badge4.png',
                    ],
                    opacities: const [1.0, 0.15, 0.15, 0.15],
                    onTapCallbacks: [
                      () => _showBadgeModal(context),
                      () => _showRewardBlurModal(context),
                      () => _showRewardBlurModal(context),
                      () => _showRewardBlurModal(context),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _sectionHeader(
                    icon: 'assets/images/reward_icon.png',
                    title: 'Rewards',
                  ),
                  const SizedBox(height: 12),
                  _imageRow(
                    context: context,
                    imagePaths: const [
                      'assets/images/reward1.png',
                      'assets/images/reward2.png',
                      'assets/images/reward3.png',
                    ],
                    opacities: const [1.0, 0.15, 0.15],
                    onTapCallbacks: [
                      () => _showRewardModal(context),
                      () => _showRewardBlurModal(context),
                      () => _showRewardBlurModal(context),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _sectionHeader({required String icon, required String title}) {
    return Row(
      children: [
        Image.asset(icon, width: 18, height: 18),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _imageRow({
    required BuildContext context,
    required List<String> imagePaths,
    required List<void Function()> onTapCallbacks,
    required List<double> opacities,
  }) {
    return GridView.count(
      crossAxisCount: 4,
      mainAxisSpacing: 10,
      crossAxisSpacing: 1,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: List.generate(imagePaths.length, (index) {
        return GestureDetector(
          onTap: onTapCallbacks[index],
          child: Opacity(
            opacity: opacities[index],
            child: Image.asset(
              imagePaths[index],
              width: 90,
              height: 90,
              fit: BoxFit.contain,
            ),
          ),
        );
      }),
    );
  }
}
