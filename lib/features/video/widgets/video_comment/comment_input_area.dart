import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class CommentInputArea extends StatelessWidget {
  const CommentInputArea({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //bottomAppBar 는 Android 에서 자체적 으로 padding 이 적용 된다
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.size10,
        vertical: Sizes.size8,
      ),
      // surfaceTintColor: Colors.white,
      color: Colors.white,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: Colors.grey.shade500,
            foregroundColor: Colors.white,
            child: const Text("User"),
          ),
          Gaps.h10,
          Expanded(
            child: TextField(
              cursorColor: Theme.of(context).primaryColor,
              decoration: InputDecoration(
                hintText: "Write a comment...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Sizes.size12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey.shade200,
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: Sizes.size12, vertical: Sizes.size10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
