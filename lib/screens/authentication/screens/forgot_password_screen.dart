import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'reset_password_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen>
    with TickerProviderStateMixin {
  final TextEditingController emailController = TextEditingController();

  final bool showProgressBar = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  bool isEmailValid(String email) {
    return RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(email);
  }

  void showCustomToast({required bool isSuccess}) {
    final overlay = Overlay.of(context);
    late OverlayEntry entry;

    void removeToast() {
      if (entry.mounted) entry.remove();
    }

    entry = OverlayEntry(
      builder:
          (context) => Positioned(
            top: 50, // 50px from the top
            left: MediaQuery.of(context).size.width * 0.025,
            width: MediaQuery.of(context).size.width * 0.95,
            child: Material(
              color: Colors.transparent,
              child: _CustomToastContent(
                showProgressBar: showProgressBar,
                isSuccess: isSuccess,
                onClose: removeToast,
              ),
            ),
          ),
    );

    overlay.insert(entry);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/images/campus_logo.svg', width: 180),
            const SizedBox(height: 40),
            const Text(
              "Forgot Password",
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                fontSize: 20,
                letterSpacing: 1.0,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Registered Email Address",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 5),
            SizedBox(
              width: 360,
              height: 52,
              child: TextField(
                controller: emailController,
                cursorColor: Colors.black,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: "Enter email",
                  hintStyle: const TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Color(0xFF797979),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Color(0xFF797979),
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 1.5,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 360,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  String email = emailController.text.trim();
                  if (isEmailValid(email)) {
                    showCustomToast(isSuccess: true);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ResetPasswordScreen(),
                      ),
                    );
                  } else {
                    showCustomToast(isSuccess: false);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1D97D4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                child: const Text(
                  "Submit",
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomToastContent extends StatefulWidget {
  final bool showProgressBar;
  final bool isSuccess;
  final VoidCallback onClose;

  const _CustomToastContent({
    required this.showProgressBar,
    required this.isSuccess,
    required this.onClose,
  });

  @override
  State<_CustomToastContent> createState() => _CustomToastContentState();
}

class _CustomToastContentState extends State<_CustomToastContent>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    _controller.forward().whenComplete(() {
      widget.onClose();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        widget.isSuccess ? const Color(0xFF14AE5C) : const Color(0xFFD31F34);
    final iconPath =
        widget.isSuccess
            ? 'assets/images/outlined_green_tick.png'
            : 'assets/images/error_icon.png';

    final titleText = widget.isSuccess ? 'Success!' : 'Error!';
    final messages =
        widget.isSuccess
            ? [
              'Password reset link has been sent on your',
              'Please login to continue.',
            ]
            : ['Please enter a valid email address.'];

    final progressColor =
        widget.isSuccess ? const Color(0xFF54D38F) : const Color(0xFFEE8789);

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(iconPath, width: 40, height: 40),
                const SizedBox(width: 10),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        titleText,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          height: 1.0,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      const SizedBox(height: 4),
                      ...messages.map(
                        (msg) => Padding(
                          padding: const EdgeInsets.only(bottom: 2),
                          child: Text(
                            msg,
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              height: 1.0,
                              color: Colors.white,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          if (widget.showProgressBar) ...[
            const SizedBox(height: 5),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  child: LinearProgressIndicator(
                    value: _controller.value,
                    minHeight: 10,
                    backgroundColor: Colors.transparent,
                    valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                  ),
                );
              },
            ),
          ],
        ],
      ),
    );
  }
}
