import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';

class NavTab extends StatelessWidget {
  final IconData selectedIcon;
  final IconData nonSelectedIcon;
  final String text;
  final bool isSelected;
  final Function onTab;

  const NavTab({super.key, required this.nonSelectedIcon, required this.text, required this.isSelected, required this.onTab, required this.selectedIcon});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onTab(),
        child: Container(
          color: Colors.black,
          child: AnimatedOpacity(
            opacity: isSelected ? 1 : 0.6,
            duration: const Duration(milliseconds: 300),
            child: Column(
              children: [
                FaIcon(isSelected ? selectedIcon : nonSelectedIcon, color:Colors.white),
                Gaps.v5,
                Text(text, style: const TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
