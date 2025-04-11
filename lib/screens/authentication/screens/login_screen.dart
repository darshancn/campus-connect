import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'forgot_password_screen.dart';
import 'package:campus_connect/screens/home/home_screen.dart';
import 'package:campus_connect/screens/registration/screens/registration_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _isEmailValid(String email) =>
      email.toLowerCase().endsWith('@gmail.com');

  void _validateAndLogin() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (!_isEmailValid(email)) {
      _showSnackBar("Only @gmail.com emails are allowed");
      return;
    }
    if (password.length < 8) {
      _showSnackBar("Password must be at least 8 characters");
      return;
    }

    Navigator.pushReplacement(
      context,
      _noTransition(const HomeScreen()),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  PageRouteBuilder _noTransition(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => page,
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 55, 20, 20),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: SvgPicture.asset(
                            'assets/images/campus_logo.svg',
                            width: screenSize.width * 0.45,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Center(
                          child: Text(
                            "Login",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Center(
                          child: Text(
                            "Enter your email address and password to continue",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        const SizedBox(height: 24),

                        const _Label("Email Address"),
                        const SizedBox(height: 8),
                        _buildTextField(
                          controller: _emailController,
                          focusNode: _emailFocusNode,
                          hintText: "Enter email",
                          icon: Icons.email_outlined,
                        ),

                        const SizedBox(height: 0),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const _Label("Password"),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  _noTransition(const ForgotPasswordScreen()),
                                );
                              },
                              child: const Text(
                                "Forgot Password?",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        _buildTextField(
                          controller: _passwordController,
                          focusNode: _passwordFocusNode,
                          hintText: "Enter password",
                          obscureText: _obscureText,
                          icon: _obscureText
                              ? Icons.lock_outline
                              : Icons.visibility_outlined,
                          onIconTap: () =>
                              setState(() => _obscureText = !_obscureText),
                        ),

                        const SizedBox(height: 24),
                        _buildButton("Login", onTap: _validateAndLogin),

                        const SizedBox(height: 32),
                        const Center(
                          child: Text(
                            "Don’t have an account?",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        _buildButton(
                          "Sign Up",
                          isPrimary: false,
                          widthFactor: 0.5,
                          onTap: () {
                            Navigator.push(
                              context,
                              _noTransition(const RegistrationScreen()),
                            );
                          },
                        ),

                        const SizedBox(height: 10),
                        const Center(
                          child: Text(
                            "OR",
                            style: TextStyle(color: Color(0xFF686161)),
                          ),
                        ),
                        const SizedBox(height: 10),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildSocialButton(
                              'assets/images/google_icon.svg',
                              "Google",
                            ),
                            _buildSocialButton(
                              'assets/images/facebook_icon.svg',
                              "Facebook",
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String hintText,
    required IconData icon,
    bool obscureText = false,
    VoidCallback? onIconTap,
  }) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: onIconTap != null
            ? IconButton(
          icon: Icon(icon, color: const Color(0xFF797979)),
          onPressed: onIconTap,
        )
            : Icon(icon, color: const Color(0xFF797979)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: const BorderSide(color: Color(0xFF797979)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: const BorderSide(color: Colors.black),
        ),
      ),
    );
  }

  Widget _buildButton(
      String text, {
        VoidCallback? onTap,
        bool isPrimary = true,
        double widthFactor = 1,
      }) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * widthFactor,
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: isPrimary ? const Color(0xFF1D97D4) : Colors.black,
            minimumSize: const Size.fromHeight(52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(text, style: const TextStyle(color: Colors.white)),
        ),
      ),
    );
  }

  Widget _buildSocialButton(String iconPath, String label) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: SvgPicture.asset(iconPath, width: 20),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        minimumSize: const Size(140, 52),
      ),
    );
  }
}

class _Label extends StatelessWidget {
  final String text;

  const _Label(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: 'Inter',
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
    );
  }
}
