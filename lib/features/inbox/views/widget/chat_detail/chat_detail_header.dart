import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/inbox/views/widget/chat_detail/user_active_icon.dart';

class ChatDetailHeader extends StatelessWidget {
  final String id;

  const ChatDetailHeader({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      horizontalTitleGap: Sizes.size8,
      leading: const Stack(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            foregroundImage: NetworkImage(
                "https://upload.wikimedia.org/wikipedia/commons/thumb/4/47/PNG_transparency_demonstration_1.png/280px-PNG_transparency_demonstration_1.png"),
            child: Text("사"),
          ),
          Positioned(bottom: 0, width: 74, child: UserActiveIcon())
        ],
      ),
      title: Text(
        "사용자($id)",
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: const Text(
        "Active now",
        style: TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FaIcon(
            FontAwesomeIcons.flag,
            color: Colors.black,
            size: Sizes.size20,
          ),
          Gaps.h32,
          FaIcon(
            FontAwesomeIcons.ellipsis,
            color: Colors.black,
            size: Sizes.size20,
          ),
        ],
      ),
    );
  }
}
