import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/features/video/views/widgets/video_post/icon_text.dart';
import 'package:tiktok_clone/generated/l10n.dart';

class VideoPostRightArea extends StatelessWidget {
  final Function commentFunction;

  const VideoPostRightArea({
    super.key,
    required this.commentFunction,
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
            foregroundImage: NetworkImage(
                "https://upload.wikimedia.org/wikipedia/commons/thumb/4/47/PNG_transparency_demonstration_1.png/280px-PNG_transparency_demonstration_1.png"),
            child: Text("사용자"),
          ),
          Gaps.v24,
          IconText(
            iconData: FontAwesomeIcons.solidHeart,
            subText: S.of(context).likeCount(1500),
          ),
          Gaps.v24,
          GestureDetector(
            onTap: () => commentFunction(context),
            child: IconText(
              iconData: FontAwesomeIcons.solidComment,
              subText: S.of(context).commentCount(55000),
            ),
          ),
          Gaps.v24,
          const IconText(
            iconData: FontAwesomeIcons.share,
            subText: "Share",
          ),
        ],
      ),
    );
  }
}
