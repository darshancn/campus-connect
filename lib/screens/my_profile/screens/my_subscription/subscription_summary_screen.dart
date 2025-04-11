import 'package:campus_connect/screens/my_profile/screens/my_subscription/payment_method_screen.dart';
import 'package:flutter/material.dart';

class SubscriptionSummaryScreen extends StatefulWidget {
  const SubscriptionSummaryScreen({super.key});

  @override
  State<SubscriptionSummaryScreen> createState() =>
      _SubscriptionSummaryScreenState();
}

class _SubscriptionSummaryScreenState extends State<SubscriptionSummaryScreen> {
  int _selectedPaymentIndex = 0;

  final List<Map<String, dynamic>> _paymentMethods = [
    {'icon': 'assets/images/credit_card.png', 'label': 'Credit / Debit Card'},
    {'icon': 'assets/images/apple_pay.png', 'label': 'Apple Pay'},
    {'icon': 'assets/images/google_wallet.png', 'label': 'Google Wallet'},
    {'icon': 'assets/images/paypal.png', 'label': 'PayPal'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xFF1D97D4),
          elevation: 1,
          centerTitle: true,
          flexibleSpace: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const SizedBox(
                      width: 30,
                      height: 30,
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                  ),
                  const Text(
                    'Summary',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 30),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            // Subscription Box
            Container(
              width: 383,
              height: 140,
              decoration: BoxDecoration(
                color: const Color(0xFF1D97D4),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Plan + Price Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        '1 Day Subscription',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '€10',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Bullet Points
                  bulletPoint('Basic Profile creation and browsing'),
                  bulletPoint('Limited daily Matches.'),
                  bulletPoint('Access to some basic features.'),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Choose Payment Method Title
            const Text(
              'Choose Payment Method',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 12),

            // Payment Method Box
            Container(
              width: 383,
              height: 250,
              decoration: BoxDecoration(
                color: const Color(0xFF1D97D4),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: List.generate(_paymentMethods.length, (index) {
                  final method = _paymentMethods[index];
                  return Column(
                    children: [
                      RadioListTile<int>(
                        value: index,
                        groupValue: _selectedPaymentIndex,
                        onChanged: (value) {
                          setState(() {
                            _selectedPaymentIndex = value!;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                        dense: true,
                        visualDensity: const VisualDensity(
                          horizontal: 0,
                          vertical: 1,
                        ),
                        activeColor: const Color(0xFF1D97D4),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        title: Row(
                          children: [
                            Image.asset(
                              method['icon'],
                              width: 27,
                              height: 24,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 15),
                            Text(
                              method['label'],
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        fillColor: MaterialStateProperty.resolveWith((states) {
                          return Colors.white;
                        }),
                        shape: const CircleBorder(
                          side: BorderSide(color: Colors.white),
                        ),
                      ),
                      if (index != _paymentMethods.length - 1)
                        const Divider(
                          color: Colors.white,
                          thickness: 1,
                          indent: 9,
                          endIndent: 9,
                          height: 8,
                        ),
                    ],
                  );
                }),
              ),
            ),

            const Spacer(),

            // Pay Button
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PaymentMethodScreen(),
                  ),
                );
              },
              child: Container(
                width: 400,
                height: 52,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8B903),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: const Center(
                  child: Text(
                    'Pay €10',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget bulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 5,
            height: 5,
            margin: const EdgeInsets.only(right: 8),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
