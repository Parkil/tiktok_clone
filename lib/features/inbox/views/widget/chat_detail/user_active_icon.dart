import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class UserActiveIcon extends StatelessWidget {
  const UserActiveIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Sizes.size14,
      height: Sizes.size14,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Container(
          width: Sizes.size10,
          height: Sizes.size10,
          decoration: BoxDecoration(
            color: Colors.green.shade300,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
