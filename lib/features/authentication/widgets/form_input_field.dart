import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class FormInputField extends StatelessWidget {
  final bool? obscureText;
  final int maxLength;
  final String hintText;
  final String? Function(String?) validate;
  final Function(String?) onSaved;

  const FormInputField({
    super.key,
    required this.maxLength,
    required this.hintText,
    required this.validate,
    required this.onSaved,
    this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText ?? false,
      maxLength: maxLength,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          fontSize: Sizes.size14,
        ),
      ),
      validator: validate,
      onSaved: onSaved,
    );
  }
}
