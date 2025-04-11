import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

class ProfessionStudiesTab extends StatefulWidget {
  const ProfessionStudiesTab({super.key});

  @override
  _ProfessionStudiesTabState createState() => _ProfessionStudiesTabState();
}

class _ProfessionStudiesTabState extends State<ProfessionStudiesTab> {
  final TextEditingController _occupationController = TextEditingController();
  final TextEditingController _academicFieldController = TextEditingController();
  final TextEditingController _universityController = TextEditingController();
  String? _selectedLevel;
  String? _imagePath;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _occupationController.text = prefs.getString('occupation') ?? '';
      _academicFieldController.text = prefs.getString('academicField') ?? '';
      _selectedLevel = prefs.getString('selectedLevel');
      _universityController.text = prefs.getString('university') ?? '';
      _imagePath = prefs.getString('imagePath');
    });
  }

  Future<void> _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('occupation', _occupationController.text);
    await prefs.setString('academicField', _academicFieldController.text);
    await prefs.setString('selectedLevel', _selectedLevel ?? '');
    await prefs.setString('university', _universityController.text);
    if (_imagePath != null) {
      await prefs.setString('imagePath', _imagePath!);
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imagePath = image.path;
      });
      _saveData(); // Save image path persistently
    }
  }

  @override
  void dispose() {
    _saveData();
    _occupationController.dispose();
    _academicFieldController.dispose();
    _universityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLabelWithOptional("Current or Intended Occupation"),
                const SizedBox(height: 10),
                _buildTextField(_occupationController, "Enter"),

                const SizedBox(height: 20),
                _buildLabelWithAsterisk("Academic Field"),
                const SizedBox(height: 10),
                _buildTextField(_academicFieldController, "Enter"),

                const SizedBox(height: 20),
                _buildLabelWithAsterisk("Level of Studies"),
                const SizedBox(height: 10),
                _buildDropdownField(),

                const SizedBox(height: 20),
                _buildLabelWithAsterisk("University or School Attended"),
                const SizedBox(height: 10),
                _buildTextField(_universityController, "Enter"),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabelWithOptional(String label) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            fontSize: 16,
            height: 1.0,
          ),
        ),
        const SizedBox(width: 5),
        const Text(
          "(Optional)",
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.italic,
            fontSize: 12,
            height: 1.0,
          ),
        ),
      ],
    );
  }

  Widget _buildLabelWithAsterisk(String label) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            fontSize: 16,
            height: 1.0,
            color: Colors.black,
          ),
        ),
        const SizedBox(width: 5),
        const Text(
          "*",
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            fontSize: 16,
            height: 1.0,
            color: Color(0xFFD31F34),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText) {
    return SizedBox(
      width: 360,
      height: 52,
      child: TextField(
        controller: controller,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
            fontSize: 16,
            height: 1.0,
            color: Color(0xFF797979),
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFF797979)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.black),
          ),
        ),
        style: const TextStyle(color: Colors.black),
        onChanged: (_) => _saveData(),
      ),
    );
  }

  Widget _buildDropdownField() {
    List<String> levels = ["Undergraduate", "Graduate", "Doctorate"];

    // Make sure _selectedLevel is either null or a valid value from the list
    String? validSelected = levels.contains(_selectedLevel) ? _selectedLevel : null;

    return SizedBox(
      width: 360,
      height: 52,
      child: DropdownButtonFormField<String>(
        value: validSelected,
        onChanged: (value) {
          setState(() {
            _selectedLevel = value;
          });
        },
        items: levels.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFF797979)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.black),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          hintText: 'Select',
          hintStyle: const TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
            fontSize: 16,
            height: 1.0,
            letterSpacing: 0,
            color: Color(0xFF797979),
          ),
        ),
        icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF797979)),
      ),
    );
  }


  Widget _buildImagePicker() {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        width: 360,
        height: 200,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF797979)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: _imagePath == null
            ? const Center(child: Text("Tap to Upload Image"))
            : Image.file(File(_imagePath!), fit: BoxFit.cover),
      ),
    );
  }
}
