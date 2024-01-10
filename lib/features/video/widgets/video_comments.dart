import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class VideoComments extends StatefulWidget {
  const VideoComments({super.key});

  @override
  State<VideoComments> createState() => _VideoCommentsState();
}

class _VideoCommentsState extends State<VideoComments> {
  void _onClosePressed() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.7, // 휴대폰 화면의 70%
      clipBehavior: Clip.hardEdge,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(Sizes.size14)),
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          backgroundColor: Colors.grey.shade50,
          automaticallyImplyLeading: false,
          // app bar 에 표시 되는 이전 버튼 표시 안함
          title: const Text("22796 Comments"),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: _onClosePressed,
                icon: const FaIcon(FontAwesomeIcons.xmark))
          ],
        ),
        body: Stack(children: [
          const CommentList(),
          Positioned(
              bottom: 0, width: size.width, child: const CommentInputBar())
        ]),
      ),
    );
  }
}

class CommentList extends StatelessWidget {
  const CommentList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size10, vertical: Sizes.size16),
      itemCount: 10,
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
          const CommentLike(likeCnt: "2.2K"),
        ],
      ),
      separatorBuilder: (context, index) => Gaps.v20,
    );
  }
}

class CommentInputBar extends StatelessWidget {
  const CommentInputBar({
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

class CommentLike extends StatelessWidget {
  final String likeCnt;

  const CommentLike({
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
