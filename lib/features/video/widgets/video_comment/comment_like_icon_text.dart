import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class CommentLikeIconText extends StatelessWidget {
  final String likeCnt;

  const CommentLikeIconText({
    super.key,
    required this.likeCnt,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FaIcon(
          FontAwesomeIcons.heart,
          size: Sizes.size20,
          color: Colors.grey.shade500,
        ),
        Gaps.v2,
        Text(
          likeCnt,
          style: TextStyle(color: Colors.grey.shade500),
        ),
      ],
    );
  }
}
