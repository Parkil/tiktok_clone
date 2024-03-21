import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/features/video/views/widgets/video_post/icon_text.dart';

class ShareIcon extends StatelessWidget {
  const ShareIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return const IconText(
      iconData: FontAwesomeIcons.share,
      subText: "Share",
    );
  }
}
