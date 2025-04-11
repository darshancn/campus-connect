import 'package:flutter/material.dart';
import '../../widgets/profile_appbar.dart';
import 'my_profile_step_three_screen.dart';

class MyProfileStepTwoScreen extends StatefulWidget {
  const MyProfileStepTwoScreen({super.key});

  @override
  State<MyProfileStepTwoScreen> createState() => _MyProfileStepTwoScreenState();
}

class _MyProfileStepTwoScreenState extends State<MyProfileStepTwoScreen> {
  final List<String> _interests = [
    "Cricket",
    "Music",
    "Book",
    "Swimming",
    "Photography",
    "Football",
  ];

  final List<String> _relationshipStatusOptions = [
    "Single",
    "Married",
    "Divorced",
  ];
  final List<String> _complexionOptions = ["Fair", "Wheatish", "Dark"];
  final List<String> _bodyTypeOptions = ["Fit", "Average", "Muscular", "Heavy"];
  final List<String> _dietOptions = [
    "Vegetarian",
    "Non-Vegetarian",
    "Occasionally",
  ];
  final List<String> _drinkOptions = [
    "Alcoholic",
    "Non-Alcoholic",
    "Occasionally",
  ];
  final List<String> _smokeOptions = ["Smoker", "Non-Smoker", "Occasionally"];
  final List<String> _relationshipTypeOptions = [
    "Adventure",
    "Serious relationship",
    "Friendship",
    "Casual encounters",
  ];
  final List<String> _personalityOptions = [
    "Introvert",
    "Extrovert",
    "Adventurous",
    "Calm",
  ];
  final List<String> _genderSoughtOptions = ["Male", "Female"];

  List<String> _selectedInterests = [];
  String? _selectedRelationshipStatus;
  String? _selectedComplexion;
  String? _selectedBodyType;
  String? _selectedDiet;
  String? _selectedDrink;
  String? _selectedSmoke;
  String? _selectedGender;
  List<String> _selectedRelationshipTypes = [];
  List<String> _selectedPersonalities = [];
  RangeValues _distanceRange = const RangeValues(5, 15);
  RangeValues _ageRange = const RangeValues(20, 30);
  String? _disability;
  final TextEditingController _heightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const ProfileAppBar(title: 'My Profile'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            _buildSectionTitle('Personal Information'),
            const SizedBox(height: 10),
            _buildLabel('Interests'),
            const SizedBox(height: 10),
            _buildChipSelector(_interests, _selectedInterests, multiple: true),
            const SizedBox(height: 10),
            _buildLabel('Relationship Status'),
            const SizedBox(height: 10),
            _buildDropdownSelector(
              _relationshipStatusOptions,
              _selectedRelationshipStatus,
                  (val) => setState(() => _selectedRelationshipStatus = val),
            ),
            const SizedBox(height: 10),
            _buildLabel('Height (in cm)'),
            const SizedBox(height: 10),
            _buildHeightInput(),
            const SizedBox(height: 10),
            _buildLabel('Any Disability'),
            _buildRadioRow(
              ['Yes', 'No'],
              _disability,
                  (value) => setState(() => _disability = value!),
            ),
            _buildLabel('Complexion'),
            const SizedBox(height: 10),
            _buildDropdownSelector(
              _complexionOptions,
              _selectedComplexion,
                  (val) => setState(() => _selectedComplexion = val),
            ),
            const SizedBox(height: 10),
            _buildLabel('Body Type'),
            _buildDropdownSelector(
              _bodyTypeOptions,
              _selectedBodyType,
                  (val) => setState(() => _selectedBodyType = val),
            ),
            const SizedBox(height: 10),
            _buildSectionTitle('Life Styles'),
            const SizedBox(height: 10),
            _buildLifestyleSection(
              'Diet',
              _dietOptions,
              _selectedDiet,
                  (val) => setState(() => _selectedDiet = val),
            ),
            const SizedBox(height: 10),
            _buildLifestyleSection(
              'Drink',
              _drinkOptions,
              _selectedDrink,
                  (val) => setState(() => _selectedDrink = val),
            ),
            const SizedBox(height: 10),
            _buildLifestyleSection(
              'Smoker',
              _smokeOptions,
              _selectedSmoke,
                  (val) => setState(() => _selectedSmoke = val),
            ),
            const SizedBox(height: 25),
            _buildSectionTitle('Meeting Preference'),
            const SizedBox(height: 10),
            _buildLifestyleSection(
              'Gender sought',
              _genderSoughtOptions,
              _selectedGender,
                  (val) => setState(() => _selectedGender = val),
            ),
            const SizedBox(height: 10),
            _buildLabel('Age sought'),
            _buildSimpleRangeSlider(
              _ageRange,
              18,
              60,
                  (val) => setState(() => _ageRange = val),
              'yrs',
            ),
            const SizedBox(height: 10),
            _buildLabel('Maximum Distance'),
            _buildSimpleRangeSlider(
              _distanceRange,
              0,
              25,
                  (val) => setState(() => _distanceRange = val),
              'km',
            ),
            const SizedBox(height: 10),
            _buildLabel('Type of relationship sought'),
            const SizedBox(height: 10),
            _buildChipSelector(
              _relationshipTypeOptions,
              _selectedRelationshipTypes,
              multiple: true,
            ),
            const SizedBox(height: 10),
            _buildLabel('What personality type do you think you have?'),
            const SizedBox(height: 10),
            _buildChipSelector(
              _personalityOptions,
              _selectedPersonalities,
              multiple: true,
            ),
            const SizedBox(height: 20),
            _buildNextButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildSimpleRangeSlider(
      RangeValues values,
      double min,
      double max,
      ValueChanged<RangeValues> onChanged,
      String unit,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RangeSlider(
          values: values,
          min: min,
          max: max,
          divisions: null, // Removes dot markings
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
    );
  }

  Widget _buildSectionTitle(String text) => Padding(
    padding: const EdgeInsets.only(top: 0, bottom: 0),
    child: Text(
      text,
      style: const TextStyle(
        fontFamily: 'Inter',
        fontWeight: FontWeight.w600,
        fontSize: 18,
        color: Colors.black,
      ),
    ),
  );

  Widget _buildLabel(String text) => Padding(
    padding: const EdgeInsets.only(top: 10, bottom: 10),
    child: Text(
      text,
      style: const TextStyle(
        fontFamily: 'Inter',
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
    ),
  );

  Widget _buildHeightInput() {
    return TextField(
      controller: _heightController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFF797979)),
        ),
      ),
      style: const TextStyle(
        fontFamily: 'Inter',
        fontSize: 16,
        color: Colors.black,
      ),
    );
  }

  Widget _buildRadioRow(
      List<String> options,
      String? selected,
      ValueChanged<String?> onChanged,
      ) {
    return Wrap(
      children: options.map((option) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Radio<String>(
              value: option,
              groupValue: selected,
              onChanged: onChanged,
              activeColor: Colors.black,
            ),
            Text(
              option,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            const SizedBox(width: 10),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildChipSelector(
      List<String> options,
      List<String> selectedOptions, {
        bool multiple = false,
      }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Wrap(
          spacing: 15,
          runSpacing: 15,
          children: options.map((option) {
            final isSelected = selectedOptions.contains(option);
            return InkWell(
              onTap: () {
                setState(() {
                  if (multiple) {
                    isSelected
                        ? selectedOptions.remove(option)
                        : selectedOptions.add(option);
                  } else {
                    selectedOptions.clear();
                    selectedOptions.add(option);
                  }
                });
              },
              child: Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF1D97D4) : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(color: Color(0x66000000), blurRadius: 4),
                  ],
                ),
                child: Text(
                  option,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontFamily: 'Inter',
                    fontSize: 14,
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildDropdownSelector(
      List<String> options,
      String? selectedValue,
      ValueChanged<String?> onChanged,
      ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF797979)),
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      height: 52,
      child: DropdownButton<String>(
        value: selectedValue,
        isExpanded: true,
        icon: const Icon(
          Icons.arrow_drop_down,
          size: 16,
          color: Color(0xFF797979),
        ),
        underline: const SizedBox(),
        style: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 16,
          color: Colors.black,
        ),
        onChanged: onChanged,
        items: options
            .map((option) =>
            DropdownMenuItem(value: option, child: Text(option)))
            .toList(),
      ),
    );
  }

  Widget _buildLifestyleSection(
      String title,
      List<String> options,
      String? selectedOption,
      ValueChanged<String> onChanged,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(title),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: options.map((option) {
            final isSelected = option == selectedOption;
            return GestureDetector(
              onTap: () => onChanged(option),
              child: Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: isSelected ? const Color(0xFF1D97D4) : Colors.white,
                  boxShadow: const [
                    BoxShadow(color: Colors.black26, blurRadius: 4),
                  ],
                ),
                child: Text(
                  option,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildNextButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1D97D4),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const MyProfileStepThreeScreen()),
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
}
