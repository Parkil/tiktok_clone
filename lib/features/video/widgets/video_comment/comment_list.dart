import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/video/widgets/video_comment/comment_like_icon_text.dart';
import 'package:tiktok_clone/generated/l10n.dart';
import 'package:tiktok_clone/util/utils.dart';

class CommentList extends StatelessWidget {
  const CommentList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size10, vertical: Sizes.size16),
        itemCount: 10,
        itemBuilder: (context, index) => Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: isDarkMode(context) ? Colors.grey.shade700: null,
              child: Text("${index+1}"),
            ),
            Gaps.h10,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Writer",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade500,
                      fontSize: Sizes.size14,
                    ),
                  ),
                  Gaps.v3,
                  const Text(
                    "Reply Contents, Reply Contents, Reply Contents, Reply Contents, Reply Contents",
                    style: TextStyle(),
                  ),
                ],
              ),
            ),
            Gaps.v10,
            CommentLikeIconText(likeCnt: S.of(context).likeCount(1500)),
          ],
        ),
        separatorBuilder: (context, index) => Gaps.v20,
      ),
    );
  }
}
