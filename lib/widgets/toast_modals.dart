import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:toastification/toastification.dart';

void showErrorToast(BuildContext context) {
  toastification.show(
    context: context,
    title: Text("Error!", style: TextStyle(color: Colors.white)),
    description: Text(
      "Please enter a valid email address.",
      style: TextStyle(color: Colors.white),
    ),
    type: ToastificationType.error,
    autoCloseDuration: Duration(seconds: 3),
    showProgressBar: false,
    backgroundColor: Colors.red[600]!,
    icon: Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: Center(child: Icon(Icons.error, color: Colors.red)),
    ),
  );
}

void showSuccessToast(BuildContext context) {
  toastification.show(
    context: context,
    title: Text(
      "Success!",
      style: TextStyle(
        fontFamily: 'Inter',
        fontWeight: FontWeight.w600,
        fontSize: 14,
        color: Colors.white,
      ),
    ),
    description: Text(
      "Password reset link has been sent on your registered email address.",
      style: TextStyle(
        fontFamily: 'Inter',
        fontWeight: FontWeight.w400,
        fontSize: 14,
        color: Colors.white,
      ),
    ),
    type: ToastificationType.success,
    autoCloseDuration: Duration(seconds: 3),
    showProgressBar: false,
    backgroundColor: Colors.green[600]!,
    icon: Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
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
