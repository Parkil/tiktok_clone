import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/util/utils.dart';

class CommentInputArea extends StatefulWidget {
  final Function registerCommentCallback;

  const CommentInputArea({
    super.key,
    required this.registerCommentCallback,
  });

  @override
  State<CommentInputArea> createState() => _CommentInputAreaState();
}

class _CommentInputAreaState extends State<CommentInputArea> {
  bool _isTextFieldFocus = false;

  void _onFocusChange(bool isFocus) {
    setState(() {
      _isTextFieldFocus = isFocus;
    });
  }

  void _onRegisterComment() {
    // 실제로 Comment 를 입력 하는 로직 추가 필요
    widget.registerCommentCallback();
  }

  InputDecoration _textFieldDecoration() {
    return InputDecoration(
      hintText: "Write a comment...",
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Sizes.size12),
        borderSide: BorderSide.none,
      ),
      filled: true,
      fillColor: isDarkMode(context) ? Colors.grey.shade700 : Colors.grey.shade200,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: Sizes.size12,
        vertical: Sizes.size10,
      ),
      suffixIcon: Padding(
        padding: const EdgeInsets.only(
          right: Sizes.size14,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(FontAwesomeIcons.at, color: Colors.grey.shade900),
            Gaps.h14,
            FaIcon(FontAwesomeIcons.gift, color: Colors.grey.shade900),
            Gaps.h14,
            FaIcon(FontAwesomeIcons.faceSmile, color: Colors.grey.shade900),
            Gaps.h14,
            if (_isTextFieldFocus)
              GestureDetector(
                onTap: _onRegisterComment,
                child: FaIcon(
                  FontAwesomeIcons.circleArrowUp,
                  color: Colors.grey.shade900,
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //bottomAppBar 는 Android 에서 자체적 으로 padding 이 적용 된다
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.size10,
        vertical: Sizes.size8,
      ),
      // surfaceTintColor: Colors.white,
      color: isDarkMode(context) ? Colors.grey.shade900 : Colors.white,
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
            // FocusScope : child widget 의 focus 여부를 판단
            child: FocusScope(
              onFocusChange: _onFocusChange,
              child: TextField(
                // TextField 에서 보여 지는 최소 입력 행
                minLines: 1,
                // 사용자 의 입력에 따라서 확장 되는 TextField 의 최대 행 (최대 5 라인만 입력할 수 있다는 의미가 아님)
                maxLines: 5,
                // 키보드 의 우측 하단 버튼의 동작을 설정
                textInputAction: TextInputAction.newline,
                cursorColor: Theme.of(context).primaryColor,
                decoration: _textFieldDecoration(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
