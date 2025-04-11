import 'package:flutter/material.dart';

class ToastModal extends StatefulWidget {
  final bool showProgressBar;

  const ToastModal({super.key, this.showProgressBar = true});

  @override
  State<ToastModal> createState() => _ToastModalState();
}

class _ToastModalState extends State<ToastModal>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..forward(); // Starts the animation immediately
  }

  @override
  void dispose() {
    _controller.dispose(); // Clean up the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.95,
          decoration: BoxDecoration(
            color: const Color(0xFF14AE5C),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/outlined_green_tick.png',
                    width: 40,
                    height: 40,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Success!',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            height: 1.0,
                            color: Colors.white,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Registration completed successfully.',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            height: 1.0,
                            color: Colors.white,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Please login to continue.',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            height: 1.0,
                            color: Colors.white,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              if (widget.showProgressBar) ...[
                const SizedBox(height: 5),
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(0),
                      child: LinearProgressIndicator(
                        value: _controller.value, // Determinate value
                        minHeight: 10,
                        backgroundColor: Colors.transparent,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xFF54D38F),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
