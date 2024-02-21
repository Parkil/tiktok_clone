import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/util/utils.dart';

class NavTab extends StatelessWidget {
  final IconData selectedIcon;
  final IconData nonSelectedIcon;
  final String text;
  final bool isSelected;
  final Function onTab;
  final int selectedIndex;

  const NavTab({
    super.key,
    required this.nonSelectedIcon,
    required this.text,
    required this.isSelected,
    required this.onTab,
    required this.selectedIcon,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onTab(),
        child: Container(
          color: switchColor(
            condition: isNavTabDarkMode(context, selectedIndex),
            matchedColor: Colors.black,
            altColor: Colors.white,
          ),
          child: AnimatedOpacity(
            opacity: isSelected ? 1 : 0.6,
            duration: const Duration(milliseconds: 300),
            child: Column(
              children: [
                FaIcon(
                  isSelected ? selectedIcon : nonSelectedIcon,
                  color: switchColor(
                    condition: isNavTabDarkMode(context, selectedIndex),
                    matchedColor: Colors.white,
                    altColor: Colors.black,
                  ),
                ),
                Gaps.v5,
                Text(
                  text,
                  style: TextStyle(
                    color: switchColor(
                      condition: isNavTabDarkMode(context, selectedIndex),
                      matchedColor: Colors.white,
                      altColor: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
