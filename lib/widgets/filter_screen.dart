import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  // --- State variables ---
  RangeValues _distanceRange = const RangeValues(0, 25);
  RangeValues _ageRange = const RangeValues(18, 50);
  String _selectedGender = "";
  String _selectedCity = "";
  String _selectedRegion = "";
  String _relationshipSought = "";
  String _profileVerification = "";
  String _selectedReligion = "";
  List<String> _selectedInterests = [];

  // --- Options ---
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

  // --- Helpers ---
  Widget _verticalSpacing([double height = 20]) => SizedBox(height: height);

  void _toggleInterest(String interest) {
    setState(() {
      if (_selectedInterests.contains(interest)) {
        _selectedInterests.remove(interest);
      } else {
        _selectedInterests.add(interest);
      }
    });
  }

  /// Resets all filters to their initial state.
  void _resetFilters() {
    setState(() {
      _distanceRange = const RangeValues(0, 25);
      _ageRange = const RangeValues(18, 60);
      _selectedGender = "";
      _selectedCity = "";
      _selectedRegion = "";
      _relationshipSought = "";
      _profileVerification = "";
      _selectedReligion = "";
      _selectedInterests.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1D97D4),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context, false),
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildRangeSliderBox(
                      "Maximum Distance",
                      _distanceRange,
                      0,
                      25,
                      (val) => setState(() => _distanceRange = val),
                      'km',
                    ),
                    _verticalSpacing(),
                    _buildRangeSliderBox(
                      "Age Sought",
                      _ageRange,
                      18,
                      60,
                      (val) => setState(() => _ageRange = val),
                      'yrs',
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
                      onSelect:
                          (val) => setState(() => _relationshipSought = val),
                    ),
                    _verticalSpacing(),
                    _buildOptionsContainer(
                      title: "Verify Profile",
                      options: ["Verified", "Non-verified"],
                      selected: _profileVerification,
                      onSelect:
                          (val) => setState(() => _profileVerification = val),
                    ),
                    _verticalSpacing(30),
                    Row(
                      children: [
                        // Reset: now clears state in-place
                        _buildButton("Reset", Colors.black, _resetFilters),
                        const SizedBox(width: 16),
                        // Apply: pop with true
                        _buildButton(
                          "Apply",
                          const Color(0xFF1D97D4),
                          () => Navigator.pop(context, true),
                        ),
                      ],
                    ),
                    _verticalSpacing(30),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // --- UI Components ---

  Widget _buildButton(String label, Color color, VoidCallback onTap) {
    return Expanded(
      child: SizedBox(
        height: 52,
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: onTap,
          child: Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
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
    return _buildBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: _titleTextStyle()),
          RangeSlider(
            values: values,
            min: min,
            max: max,
            divisions: null,
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
              Text(
                '${values.start.round()}$unit',
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  height: 1.0,
                  letterSpacing: 0.0,
                  color: Colors.black,
                ),
              ),
              Text(
                '${values.end.round()}$unit',
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  height: 1.0,
                  letterSpacing: 0.0,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGenderSelection() {
    return _buildBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Search Preference", style: _titleTextStyle()),
          _verticalSpacing(12),
          Wrap(
            spacing: 10,
            children:
                ["Women", "Men"]
                    .map(
                      (label) => _buildToggleButton(
                        label,
                        _selectedGender,
                        onTap: () => setState(() => _selectedGender = label),
                      ),
                    )
                    .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildInterestSelection() {
    return _buildBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Interests", style: _titleTextStyle()),
          _verticalSpacing(12),
          Wrap(
            spacing: 8,
            runSpacing: 10,
            children: interests.map(_buildInterestButton).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildReligionSelection() {
    return _buildBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Religion", style: _titleTextStyle()),
          _verticalSpacing(12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children:
                religions
                    .map(
                      (religion) => _buildToggleButton(
                        religion,
                        _selectedReligion,
                        onTap:
                            () => setState(() => _selectedReligion = religion),
                      ),
                    )
                    .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCityRegionDropdown() {
    return _buildBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("City", style: _titleTextStyle()),
          _verticalSpacing(8),
          _buildDropdown(
            "City",
            _selectedCity,
            cities,
            Icons.location_on,
            (val) => setState(() => _selectedCity = val!),
          ),
          _verticalSpacing(16),
          Text("Region", style: _titleTextStyle()),
          _verticalSpacing(8),
          _buildDropdown(
            "Select",
            _selectedRegion,
            regions,
            null,
            (val) => setState(() => _selectedRegion = val!),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(
    String hint,
    String value,
    List<String> items,
    IconData? icon,
    ValueChanged<String?> onChanged,
  ) {
    return DropdownButtonFormField<String>(
      value: value.isEmpty ? null : value,
      icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
      decoration: InputDecoration(
        prefixIcon:
            icon != null ? Icon(icon, color: const Color(0xFF1D97D4)) : null,
        hintText: hint,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      items:
          items
              .map((item) => DropdownMenuItem(value: item, child: Text(item)))
              .toList(),
      onChanged: onChanged,
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
          boxShadow: const [
            BoxShadow(
              color: Color(0x66000000), // #00000040
              blurRadius: 4,
              offset: Offset(0, 0),
            ),
          ],
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
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1D97D4) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          // border: Border.all(
          //   color: isSelected ? const Color(0xFF1D97D4) : Colors.black26,
          // ),
          boxShadow: [
            BoxShadow(
              color: const Color(0x66000000), // #00000040 in hex with opacity
              blurRadius: 4,
              offset: Offset(0, 0),
            ),
          ],
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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: const Color(0x66000000), // #00000040 in hex with opacity
            blurRadius: 4,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: _titleTextStyle()),
          _verticalSpacing(12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children:
                options
                    .map(
                      (option) => _buildToggleButton(
                        option,
                        selected,
                        onTap: () => onSelect(option),
                      ),
                    )
                    .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildBox({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: child,
    );
  }

  TextStyle _titleTextStyle() =>
      const TextStyle(fontWeight: FontWeight.w700, fontSize: 14);

  TextStyle _valueTextStyle() =>
      const TextStyle(fontWeight: FontWeight.w500, fontSize: 12);
}
