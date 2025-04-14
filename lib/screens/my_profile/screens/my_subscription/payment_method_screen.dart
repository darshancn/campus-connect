import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../widgets/payment_method_toast_modal.dart';
import '../../widgets/payment_sucess_modal.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cardController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _cardController.addListener(_onFieldChanged);
    _expiryController.addListener(_onFieldChanged);
    _cvvController.addListener(_onFieldChanged);
  }

  void _onFieldChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    _cardController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  bool get _isFormFilled =>
      _cardController.text.trim().isNotEmpty &&
      _expiryController.text.trim().isNotEmpty &&
      _cvvController.text.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildCustomAppBar(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel('Card Number'),
                      _buildCardNumberField(),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(child: _buildExpiryField()),
                          const SizedBox(width: 10),
                          Expanded(child: _buildCVVField()),
                        ],
                      ),
                      const Spacer(),
                      _buildPayButton(context),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildCustomAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(70),
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF1D97D4),
        elevation: 1,
        centerTitle: true,
        flexibleSpace: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
                const Text(
                  'Credit / Debit Card',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
          fontSize: 16,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildCardNumberField() {
    return Container(
      height: 55,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1D97D4),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF1D97D4)),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: _cardController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(19),
                CardNumberFormatter(),
              ],
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Enter',
                hintStyle: TextStyle(color: Colors.white),
                border: InputBorder.none,
              ),
              validator:
                  (value) =>
                      value == null || value.isEmpty
                          ? 'Enter card number'
                          : null,
            ),
          ),
          const Icon(Icons.credit_card, color: Colors.white, size: 24),
          const SizedBox(width: 8),
          const Icon(Icons.payment, color: Colors.white, size: 24),
        ],
      ),
    );
  }

  Widget _buildExpiryField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('Expiry'),
        Container(
          height: 55,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF1D97D4),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFF1D97D4)),
          ),
          child: TextFormField(
            controller: _expiryController,
            keyboardType: TextInputType.datetime,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              hintText: 'MM-YY',
              hintStyle: TextStyle(color: Colors.white),
              border: InputBorder.none,
            ),
            validator:
                (value) =>
                    value == null || value.isEmpty ? 'Enter expiry' : null,
          ),
        ),
      ],
    );
  }

  Widget _buildCVVField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('CVV'),
        Container(
          height: 55,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF1D97D4),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFF6B7280)),
          ),
          child: TextFormField(
            controller: _cvvController,
            keyboardType: TextInputType.number,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              hintText: 'Enter',
              hintStyle: TextStyle(color: Colors.white),
              border: InputBorder.none,
            ),
            validator:
                (value) => value == null || value.isEmpty ? 'Enter CVV' : null,
          ),
        ),
      ],
    );
  }

  Widget _buildPayButton(BuildContext context) {
    return GestureDetector(
      onTap:
          _isFormFilled
              ? () {
                if (_formKey.currentState!.validate()) {
                  // Show toast modal after short delay
                  Future.delayed(const Duration(milliseconds: 0), () {
                    showPaymentToastModal(
                      context,
                    ); // handles its own auto-close

                    // Show success modal after 2400ms more (total 2900ms from tap)
                    Future.delayed(const Duration(milliseconds: 4000), () {
                      showPaymentSuccessModal(
                        context,
                      ); // also handles its own auto-close
                    });
                  });
                }
              }
              : null,
      child: Container(
        width: double.infinity,
        height: 52,
        margin: const EdgeInsets.only(top: 30, bottom: 40),
        decoration: BoxDecoration(
          color:
              _isFormFilled ? const Color(0xFFE8B903) : const Color(0xFF797979),
          borderRadius: BorderRadius.circular(7),
        ),
        alignment: Alignment.center,
        child: const Text(
          'Pay €10',
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), '');
    final buffer = StringBuffer();
    for (int i = 0; i < digitsOnly.length; i++) {
      if (i != 0 && i % 4 == 0) buffer.write(' ');
      buffer.write(digitsOnly[i]);
    }
    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}
