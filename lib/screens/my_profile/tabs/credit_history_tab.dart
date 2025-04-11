import 'package:flutter/material.dart';

class CreditHistoryTab extends StatelessWidget {
  const CreditHistoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Sample data
    final List<Map<String, dynamic>> history = List.generate(10, (index) {
      return {
        'type': index % 2 == 0 ? 'Credit' : 'Debit',
        'amount': index % 2 == 0 ? '10000+' : '10-',
        'amountColor': index % 2 == 0 ? Color(0xFF14AE5C) : Color(0xFFD31F34),
        'bgColor': index % 2 == 0 ? Color(0xFFF6F6F6) : Colors.white,
      };
    });

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children:
              history.map((item) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 10,
                  ),
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: item['bgColor'],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Left image
                      Container(
                        width: 39,
                        height: 39,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: const DecorationImage(
                            image: AssetImage(
                              'assets/images/credit-balance.png',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),

                      // Labels
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Credit Balance',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: Color(0xFF797979),
                              height: 1.0,
                            ),
                          ),
                          Text(
                            item['type'],
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.black,
                              height: 1.0,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),

                      // Star + amount
                      Row(
                        children: [
                          Container(
                            width: 19,
                            height: 19,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              image: const DecorationImage(
                                image: AssetImage(
                                  'assets/images/buy-credit_star.png',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            item['amount'],
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: item['amountColor'],
                              height: 1.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
        ),
      ),
    );
  }
}
