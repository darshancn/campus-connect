import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  RangeValues _distanceRange = const RangeValues(0, 25);
  RangeValues _ageRange = const RangeValues(18, 50);

  String _selectedGender = "";
  String _selectedCity = "";
  String _selectedRegion = "";
  String _relationshipSought = "";
  String _profileVerification = "";
  String _selectedReligion = "";

  List<String> _selectedInterests = [];
  final List<String> interests = [
    "Cricket",
    "Music",
    "Books",
    "Swimming",
    "Photography",
    "Football",
  ];

  final List<String> religions = [
    "Hinduism",
    "Islam",
    "Christianity",
    "Buddhism",
    "Sikhism",
  ];

  final List<String> cities = ["Delhi", "Mumbai", "Chennai", "Bangalore"];
  final List<String> regions = ["North", "South", "East", "West"];

  void _toggleInterest(String interest) {
    setState(() {
      if (_selectedInterests.contains(interest)) {
        _selectedInterests.remove(interest);
      } else {
        _selectedInterests.add(interest);
      }
    });
  }

  Widget _verticalSpacing([double height = 20]) => SizedBox(height: height);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1D97D4),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Filter',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        toolbarHeight: 73,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildRangeSliderBox(
              "Maximum Distance",
              _distanceRange,
              0,
              25,
              (values) => setState(() => _distanceRange = values),
              "km",
            ),
            _verticalSpacing(),
            _buildRangeSliderBox(
              "Age Sought",
              _ageRange,
              18,
              50,
              (values) => setState(() => _ageRange = values),
              "yrs",
            ),
            _verticalSpacing(),
            _buildGenderSelection(),
            _verticalSpacing(),
            _buildInterestSelection(),
            _verticalSpacing(),
            _buildReligionSelection(),
            _verticalSpacing(),
            _buildCityRegionDropdown(),
            _verticalSpacing(),
            _buildOptionsContainer(
              title: "Relationship Sought",
              options: [
                "Adventure",
                "Serious Relationship",
                "Friendship",
                "Casual encounters",
              ],
              selected: _relationshipSought,
              onSelect: (val) => setState(() => _relationshipSought = val),
            ),
            _verticalSpacing(),
            _buildOptionsContainer(
              title: "Verify Profile",
              options: ["Verified", "Non-verified"],
              selected: _profileVerification,
              onSelect: (val) => setState(() => _profileVerification = val),
            ),
            _verticalSpacing(30),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 52,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton(
                      onPressed: () {
                        // reset logic
                      },
                      child: const Text(
                        "Reset",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Container(
                    height: 52,
                    decoration: BoxDecoration(
                      color: Color(0xFF1D97D4),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton(
                      onPressed: () {
                        // apply logic
                      },
                      child: const Text(
                        "Apply",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            _verticalSpacing(30),
          ],
        ),
      ),
    );
  }

  Widget _buildRangeSliderBox(
    String title,
    RangeValues values,
    double min,
    double max,
    ValueChanged<RangeValues> onChanged,
    String unit,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: _boxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: _titleTextStyle()),
          RangeSlider(
            values: values,
            min: min,
            max: max,
            divisions: (max - min).toInt(),
            labels: RangeLabels(
              '${values.start.round()}$unit',
              '${values.end.round()}$unit',
            ),
            activeColor: const Color(0xFF1D97D4),
            onChanged: onChanged,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${values.start.round()}$unit', style: _valueTextStyle()),
              Text('${values.end.round()}$unit', style: _valueTextStyle()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGenderSelection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: _boxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Search Preference", style: _titleTextStyle()),
          _verticalSpacing(12),
          Row(
            children: [
              _buildToggleButton("Women", _selectedGender),
              const SizedBox(width: 10),
              _buildToggleButton("Men", _selectedGender),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInterestSelection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: _boxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Interests", style: _titleTextStyle()),
          _verticalSpacing(12),
          Wrap(
            spacing: 8,
            runSpacing: 10,
            children:
                interests
                    .map((interest) => _buildInterestButton(interest))
                    .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildReligionSelection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: _boxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Religion", style: _titleTextStyle()),
          _verticalSpacing(12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children:
                religions.map((religion) {
                  final selected = _selectedReligion == religion;
                  return _buildToggleButton(
                    religion,
                    _selectedReligion,
                    onTap: () => setState(() => _selectedReligion = religion),
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCityRegionDropdown() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: _boxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("City", style: _titleTextStyle()), // Side heading
          _verticalSpacing(8),
          _buildDropdownWithIcon(
            hint: "City",
            value: _selectedCity,
            items: cities,
            onChanged: (val) => setState(() => _selectedCity = val!),
            icon: Icons.location_on, // Location icon on the left
          ),
          _verticalSpacing(16),
          Text("Region", style: _titleTextStyle()), // Side heading
          _verticalSpacing(8),
          _buildDropdownWithIcon(
            hint: "Select",
            value: _selectedRegion,
            items: regions,
            onChanged: (val) => setState(() => _selectedRegion = val!),
            icon: null, // No icon for region field
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownWithIcon({
    required String hint,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    IconData? icon,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black26),
      ),
      child: DropdownButtonFormField<String>(
        value: value.isEmpty ? null : value,
        icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
        // Dropdown icon to the right
        decoration: InputDecoration(
          prefixIcon:
              icon != null ? Icon(icon, color: Color(0xFF1D97D4)) : null,
          // Left icon if provided
          hintText: hint,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 12,
          ),
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.black),
          ),
        ),
        items:
            items.map((item) {
              return DropdownMenuItem(value: item, child: Text(item));
            }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildInterestButton(String interest) {
    final selected = _selectedInterests.contains(interest);
    return GestureDetector(
      onTap: () => _toggleInterest(interest),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF1D97D4) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? const Color(0xFF1D97D4) : Colors.black26,
          ),
        ),
        child: Text(
          interest,
          style: TextStyle(
            color: selected ? Colors.white : Colors.black,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildToggleButton(
    String label,
    String selected, {
    VoidCallback? onTap,
  }) {
    final isSelected = label == selected;
    return GestureDetector(
      onTap:
          onTap ??
          () => setState(() => _selectedGender = isSelected ? "" : label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1D97D4) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? const Color(0xFF1D97D4) : Colors.black26,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildOptionsContainer({
    required String title,
    required List<String> options,
    required String selected,
    required Function(String) onSelect,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: _boxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: _titleTextStyle()),
          _verticalSpacing(12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children:
                options.map((option) {
                  return _buildToggleButton(
                    option,
                    selected,
                    onTap: () => onSelect(option),
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      boxShadow: const [
        BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2)),
      ],
    );
  }

  TextStyle _titleTextStyle() =>
      const TextStyle(fontWeight: FontWeight.w700, fontSize: 14);

  TextStyle _valueTextStyle() =>
      const TextStyle(fontWeight: FontWeight.w500, fontSize: 12);
}
