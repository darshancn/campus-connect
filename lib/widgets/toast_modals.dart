import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:toastification/toastification.dart';

void showErrorToast(BuildContext context) {
  toastification.show(
    context: context,
    title: const Text("Error!", style: TextStyle(color: Colors.white)),
    description: const Text(
      "Please enter a valid email address.",
      style: TextStyle(color: Colors.white),
    ),
    type: ToastificationType.error,
    autoCloseDuration: const Duration(seconds: 3),
    showProgressBar: false,
    backgroundColor: Colors.red[600]!,
    icon: Container(
      width: 40,
      height: 40,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: const Center(child: Icon(Icons.error, color: Colors.red)),
    ),
  );
}

void showSuccessToast(BuildContext context) {
  toastification.show(
    context: context,
    title: const Text(
      "Success!",
      style: TextStyle(
        fontFamily: 'Inter',
        fontWeight: FontWeight.w600,
        fontSize: 14,
        color: Colors.white,
      ),
    ),
    description: const Text(
      "Password reset link has been sent on your registered email address.",
      style: TextStyle(
        fontFamily: 'Inter',
        fontWeight: FontWeight.w400,
        fontSize: 14,
        color: Colors.white,
      ),
    ),
    type: ToastificationType.success,
    autoCloseDuration: const Duration(seconds: 3),
    showProgressBar: false,
    backgroundColor: Colors.green[600]!,
    icon: Container(
      width: 40,
      height: 40,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: Center(
        child: SvgPicture.asset(
          'assets/images/success_toast_icon.svg',
          width: 24,
          height: 24,
        ),
      ),
    ),
  );
}

void showProfileSuccessToast(BuildContext context) {
  toastification.show(
    context: context,
    alignment: Alignment.bottomCenter,
    type: ToastificationType.success,
    autoCloseDuration: const Duration(milliseconds: 4000),
    backgroundColor: const Color(0xFF14AE5C),
    showProgressBar: true,
    progressBarTheme: const ProgressIndicatorThemeData(
      color: Color(0xFF54D38F), // ✅ Progress bar color
      linearTrackColor: Colors.transparent,
      linearMinHeight: 10, // ✅ Bar height
    ),
    icon: Container(
      width: 40,
      height: 40,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: Center(
        child: SvgPicture.asset(
          'assets/images/success_toast_icon.svg',
          width: 24,
          height: 24,
        ),
      ),
    ),
    title: const Text(
      "Success!",
      style: TextStyle(
        fontFamily: 'Inter',
        fontWeight: FontWeight.w600,
        fontSize: 14,
        height: 1.0,
        color: Colors.white,
      ),
    ),
    description: const Text(
      "Profile updated successfully.",
      style: TextStyle(
        fontFamily: 'Inter',
        fontWeight: FontWeight.w400,
        fontSize: 14,
        height: 1.0,
        color: Colors.white,
      ),
    ),
    closeButtonShowType: CloseButtonShowType.always,

    padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
  );
}
