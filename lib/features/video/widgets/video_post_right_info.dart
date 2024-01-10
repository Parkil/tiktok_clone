import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/features/video/widgets/video_button.dart';

class VideoPostRightInfo extends StatelessWidget {
  final Function commentFunction;

  const VideoPostRightInfo({
    super.key, required this.commentFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 20,
        right: 10,
        child: Column(
          children: [
            const CircleAvatar(
              radius: 25,
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              foregroundImage: NetworkImage("https://upload.wikimedia.org/wikipedia/commons/thumb/4/47/PNG_transparency_demonstration_1.png/280px-PNG_transparency_demonstration_1.png"),
              child: Text("사용자"),
            ),
            Gaps.v24,
            const VideoButton(iconData: FontAwesomeIcons.solidHeart, subText: "2.9M"),
            Gaps.v24,
            GestureDetector(
                onTap: () => commentFunction(context),
                child: const VideoButton(
                    iconData: FontAwesomeIcons.solidComment, subText: "3.3K")),
            Gaps.v24,
            const VideoButton(iconData: FontAwesomeIcons.share, subText: "Share"),
          ],
      )
    );
  }
}
