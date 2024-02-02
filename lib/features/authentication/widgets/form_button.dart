import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/util/utils.dart';

class FormButton extends StatelessWidget {
  final Function? onTap;
  final String? buttonText;

  const FormButton({super.key, required this.disabled, this.onTap, this.buttonText});

  final bool disabled;

  @override
  Widget build(BuildContext context) {
    String buttonText = this.buttonText ?? "Next";

    return GestureDetector(
      onTap: () => onTap!(),
      child: FractionallySizedBox(
        widthFactor: 1,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(vertical: Sizes.size16),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(Sizes.size5), color: disabled ? (isDarkMode(context) ? Colors.grey.shade800 : Colors.grey.shade300) : Theme.of(context).primaryColor),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 300),
            style: TextStyle(color: disabled ? Colors.grey.shade400 :Colors.white, fontWeight: FontWeight.w600),
            child: Text(
              buttonText,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
