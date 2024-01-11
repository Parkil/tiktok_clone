import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/video/widgets/video_comment/comment_input_area.dart';
import 'package:tiktok_clone/features/video/widgets/video_comment/comment_list.dart';

class VideoComments extends StatefulWidget {
  const VideoComments({super.key});

  @override
  State<VideoComments> createState() => _VideoCommentsState();
}

class _VideoCommentsState extends State<VideoComments> {

  void _onClosePressed() {
    Navigator.of(context).pop();
  }

  void _closeCommentKeyboard() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.7, // 휴대폰 화면의 70%
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.size14),
      ),
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
        body: GestureDetector(
          onTap: _closeCommentKeyboard,
          child: Column(
            children: [
              const Flexible(
                child: CommentList(),
              ),
              CommentInputArea(
                registerCommentCallback: _closeCommentKeyboard,
              )
            ],
          ),
        ),
      ),
    );
  }
}
