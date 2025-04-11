import 'package:campus_connect/screens/my_profile/screens/privacy/privacy_block_screen.dart';
import 'package:campus_connect/screens/my_profile/screens/privacy/privacy_report_screen.dart';
import 'package:flutter/material.dart';
import '../../widgets/profile_appbar.dart';

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({super.key});

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  String _agePrivacy = 'Everyone';
  String _locationPrivacy = 'Everyone';
  String _statusPrivacy = 'Everyone';

  Widget _buildRadioGroup(String groupValue, Function(String?) onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:
          ['Everyone', 'My Match', 'Nobody'].map((label) {
            return Row(
              children: [
                Radio<String>(
                  value: label,
                  groupValue: groupValue,
                  onChanged: onChanged,
                  activeColor: Colors.black,
                  visualDensity: VisualDensity.compact,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                Text(
                  label,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ],
            );
          }).toList(),
    );
  }

  Widget _buildPrivacyOption(
    String title,
    String groupValue,
    Function(String?) onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          _buildRadioGroup(groupValue, onChanged),
        ],
      ),
    );
  }

  Widget _buildActionButton(String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 52,
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [BoxShadow(color: Color(0x40000000), blurRadius: 4)],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            Transform.rotate(
              angle: -90 * 3.1416 / 180,
              child: const Icon(
                Icons.arrow_drop_down,
                size: 25,
                color: Color(0xFF797979),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: const ProfileAppBar(title: 'Privacy'),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: screenWidth > 400 ? 380 : screenWidth * 0.9,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(color: Color(0x40000000), blurRadius: 4),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Control Privacy',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildPrivacyOption('Age', _agePrivacy, (val) {
                      setState(() => _agePrivacy = val!);
                    }),
                    _buildPrivacyOption('Location', _locationPrivacy, (val) {
                      setState(() => _locationPrivacy = val!);
                    }),
                    _buildPrivacyOption('Online Status', _statusPrivacy, (val) {
                      setState(() => _statusPrivacy = val!);
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _buildActionButton('Report', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const PrivacyReportScreen(),
                  ),
                );
              }),
              _buildActionButton('Block', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PrivacyBlockScreen()),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
