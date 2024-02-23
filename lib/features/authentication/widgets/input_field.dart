import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class InputField extends StatefulWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final String? errorText;
  final TextInputType? keyBoardType;
  final bool? autocorrect;
  final bool? obscureText;
  final bool? enabled;
  final Function? onEditingComplete;
  final int? maxLength;
  final Widget? suffix;

  const InputField({
    super.key,
    required this.textEditingController,
    required this.hintText,
    this.keyBoardType,
    this.autocorrect,
    this.onEditingComplete,
    this.errorText,
    this.obscureText,
    this.maxLength,
    this.suffix,
    this.enabled,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    bool autocorrect = widget.autocorrect ?? false;
    bool obscureText = widget.obscureText ?? false;
    bool enabled = widget.enabled ?? true;

    return TextField(
      controller: widget.textEditingController,
      autocorrect: autocorrect,
      obscureText: obscureText,
      enabled: enabled,
      onEditingComplete: () => widget.onEditingComplete!(),
      keyboardType: widget.keyBoardType,
      maxLength: widget.maxLength,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          fontSize: Sizes.size14,
        ),
        errorText: widget.errorText,
        suffix: widget.suffix,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.shade400,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.shade400,
          ),
        ),
      ),
    );
  }
}
