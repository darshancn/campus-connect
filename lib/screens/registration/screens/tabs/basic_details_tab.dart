import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class BasicDetailsTab extends StatefulWidget {
  const BasicDetailsTab({super.key});

  @override
  _BasicDetailsTabState createState() => _BasicDetailsTabState();
}

class _BasicDetailsTabState extends State<BasicDetailsTab> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Enter your basic details",
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
          ),
          const SizedBox(height: 20),

          // Profile Picture Section
          Center(
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  width: 114,
                  height: 114,
                  decoration: BoxDecoration(
                    color: Color(0xFF343434),
                    shape: BoxShape.circle,
                    image: _image != null
                        ? DecorationImage(
                        image: FileImage(_image!), fit: BoxFit.cover)
                        : null,
                  ),
                ),
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      width: 27,
                      height: 27,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Icon(
                          Icons.camera_alt, size: 20, color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          _buildInputRow("First Name", "Enter", "Last Name", "Enter"),
          _buildInputField("Username", "Enter"),
          _buildInputField("Email Address", "Enter"),
          _buildInputField("Mobile Number", "Enter"),

          // Gender Dropdown
          _buildDropdownField("Gender", ["Male", "Female", "Other"]),

          // Date of Birth
          _buildDatePicker(),

          // Relationship Status Dropdown
          _buildDropdownField(
              "Relationship Status", ["Single", "Married", "Other"]),

          // Type of Relationship Dropdown
          _buildDropdownField("Type of Relationship Sought",
              ["Friendship", "Networking", "Dating", "Other"]),

          const SizedBox(height: 20),

          // Next Button
          Center(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: const Size(360, 52),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text("Next", style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputRow(String label1, String hint1, String label2,
      String hint2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: _buildInputField(label1, hint1)),
        const SizedBox(width: 10),
        Expanded(child: _buildInputField(label2, hint2)),
      ],
    );
  }

  Widget _buildInputField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black)),
        const SizedBox(height: 5),
        TextField(
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xFF797979)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFF797979)),
            ),
            contentPadding: const EdgeInsets.symmetric(
                horizontal: 15, vertical: 10),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildDropdownField(String label, List<String> options) {
    String? selectedValue;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black)),
        const SizedBox(height: 5),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFF797979)),
            ),
            contentPadding: const EdgeInsets.symmetric(
                horizontal: 15, vertical: 10),
          ),
          value: selectedValue,
          items: options
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: (value) => setState(() => selectedValue = value),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildDatePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Date of Birth", style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black)),
        const SizedBox(height: 5),
        TextField(
          controller: TextEditingController(
              text: _selectedDate == null ? "" : "${_selectedDate!
                  .month}-${_selectedDate!.day}-${_selectedDate!.year}"),
          readOnly: true,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: const Icon(Icons.calendar_today, color: Color(0xFF797979)),
              onPressed: () => _selectDate(context),
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFF797979))),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}