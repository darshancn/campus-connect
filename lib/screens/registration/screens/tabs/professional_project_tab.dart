import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfessionalProjectTab extends StatefulWidget {
  const ProfessionalProjectTab({super.key});

  @override
  _ProfessionalProjectTabState createState() => _ProfessionalProjectTabState();
}

class _ProfessionalProjectTabState extends State<ProfessionalProjectTab> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _loadSavedText();
  }

  // Load persisted text from SharedPreferences
  Future<void> _loadSavedText() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _controller.text = prefs.getString('professional_project_text') ?? '';
    });
  }

  // Save text when the user types
  Future<void> _saveText(String text) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('professional_project_text', text);
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Professional Goals or Projects",
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20),

          // Fixed Container with Persistent & Scrollable Content
          Container(
            width: 360,
            height: 256,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF797979), width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Scrollbar(
              child: SingleChildScrollView(
                child: TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  cursorColor: Colors.black,
                  selectionControls: _blackSelectionControls(),
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  onChanged: _saveText, // Save text automatically
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    height: 1.0,
                    color: Colors.black,
                  ),
                  decoration: const InputDecoration(
                    hintText: "I Want To Have A Master In Statistics Because I'd Like To Become A Banker",
                    hintStyle: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      height: 1.0,
                      color: Color(0xFFC4C0C0),
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Custom selection controls to keep selection color black
  TextSelectionControls _blackSelectionControls() {
    return MaterialTextSelectionControls(); // Ensures default behavior but forces black
  }
}
