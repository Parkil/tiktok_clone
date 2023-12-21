import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class CheckElement extends StatelessWidget {
  final bool completeCon;
  final String text;

  const CheckElement({super.key, required this.completeCon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      FaIcon(FontAwesomeIcons.circleCheck, size: Sizes.size20, color: completeCon ? Colors.green : Colors.grey.shade400),
      Gaps.h5,
      Text(text),
    ]);
  }
}
