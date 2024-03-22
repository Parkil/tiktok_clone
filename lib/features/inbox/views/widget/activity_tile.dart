import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/config/theme/text_theme.dart';
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

  @override
  Widget build(BuildContext context) {
    Color fontColor = switchColor(
      condition: isDarkMode(context),
      matchedColor: Colors.grey.shade400,
      altColor: Colors.black,
    );

    return ListTile(
      leading: icon,
      title: RichText(
        text: TextSpan(
          // text: "Account Updates:",
          text: activityType,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(color: fontColor),
          children: [
            // children 에서는 상위의 style 을 상속 받는다
            TextSpan(
              text: ' $content',
              style: TextStyle(fontFamily: fontFamily(), fontWeight: FontWeight.w200),
            ),
            TextSpan(
              text: ' $time',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(color: fontColor, fontWeight: FontWeight.w200),
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
