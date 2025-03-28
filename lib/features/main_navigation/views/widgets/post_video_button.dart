import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/main_navigation/view_models/tab_name_vn.dart';
import 'package:tiktok_clone/util/utils.dart';

class PostVideoButton extends StatelessWidget {
  final Function? onTap;

  const PostVideoButton({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    String currentTabName = tabNameVn.value;

    return GestureDetector(
      onTap: () => onTap!(),
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: Sizes.size12,
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              right: 20,
              child: Container(
                height: 30,
                width: 25,
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.size8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xff61D4F0),
                  borderRadius: BorderRadius.circular(
                    Sizes.size8,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 20,
              child: Container(
                height: 30,
                width: 25,
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.size8,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(
                    Sizes.size8,
                  ),
                ),
              ),
            ),
            Container(
              height: 30,
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size12,
              ),
              decoration: BoxDecoration(
                color: switchColor(
                  condition: checkNavTabDarkMode(context, currentTabName),
                  matchedColor: Colors.white,
                  altColor: Colors.black,
                ),
                borderRadius: BorderRadius.circular(
                  Sizes.size6,
                ),
              ),
              child: Center(
                child: FaIcon(
                  FontAwesomeIcons.plus,
                  color: switchColor(
                    condition: checkNavTabDarkMode(context, currentTabName),
                    matchedColor: Colors.black,
                    altColor: Colors.white,
                  ),
                  size: Sizes.size16 + Sizes.size2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
