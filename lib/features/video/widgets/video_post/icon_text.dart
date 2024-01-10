import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class IconText extends StatelessWidget {
  final IconData iconData;
  final String subText;

  const IconText({super.key, required this.iconData, required this.subText});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      FaIcon(
        iconData,
        color: Colors.white,
        size: Sizes.size36,
      ),
      Gaps.v5,
      Text(
        subText,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ]);
  }
}
