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




// -----------------------------------------------------------------------------
//
//
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
//
// class CustomToastContent extends StatefulWidget {
//   final String title;
//   final String message;
//   final Color backgroundColor;
//   final Widget icon;
//
//   const CustomToastContent({
//     super.key,
//     required this.title,
//     required this.message,
//     required this.backgroundColor,
//     required this.icon,
//   });
//
//   @override
//   State<CustomToastContent> createState() => _CustomToastContentState();
// }
//
// class _CustomToastContentState extends State<CustomToastContent>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(seconds: 4),
//       vsync: this,
//     )..forward();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 100, // Increased height for progress bar space
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       decoration: BoxDecoration(
//         color: widget.backgroundColor,
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               widget.icon,
//               const SizedBox(width: 10),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       widget.title,
//                       style: const TextStyle(
//                         fontFamily: 'Inter',
//                         fontWeight: FontWeight.w600,
//                         fontSize: 14,
//                         color: Colors.white,
//                         decoration: TextDecoration.none,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       widget.message,
//                       style: const TextStyle(
//                         fontFamily: 'Inter',
//                         fontWeight: FontWeight.w400,
//                         fontSize: 14,
//                         color: Colors.white,
//                         decoration: TextDecoration.none,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 5),
//           AnimatedBuilder(
//             animation: _controller,
//             builder: (context, child) {
//               return ClipRRect(
//                 borderRadius: BorderRadius.circular(0),
//                 child: LinearProgressIndicator(
//                   value: _controller.value,
//                   minHeight: 10,
//                   backgroundColor: Colors.transparent,
//                   valueColor: const AlwaysStoppedAnimation<Color>(
//                     Color(0xFF54D38F),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
