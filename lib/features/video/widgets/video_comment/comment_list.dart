import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/video/widgets/video_comment/comment_like_icon_text.dart';

class CommentList extends StatelessWidget {
  const CommentList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size10, vertical: Sizes.size16),
      itemCount: 11,
      itemBuilder: (context, index) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 18,
            child: Text("$index"),
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
          const CommentLikeIconText(likeCnt: "2.2K"),
        ],
      ),
      separatorBuilder: (context, index) => Gaps.v20,
    );
  }
}
