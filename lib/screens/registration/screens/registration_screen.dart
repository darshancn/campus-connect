import 'package:flutter/material.dart';
import '../../authentication/screens/login_screen.dart';
import '../tabs/academic_project_tab.dart';
import '../tabs/basic_details_tab.dart';
import '../tabs/profession_studies_tab.dart';
import '../tabs/professional_project_tab.dart';
import '../tabs/set_credentials_tab.dart';
import '../widgets/next_button.dart';
import '../widgets/tab_indicator.dart';
import '../widgets/toast_modal.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    const BasicDetailsTab(),
    const ProfessionStudiesTab(),
    const AcademicProjectTab(),
    const ProfessionalProjectTab(),
    const SetCredentialsTab(),
  ];

  final List<String> _tabTitles = [
    "Basic Details",
    "Profession and Studies Details",
    "Academic Project",
    "Professional Project",
    "Set Credentials",
  ];

  void _nextTab() {
    if (_currentIndex < _tabs.length - 1) {
      setState(() {
        _currentIndex++;
      });
    } else {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const ToastModal(),
      );

      Future.delayed(const Duration(milliseconds: 4000), () {
        Navigator.of(context).pop(); // remove toast
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      });
    }
  }

  void _previousTab() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
      });
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1D97D4),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
          onPressed: _previousTab,
        ),
        title: Text(
          _tabTitles[_currentIndex],
          style: const TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          TabIndicator(currentIndex: _currentIndex, totalTabs: _tabs.length),
          Expanded(child: _tabs[_currentIndex]),
          NextButton(
            onPressed: _nextTab,
            text: _currentIndex == _tabs.length - 1 ? 'Submit' : 'Next',
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
