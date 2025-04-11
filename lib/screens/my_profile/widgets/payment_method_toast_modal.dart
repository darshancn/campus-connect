import 'package:flutter/material.dart';

void showPaymentToastModal(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      Future.delayed(const Duration(milliseconds: 2500), () {
        Navigator.of(context).pop(); // Dismiss after 2400ms
      });

      return Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 350,
            height: 161,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Rolling animation at top center
                Positioned(
                  top: 26,
                  left: 145,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                    ),
                    child: const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 4,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
                // Text at center
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Text(
                      "Processing Payment",
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.black,
                        height: 1.0,
                        letterSpacing: 0,
                      ),
                      textAlign: TextAlign.center,
                    ),
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
