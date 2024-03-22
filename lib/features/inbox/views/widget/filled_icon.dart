import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class FilledIcon extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;

  const FilledIcon({
    super.key, required this.icon, required this.backgroundColor, required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Sizes.size52,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
      ),
      child: Center(
        child: FaIcon(
          icon,
          color: iconColor,
        ),
      ),
    );
  }
}
