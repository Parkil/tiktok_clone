import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class BlankIcon extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color circleColor;

  const BlankIcon({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.circleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Sizes.size52,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(
          color: circleColor,
          width: Sizes.size1,
        ),
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
