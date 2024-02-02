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
          color: isDarkMode(context) || selectedIndex == 0 ? Colors.black : Colors.white,
          // todo 이런 식으로 조건을 걸어서 하나씩 바꾸지 않고 Theme 를 지정 해서 한번에 바꾸는 방법은 없는지 확인해 볼것
          child: AnimatedOpacity(
            opacity: isSelected ? 1 : 0.6,
            duration: const Duration(milliseconds: 300),
            child: Column(
              children: [
                FaIcon(
                  isSelected ? selectedIcon : nonSelectedIcon,
                  color:  isDarkMode(context) || selectedIndex == 0 ? Colors.white : Colors.black,
                ),
                Gaps.v5,
                Text(
                  text,
                  style: TextStyle(
                    color:  isDarkMode(context) || selectedIndex == 0 ? Colors.white : Colors.black,
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
