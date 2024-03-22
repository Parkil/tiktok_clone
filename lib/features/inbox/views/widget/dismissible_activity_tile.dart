import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/inbox/views/widget/activity_tile.dart';
import 'package:tiktok_clone/features/inbox/views/widget/blank_icon.dart';

class DismissibleActivityTile extends StatelessWidget {
  final String id;
  final Function onDismissed;
  final String activityType;
  final String content;
  final String time;

  const DismissibleActivityTile({
    super.key,
    required this.id,
    required this.onDismissed,
    required this.activityType,
    required this.content,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(id),
      onDismissed: (direction) => onDismissed(id),
      background: Container(
        alignment: Alignment.centerLeft,
        color: Colors.green,
        child: const Padding(
          padding: EdgeInsets.only(left: Sizes.size10),
          child: FaIcon(
            FontAwesomeIcons.checkDouble,
            color: Colors.white,
            size: Sizes.size32,
          ),
        ),
      ),
      secondaryBackground: Container(
        alignment: Alignment.centerRight,
        color: Colors.red,
        child: const Padding(
          padding: EdgeInsets.only(right: Sizes.size10),
          child: FaIcon(
            FontAwesomeIcons.trash,
            color: Colors.white,
            size: Sizes.size32,
          ),
        ),
      ),
      child: ActivityTile(
        icon: BlankIcon(
          icon: FontAwesomeIcons.bell,
          iconColor: Colors.black,
          circleColor: Colors.grey.shade400,
        ),
        activityType: activityType,
        content: content,
        // activityType: 'Account Updates:',
        // content: 'Upload longer videos',
        time: time,
      ),
    );
  }
}
