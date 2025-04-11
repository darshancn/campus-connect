import 'package:flutter/material.dart';
import '../../../../widgets/toast_modals.dart';
import '../../my_profile_tab_screen.dart';
import '../../widgets/profile_appbar.dart';

class MyProfileStepThreeScreen extends StatefulWidget {
  const MyProfileStepThreeScreen({super.key});

  @override
  State<MyProfileStepThreeScreen> createState() =>
      _MyProfileStepThreeScreenState();
}

class _MyProfileStepThreeScreenState extends State<MyProfileStepThreeScreen> {
  final TextEditingController occupationController = TextEditingController();
  final TextEditingController courseController = TextEditingController();
  final TextEditingController universityController = TextEditingController();
  final TextEditingController academicProjectController =
      TextEditingController();
  final TextEditingController professionalProjectController =
      TextEditingController();
  final TextEditingController weightController = TextEditingController();

  List<String> selectedSizes = [];
  bool onlyMatches = true;
  bool newInteractions = true;
  bool likes = true;
  bool messages = true;

  final List<String> _sizes = ['Small', 'Medium', 'Large'];

  Widget _buildChipSelector(
    List<String> options,
    List<String> selectedOptions, {
    bool multiple = false,
  }) {
    return Wrap(
      spacing: 15,
      runSpacing: 15,
      children:
          options.map((option) {
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
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
  }

  Widget _buildTextField(
    String hint,
    TextEditingController controller, {
    int maxLines = 1,
    bool isNumber = false,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      style: const TextStyle(
        fontFamily: 'Inter',
        fontWeight: FontWeight.w400,
        fontSize: 16,
        color: Colors.black,
        height: 1,
      ),
      decoration: InputDecoration(
        hintText: hint,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(width: 1, color: Color(0xFF797979)),
        ),
      ),
    );
  }

  Widget _buildLabel(
    String text, {
    FontWeight fontWeight = FontWeight.w500,
    double fontSize = 16,
  }) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Inter',
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: Colors.black,
        height: 1,
      ),
    );
  }

  Widget _buildToggle(
    String label,
    bool value,
    void Function(bool?) onChanged,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: const Color(0xFFFFFFFF),
          activeTrackColor: const Color(0xFF14AE5C),
          inactiveThumbColor: const Color(0xFFFFFFFF),
          inactiveTrackColor: const Color(0xFF797979),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ProfileAppBar(title: 'My Profile'),
      body: ListView(
        padding: const EdgeInsets.all(20),
        physics: const BouncingScrollPhysics(),
        children: [
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel(
                    'Profession and Studies Details',
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                  const SizedBox(height: 20),

                  _buildLabel('Current or intended occupation'),
                  const SizedBox(height: 8),
                  _buildTextField('Software Engineer', occupationController),
                  const SizedBox(height: 20),

                  _buildLabel('University Course'),
                  const SizedBox(height: 8),
                  _buildTextField('Data Science', courseController),
                  const SizedBox(height: 20),

                  _buildLabel('Level of studies'),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color(0xFF797979),
                          width: 1,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                    ),
                    items:
                        [
                              'Bachelor\'s degree 1',
                              'Bachelor\'s degree 2',
                              'Bachelor\'s degree 3',
                            ]
                            .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)),
                            )
                            .toList(),
                    onChanged: (String? value) {},
                  ),

                  const SizedBox(height: 20),
                  _buildLabel('University or school attended'),
                  const SizedBox(height: 8),
                  _buildTextField('Your University', universityController),
                  const SizedBox(height: 20),

                  _buildLabel('Academic Project'),
                  const SizedBox(height: 8),
                  _buildTextField(
                    'Your academic project details',
                    academicProjectController,
                    maxLines: 5,
                  ),
                  const SizedBox(height: 20),

                  _buildLabel('Professional Project'),
                  const SizedBox(height: 8),
                  _buildTextField(
                    'Your professional project details',
                    professionalProjectController,
                    maxLines: 5,
                  ),
                  const SizedBox(height: 30),

                  _buildLabel(
                    'Physical criteria',
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                  const SizedBox(height: 20),

                  _buildLabel('Size'),
                  const SizedBox(height: 8),
                  _buildChipSelector(_sizes, selectedSizes),
                  const SizedBox(height: 20),

                  _buildLabel('Weight/silhouette (Kg)'),
                  const SizedBox(height: 8),
                  _buildTextField('e.g. 70', weightController, isNumber: true),
                  const SizedBox(height: 30),

                  _buildLabel(
                    'Privacy and security settings',
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                  const SizedBox(height: 20),

                  _buildLabel('Who can send you messages?'),
                  const SizedBox(height: 10),
                  _buildToggle(
                    'Only Matches',
                    onlyMatches,
                    (val) => setState(() => onlyMatches = val ?? false),
                  ),
                  const SizedBox(height: 20),

                  _buildLabel('Push notifications'),
                  const SizedBox(height: 10),
                  _buildToggle(
                    'New Interactions',
                    newInteractions,
                    (val) => setState(() => newInteractions = val ?? false),
                  ),
                  const SizedBox(height: 10),
                  _buildToggle(
                    'Likes',
                    likes,
                    (val) => setState(() => likes = val ?? false),
                  ),
                  const SizedBox(height: 10),
                  _buildToggle(
                    'Messages',
                    messages,
                    (val) => setState(() => messages = val ?? false),
                  ),
                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () {
                        showProfileSuccessToast(context); // show toast

                        // Navigate back 3 screens after 4 seconds
                        Future.delayed(const Duration(milliseconds: 4000), () {
                          int count = 0;
                          Navigator.of(context).popUntil((route) {
                            return count++ == 3;
                          });
                        });
                      },

                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1D97D4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                      ),

                      child: const Text(
                        'Update',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white,
                          height: 1,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
