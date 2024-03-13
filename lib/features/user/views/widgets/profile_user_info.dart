import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class ProfileUserInfo extends StatelessWidget {
  final String name;

  const ProfileUserInfo({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "@$name",
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: Sizes.size18,
          ),
        ),
        Gaps.h8,
        FaIcon(
          FontAwesomeIcons.solidCircleCheck,
          size: Sizes.size16,
          color: Colors.green.shade300,
        ),
      ],
    );
  }
}
