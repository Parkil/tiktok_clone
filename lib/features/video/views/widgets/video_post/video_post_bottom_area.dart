import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class VideoPostBottomArea extends StatelessWidget {
  final String loginUser;
  final String description;
  final String tag;

  const VideoPostBottomArea(
      {super.key,
      required this.loginUser,
      required this.description,
      required this.tag});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 30,
        left: 10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              loginUser,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: Sizes.size20,
              ),
            ),
            Gaps.v16,
            Text(
              description,
              style: const TextStyle(
                color: Colors.white,
                fontSize: Sizes.size16,
              ),
            ),
            Gaps.v16,
            SizedBox(
              width: 300,
              child: ReadMoreText(
                tag,
                trimLines: 1,
                colorClickableText: Colors.pink,
                trimMode: TrimMode.Line,
                trimCollapsedText: 'See more',
                trimExpandedText: ' See less',
                style: const TextStyle(
                    color: Colors.white, fontSize: Sizes.size16),
                moreStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                lessStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ));
  }
}
