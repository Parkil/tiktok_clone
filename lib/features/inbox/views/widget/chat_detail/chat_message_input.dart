import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/inbox/view_models/message_vm.dart';
import 'package:tiktok_clone/util/utils.dart';

class ChatMessageInput extends ConsumerStatefulWidget {
  const ChatMessageInput({super.key});

  @override
  ChatMessageInputState createState() => ChatMessageInputState();
}

class ChatMessageInputState extends ConsumerState<ChatMessageInput> {

  final TextEditingController _textEditingController = TextEditingController();

  InputDecoration _textFieldDecoration(bool darkMode) {
    Color hintColor = switchColor(
        condition: darkMode,
        matchedColor: Colors.grey.shade600,
        altColor: Colors.grey.shade800);

    return InputDecoration(
      hintText: "Send a message...",
      hintStyle: TextStyle(
        fontSize: Sizes.size14,
        color: hintColor,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Sizes.size12),
        borderSide: BorderSide.none,
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: Sizes.size12,
        vertical: Sizes.size10,
      ),
      suffixIcon: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(FontAwesomeIcons.faceLaugh, color: Colors.grey.shade900),
        ],
      ),
    );
  }

  void _sendMessage() {
    String inputMessage = _textEditingController.text;

    if (inputMessage == '') {
      return;
    }

    ref.read(messageAsyncProvider.notifier).sendMessage(inputMessage);
    _textEditingController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    bool darkMode = isDarkMode(context);
    final isLoading  = ref.watch(messageAsyncProvider).isLoading;

    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _textEditingController,
            decoration: _textFieldDecoration(darkMode),
          ),
        ),
        Gaps.h20,
        Container(
          width: Sizes.size40,
          decoration: BoxDecoration(
            color: switchColor(
              condition: darkMode,
              matchedColor: Colors.grey.shade700,
              altColor: Colors.grey.shade300,
            ),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: IconButton(
              color: Colors.white,
              onPressed: isLoading ? null : _sendMessage,
              icon: FaIcon(isLoading ? FontAwesomeIcons.solidHourglass : FontAwesomeIcons.solidPaperPlane),
            ),
          ),
        )
      ],
    );
  }
}
