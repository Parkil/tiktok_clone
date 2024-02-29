import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/features/main_navigation/view_models/tab_name_vn.dart';
import 'package:tiktok_clone/util/utils.dart';

class NavTab extends StatelessWidget {
  final IconData selectedIcon;
  final IconData nonSelectedIcon;
  final String tabText;
  final String tabName;
  final Function onTab;

  const NavTab({
    super.key,
    required this.selectedIcon,
    required this.nonSelectedIcon,
    required this.tabText,
    required this.tabName,
    required this.onTab,
  });

  @override
  Widget build(BuildContext context) {
   String currentTabName = tabNameVn.value;
   bool isSelected = currentTabName == tabName;

    return Expanded(
      child: GestureDetector(
        onTap: () => onTab(),
        child: Container(
          color: switchColor(
            condition: checkNavTabDarkMode(context, currentTabName),
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
                    condition: checkNavTabDarkMode(context, currentTabName),
                    matchedColor: Colors.white,
                    altColor: Colors.black,
                  ),
                ),
                Gaps.v5,
                Text(
                  tabText,
                  style: TextStyle(
                    color: switchColor(
                      condition: checkNavTabDarkMode(context, currentTabName),
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
