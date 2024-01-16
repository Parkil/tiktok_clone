import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/inbox/widget/activity_tile.dart';
import 'package:tiktok_clone/features/inbox/widget/blank_icon.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All activity"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Gaps.v12,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size20),
            child: Text(
              "New",
              style: TextStyle(
                fontSize: Sizes.size14,
                color: Colors.grey.shade500,
              ),
            ),
          ),
          Gaps.v12,
          Dismissible(
            key: const Key("x"),
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
              activityType: 'Account Updates:',
              content: 'Upload longer videos',
              time: '1h',
            ),
          )
        ],
      ),
    );
  }
}
