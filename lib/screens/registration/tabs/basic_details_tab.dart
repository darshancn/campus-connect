import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class BasicDetailsTab extends StatefulWidget {
  const BasicDetailsTab({super.key});

  @override
  _BasicDetailsTabState createState() => _BasicDetailsTabState();
}

class _BasicDetailsTabState extends State<BasicDetailsTab> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  DateTime? _selectedDate;
  String? _selectedGender;
  String? _selectedRelationshipStatus;
  String? _selectedRelationshipType;

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  Future<void> _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _firstNameController.text = prefs.getString('first_name') ?? '';
      _lastNameController.text = prefs.getString('last_name') ?? '';
      _usernameController.text = prefs.getString('username') ?? '';
      _emailController.text = prefs.getString('email') ?? '';
      _mobileController.text = prefs.getString('mobile') ?? '';
      _selectedGender = prefs.getString('gender');
      _selectedRelationshipStatus = prefs.getString('relationship_status');
      _selectedRelationshipType = prefs.getString('relationship_type');
      String? savedDate = prefs.getString('date_of_birth');
      if (savedDate != null) {
        _selectedDate = DateTime.parse(savedDate);
      }
      String? imagePath = prefs.getString('profile_image');
      if (imagePath != null && File(imagePath).existsSync()) {
        _image = File(imagePath);
      }
    });
  }

  Future<void> _saveData(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<void> _saveDate(DateTime date) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('date_of_birth', date.toIso8601String());
  }

  Future<void> _saveImage(File image) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('profile_image', image.path);
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      _saveImage(_image!);
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
      _saveDate(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProfilePicture(),
          const SizedBox(height: 40),
          _buildInputRow("First Name", _firstNameController, "Last Name", _lastNameController),
          _buildInputField("Username", _usernameController),
          _buildInputField("Email Address", _emailController),
          _buildInputField("Mobile Number", _mobileController),
          _buildDropdownField("Gender", ["Male", "Female", "Other"], _selectedGender, (val) {
            setState(() => _selectedGender = val);
            _saveData("gender", val!);
          }),
          _buildDatePicker(),
          _buildDropdownField("Relationship Status", ["Single", "Married", "Other"], _selectedRelationshipStatus, (val) {
            setState(() => _selectedRelationshipStatus = val);
            _saveData("relationship_status", val!);
          }),
          _buildDropdownField("Type of Relationship Sought", ["Friendship", "Networking", "Dating", "Other"], _selectedRelationshipType, (val) {
            setState(() => _selectedRelationshipType = val);
            _saveData("relationship_type", val!);
          }),
        ],
      ),
    );
  }

  Widget _buildProfilePicture() {
    return Center(
      child: Stack(
        alignment: Alignment.bottomCenter,
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            radius: 57,
            backgroundColor: const Color(0xFF343434),
            backgroundImage: _image != null ? FileImage(_image!) : null,
          ),
          Positioned(
            bottom: -14,
            child: GestureDetector(
              onTap: _pickImage,
              child: const CircleAvatar(
                radius: 16,
                backgroundColor: Color(0xFF797979),
                child: Icon(Icons.camera_alt, size: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputRow(String label1, TextEditingController controller1, String label2, TextEditingController controller2) {
    return Row(
      children: [
        Expanded(child: _buildInputField(label1, controller1)),
        const SizedBox(width: 10),
        Expanded(child: _buildInputField(label2, controller2)),
      ],
    );
  }

  Widget _buildInputField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black)),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          cursorColor: Colors.black,
          onChanged: (value) => _saveData(label.toLowerCase().replaceAll(" ", "_"), value),
          decoration: InputDecoration(
            hintText: "Enter",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildDropdownField(
      String label,
      List<String> options,
      String? selectedValue,
      ValueChanged<String?> onChanged,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 5),
        DropdownButtonFormField<String>(
          value: selectedValue,
          onChanged: onChanged,
          items: options
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          decoration: InputDecoration(
            hintText: 'Select',
            hintStyle: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              fontSize: 16,
              height: 1.0,
              letterSpacing: 0,
              color: Color(0xFF797979),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildDatePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Date of Birth", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black)),
        const SizedBox(height: 5),
        TextField(
          readOnly: true,
          controller: TextEditingController(text: _selectedDate != null ? "${_selectedDate!.month}-${_selectedDate!.day}-${_selectedDate!.year}" : ""),
          onTap: () => _selectDate(context),
          decoration: InputDecoration(
            hintText: "MM-DD-YYYY",
            suffixIcon: const Icon(Icons.calendar_month, color: Colors.grey),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}