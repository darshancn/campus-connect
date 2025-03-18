import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(() => setState(() {}));
    _passwordFocusNode.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      fontFamily: 'Inter',
      fontWeight: FontWeight.w500,
      fontSize: 16,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/images/campus_logo.svg', width: 130),
            const SizedBox(height: 20),

            Text("Login", style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 10),
            Text(
              "Enter your email address and password to continue",
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Email Field
            const Align(
              alignment: Alignment.centerLeft,
              child: Text("Email Address", style: textStyle),
            ),
            const SizedBox(height: 5),
            TextField(
              focusNode: _emailFocusNode,
              decoration: InputDecoration(
                hintText: "Enter email",
                hintStyle: textStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide: const BorderSide(
                    color: Color(0xFF797979), // Default border color
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide: const BorderSide(
                    color: Color(
                      0xFF797979,
                    ), // Default border color when not focused
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide: const BorderSide(
                    color: Colors.black, // Border color when focused
                  ),
                ),
                suffixIcon: const Icon(
                  Icons.email_outlined,
                  color: Color(0xFF797979), // Email icon color
                  size: 24,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
              ),
            ),

            const SizedBox(height: 15),

            // Password Field
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Password", style: textStyle),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ForgotPasswordScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "Forgot Password?",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            // const SizedBox(height: 5),
            TextField(
              focusNode: _passwordFocusNode,
              obscureText: _obscureText,
              decoration: InputDecoration(
                hintText: "Enter password",
                hintStyle: textStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide: const BorderSide(
                    color: Color(0xFF797979), // Default border color
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide: const BorderSide(
                    color: Color(
                      0xFF797979,
                    ), // Default border color when not focused
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide: const BorderSide(
                    color: Colors.black, // Border color when focused
                  ),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText
                        ? Icons.lock_outline
                        : Icons.visibility_outlined,
                    color: Color(0xFF797979), // Email icon color
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Login Button
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1D97D4),
                minimumSize: const Size(360, 52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
              child: const Text("Login", style: TextStyle(color: Colors.white)),
            ),

            const SizedBox(height: 30),

            // Sign Up
            const Text(
              "Don’t have an account?",
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                minimumSize: const Size(182, 52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "Sign Up",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),

            // OR Divider
            const Text("OR", style: TextStyle(color: Color(0xFF686161))),
            const SizedBox(height: 10),

            // Social Login
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        // Adjust opacity for a subtle effect
                        spreadRadius: 2,
                        blurRadius: 9,
                        offset: const Offset(0, 2), // Shadow in all directions
                      ),
                    ],
                  ),
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      'assets/images/google_icon.svg',
                      width: 20,
                    ),
                    label: const Text("Google"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      side: const BorderSide(color: Colors.white),
                      // Border color
                      elevation: 0,
                      // Set to 0 since we are using BoxShadow
                      minimumSize: const Size(160, 52),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        // Adjust opacity for a subtle effect
                        spreadRadius: 2,
                        blurRadius: 9,
                        offset: const Offset(0, 2), // Shadow in all directions
                      ),
                    ],
                  ),
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      'assets/images/facebook_icon.svg',
                      width: 20,
                    ),
                    label: const Text("Facebook"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      side: const BorderSide(color: Colors.white),
                      // Border color
                      elevation: 0,
                      // Set to 0 since we are using BoxShadow
                      minimumSize: const Size(160, 52),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
