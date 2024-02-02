import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/util/utils.dart';

class ActivityTile extends StatelessWidget {
  final Function? onTap;
  final Widget? icon;
  final String activityType;
  final String content;
  final String time;

  const ActivityTile({
    super.key,
    this.onTap,
    required this.icon,
    required this.activityType,
    required this.content,
    required this.time,
  });

  /*
    tiktok 에서는 title 시작점 부터 구분 라인이 그어 지는데 이렇게 하려면 ListTile 로는 안되고 다른
   */
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      // leading: null,
      title: RichText(
        text: TextSpan(
          // text: "Account Updates:",
          text: activityType,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: isDarkMode(context) ? Colors.grey.shade400 : Colors.black,
            fontSize: Sizes.size16,
          ),
          children: [
            // children 에서는 상위의 style 을 상속 받는다
            TextSpan(
              text: ' $content',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: isDarkMode(context) ? Colors.grey.shade400 : Colors.black,
              ),
            ),
            TextSpan(
              text: ' $time',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: isDarkMode(context) ? Colors.grey.shade400 : Colors.black,
              ),
            ),
          ],
        ),
      ),
      trailing: const FaIcon(
        FontAwesomeIcons.chevronRight,
        size: Sizes.size16,
      ),
    );
  }
}
