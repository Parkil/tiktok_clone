import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/inbox/activity_screen.dart';
import 'package:tiktok_clone/features/inbox/chats_screen.dart';
import 'package:tiktok_clone/features/inbox/widget/filled_icon.dart';

import 'widget/inbox_tile.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

  void _onDmPressed(BuildContext context) {
    context.pushNamed(ChatsScreen.routeName);
  }

  void _onActivityTap(BuildContext context) {
    context.pushNamed(ActivityScreen.routeName);
  }
  
  /*
     사용자 정의 padding 을 정하면 휴대폰 크기에 따라서 잘못 보일 우려가 있으나,
     Flutter 기본 widget 의 padding 은 크기에 상관 없이 어느 정도는 맞는거 같다
   */
  Divider divide() {
    return Divider(
      thickness: 1,
      indent: 83,
      endIndent: 0,
      color: Colors.grey.shade200,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        shadowColor: Colors.grey,
        title: const Text("InBox"),
        centerTitle: true,
        actions: [
          IconButton(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            icon: const FaIcon(FontAwesomeIcons.paperPlane),
            onPressed: () => _onDmPressed(context),
          ),
        ],
      ),
      body: Column(
        children: [
          ListTile(
            onTap: () => _onActivityTap(context),
            title: const Text(
              "Activity",
              style: TextStyle(
                  fontWeight: FontWeight.w600, fontSize: Sizes.size16),
            ),
            trailing: const FaIcon(
              FontAwesomeIcons.chevronRight,
              size: Sizes.size14,
              color: Colors.black,
            ),
          ),
          Container(
            height: Sizes.size1,
            color: Colors.grey.shade200,
          ),
          Gaps.v10,
          Container(
            alignment: Alignment.centerLeft,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: Sizes.size16),
              child: Text(
                "Messages",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: Sizes.size16,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                InBoxTile(
                  icon: FilledIcon(
                    icon: FontAwesomeIcons.users,
                    backgroundColor: Colors.blue.shade500,
                    iconColor: Colors.white,
                  ),
                  title: 'New Followers',
                  content: 'Messages from followers will appear here',
                ),
                divide(),
                InBoxTile(
                  icon: FilledIcon(
                    icon: FontAwesomeIcons.phoneVolume,
                    backgroundColor: Colors.green.shade400,
                    iconColor: Colors.white,
                  ),
                  title: 'Contacts',
                  content: 'Find your contacts',
                ),
                divide(),
                InBoxTile(
                  icon: FilledIcon(
                    icon: FontAwesomeIcons.box,
                    backgroundColor: Colors.teal.shade400,
                    iconColor: Colors.white,
                  ),
                  title: 'System Notifications',
                  content: 'TikTok: System Notification',
                ),
                divide(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
