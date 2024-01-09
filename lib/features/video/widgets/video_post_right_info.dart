import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/features/video/widgets/video_button.dart';

class VideoPostRightInfo extends StatelessWidget {
  const VideoPostRightInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Positioned(
        bottom: 20,
        right: 10,
        child: Column(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              foregroundImage: NetworkImage("https://upload.wikimedia.org/wikipedia/commons/thumb/4/47/PNG_transparency_demonstration_1.png/280px-PNG_transparency_demonstration_1.png"),
              child: Text("사용자"),
            ),
            Gaps.v24,
            VideoButton(iconData: FontAwesomeIcons.solidHeart, subText: "2.9M"),
            Gaps.v24,
            VideoButton(iconData: FontAwesomeIcons.solidComment, subText: "3.3K"),
            Gaps.v24,
            VideoButton(iconData: FontAwesomeIcons.share, subText: "Share"),
          ],
      )
    );
  }
}
