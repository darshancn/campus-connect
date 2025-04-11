import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/profile_appbar.dart';
import 'my_profile_step_two_screen.dart';

class YourProfileScreen extends StatefulWidget {
  const YourProfileScreen({super.key});

  @override
  State<YourProfileScreen> createState() => _YourProfileScreenState();
}

class _YourProfileScreenState extends State<YourProfileScreen> {
  List<File> _selectedImages = [];
  List<String> _imagePaths = [];

  final List<String> _religions = [
    "Hinduism",
    "Islam",
    "Christianity",
    "Buddhism",
    "Sikhism",
  ];

  String? _selectedReligion;
  String? _selectedCommunity;
  String? _selectedSubCommunity;
  String? _selectedZodiac;
  String? _selectedCity;
  String? _selectedRegion;

  final LatLng eventLocation = LatLng(48.8566, 2.3522); // Paris coordinates

  File? _image;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  DateTime? _selectedDate;
  String? _selectedGender;
  String? _selectedRelationshipStatus;
  String? _selectedRelationshipType;

  @override
  void initState() {
    super.initState();
    _loadSavedData();
    _loadSavedImages();
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

  Future<void> _saveImagePaths() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('selected_image_paths', _imagePaths);
  }

  Future<void> _pickMultipleImages() async {
    final List<XFile>? images = await _picker.pickMultiImage();
    if (images != null && images.isNotEmpty) {
      setState(() {
        final newFiles = images.map((xfile) => File(xfile.path)).toList();
        _selectedImages.addAll(newFiles);
        _imagePaths.addAll(images.map((xfile) => xfile.path));
      });
      await _saveImagePaths(); // Save updated list to local storage
    }
  }

  Future<void> _loadSavedImages() async {
    final prefs = await SharedPreferences.getInstance();
    final paths = prefs.getStringList('selected_image_paths') ?? [];
    setState(() {
      _imagePaths = paths;
      _selectedImages = paths.map((path) => File(path)).toList();
    });
  }

  Future<void> _clearSavedImages() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('selected_image_paths');
    setState(() {
      _selectedImages.clear();
      _imagePaths.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenPadding = MediaQuery.of(context).size.width * 0.05;

    return Scaffold(
      appBar: const ProfileAppBar(title: 'My Profile'),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: screenPadding, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfilePicture(),
            const SizedBox(height: 40),
            _buildImageGalleryScroller(),
            const SizedBox(height: 20),
            _buildInputRow(
              "First Name",
              _firstNameController,
              "Last Name",
              _lastNameController,
            ),
            _buildInputField("Username", _usernameController),
            _buildInputField("Email Address", _emailController),
            _buildInputField("Mobile Number", _mobileController),
            _buildDropdownField(
              "Gender",
              ["Male", "Female", "Other"],
              _selectedGender,
              (val) {
                setState(() => _selectedGender = val);
                _saveData("gender", val!);
              },
            ),
            _buildDatePicker(),
            _buildDropdownField(
              "Relationship Status",
              ["Single", "Married", "Other"],
              _selectedRelationshipStatus,
              (val) {
                setState(() => _selectedRelationshipStatus = val);
                _saveData("relationship_status", val!);
              },
            ),
            _buildDropdownField(
              "Type of Relationship Sought",
              ["Friendship", "Networking", "Dating", "Other"],
              _selectedRelationshipType,
              (val) {
                setState(() => _selectedRelationshipType = val);
                _saveData("relationship_type", val!);
              },
            ),
            const SizedBox(height: 10),
            _buildSectionTitle("Address Details"),
            const SizedBox(height: 16),
            _buildSubHeading("City"),
            const SizedBox(height: 8),
            _buildDropdownInput(
              "City",
              ["Paris", "London", "Berlin"],
              value:
                  ["Paris", "London", "Berlin"].contains(_selectedCity)
                      ? _selectedCity
                      : null,
              onChanged: (val) => setState(() => _selectedCity = val),
            ),
            const SizedBox(height: 16),
            _buildSubHeading("Region"),
            const SizedBox(height: 8),
            _buildDropdownInput(
              "Region",
              ["Paris", "London", "Berlin"],
              // replace with actual regions if different
              value:
                  ["Paris", "London", "Berlin"].contains(_selectedRegion)
                      ? _selectedRegion
                      : null,
              onChanged: (val) => setState(() => _selectedRegion = val),
            ),
            const SizedBox(height: 16),
            _buildMapBox(),
            const SizedBox(height: 30),
            _buildSectionTitle("Community Details"),
            const SizedBox(height: 16),
            _buildSubHeading("Religion"),
            const SizedBox(height: 10),
            _buildReligionSearch(),
            const SizedBox(height: 20),
            _buildReligionChips(),
            const SizedBox(height: 20),
            _buildSubHeading("Community"),
            const SizedBox(height: 10),
            _buildDropdownInput(
              "Community",
              ["Community 1", "Community 2", "Community 3"],
              value:
                  [
                        "Community 1",
                        "Community 2",
                        "Community 3",
                      ].contains(_selectedCommunity)
                      ? _selectedCommunity
                      : null,
              onChanged: (val) => setState(() => _selectedCommunity = val),
            ),
            const SizedBox(height: 20),
            _buildSubHeading("Sub-Community"),
            const SizedBox(height: 10),
            _buildDropdownInput(
              "Sub-Community",
              ["Sub-Community 1", "Sub-Community 2"],
              value: _selectedSubCommunity,
              onChanged: (val) => setState(() => _selectedSubCommunity = val),
            ),
            const SizedBox(height: 30),
            _buildSectionTitle("Astrological Details"),
            const SizedBox(height: 16),
            _buildSubHeading("Astrological Signs"),
            const SizedBox(height: 10),
            _buildDropdownInput(
              "Select Sign",
              [
                "Pisces",
                "Aries",
                "Taurus",
                "Gemini",
                "Cancer",
                "Leo",
                "Virgo",
                "Libra",
                "Scorpio",
                "Sagittarius",
                "Capricorn",
                "Aquarius",
              ],
              value: _selectedZodiac,
              onChanged: (val) => setState(() => _selectedZodiac = val),
            ),
            const SizedBox(height: 40),
            _buildNextButton(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildProfilePicture() {
    return Center(
      child: Stack(
        alignment: Alignment.bottomCenter,
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.all(2), // border width
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Color(0xFFFF9500), width: 2),
            ),
            child: CircleAvatar(
              radius: 57,
              backgroundColor: const Color(0xFF343434),
              backgroundImage: _image != null ? FileImage(_image!) : null,
            ),
          ),
          Positioned(
            bottom: -14,
            child: GestureDetector(
              onTap: _pickImage,
              child: const CircleAvatar(
                radius: 16,
                backgroundColor: Color(0xFF1D97D4), // Changed to #1D97D4
                child: Icon(Icons.camera_alt, size: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputRow(
    String label1,
    TextEditingController controller1,
    String label2,
    TextEditingController controller2,
  ) {
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
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          cursorColor: Colors.black,
          onChanged:
              (value) =>
                  _saveData(label.toLowerCase().replaceAll(" ", "_"), value),
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
          items:
              options
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
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
        const Text(
          "Date of Birth",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 5),
        TextField(
          readOnly: true,
          controller: TextEditingController(
            text:
                _selectedDate != null
                    ? "${_selectedDate!.month}-${_selectedDate!.day}-${_selectedDate!.year}"
                    : "",
          ),
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

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontFamily: 'Inter',
        fontWeight: FontWeight.w600,
        fontSize: 18,
        color: Colors.black,
      ),
    );
  }

  Widget _buildSubHeading(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: 'Inter',
        fontWeight: FontWeight.w500,
        fontSize: 16,
        color: Colors.black,
      ),
    );
  }

  Widget _buildDropdownInput(
    String hint,
    List<String> options, {
    String? value,
    void Function(String?)? onChanged,
  }) {
    final validValue =
        (value != null && options.contains(value)) ? value : null;
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF797979)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: validValue,
          hint: Text(
            hint,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xFF797979),
            ),
          ),
          icon: const Icon(
            Icons.arrow_drop_down,
            color: Color(0xFF797979),
            size: 24,
          ),
          items:
              options.toSet().map((String option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(
                    option,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                );
              }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildLocationInput(String label, String regionName) {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF797979)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const Icon(Icons.location_on, color: Color(0xFF797979), size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              regionName,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const Icon(Icons.arrow_drop_down, color: Color(0xFF797979)),
        ],
      ),
    );
  }

  Widget _buildMapBox() {
    return Container(
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: FlutterMap(
          options: MapOptions(initialCenter: eventLocation, initialZoom: 15),
          children: [
            TileLayer(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c'],
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point: eventLocation,
                  width: 40,
                  height: 40,
                  child: const Icon(
                    Icons.location_pin,
                    color: Colors.red,
                    size: 40,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReligionSearch() {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [BoxShadow(color: Color(0x66000000), blurRadius: 4)],
      ),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 13),
            child: Icon(Icons.search, color: Color(0xFF797979), size: 24),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                hintText: "Search",
                hintStyle: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Color(0xFF797979),
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReligionChips() {
    return Wrap(
      spacing: 10, // horizontal spacing between chips
      runSpacing: 10, // vertical spacing between chip rows
      children:
          _religions.map((religion) {
            final isSelected = _selectedReligion == religion;
            return Material(
              elevation: 0,
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF1D97D4) : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x66000000), // #00000040
                      blurRadius: 4,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () => setState(() => _selectedReligion = religion),
                    child: Text(
                      religion,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontFamily: 'Inter',
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
    );
  }

  Widget _buildNextButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1D97D4),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const MyProfileStepTwoScreen()),
          );
        },
        child: const Text(
          "Update: Next",
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildImageGalleryScroller() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _selectedImages.length + 1,
        itemBuilder: (context, index) {
          if (index == _selectedImages.length) {
            // "Add Image" tile
            return GestureDetector(
              onTap: _pickMultipleImages,
              child: Container(
                width: 100,
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/add-image.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          }
          // Existing selected image
          return Container(
            width: 100,
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: FileImage(_selectedImages[index]),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
