

import 'package:flutter/material.dart';

void showPaymentSuccessModal(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, // prevent accidental dismiss
    builder: (BuildContext context) {
      // Auto-close modal after 4 seconds (4000ms)
      Future.delayed(const Duration(milliseconds: 4000), () {
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
      });

      return Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 350,
            height: 124,
            decoration: BoxDecoration(
              color: Colors.white, // ✅ Changed to white
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Row with tick image and "Success"
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/rounded_right_tick.png',
                      width: 30,
                      height: 30,
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Success',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.black,
                        // ✅ Keep black for white bg
                        height: 1.0,
                        letterSpacing: 0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                  'Payment Successfully Done.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Colors.black87,
                    height: 1.0,
                    letterSpacing: 0,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

