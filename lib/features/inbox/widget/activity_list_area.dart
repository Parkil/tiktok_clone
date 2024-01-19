import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/inbox/widget/dismissible_activity_tile.dart';

class ActivityListArea extends StatelessWidget {
  final String areaTitle;
  final List<String> data;
  final Function onDismissed;

  const ActivityListArea({
    super.key,
    required this.areaTitle,
    required this.data,
    required this.onDismissed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gaps.v12,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size20),
          child: Text(
            "New",
            style: TextStyle(
              fontSize: Sizes.size14,
              color: Colors.grey.shade500,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Gaps.v12,
        Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) => DismissibleActivityTile(
              id: data[index],
              onDismissed: onDismissed,
              activityType: 'Account Updates:',
              content: 'Upload longer videos',
              time: data[index],
            ),
            separatorBuilder: (context, index) => Gaps.v16,
            itemCount: data.length,
          ),
        ),
      ],
    );
  }
}
