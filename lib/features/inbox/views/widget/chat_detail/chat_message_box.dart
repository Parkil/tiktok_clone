import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class ChatMessageBox extends StatelessWidget {
  final bool isMyMessage;

  const ChatMessageBox({
    super.key,
    required this.isMyMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment:
          isMyMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(Sizes.size14),
          decoration: BoxDecoration(
            color: isMyMessage ? Colors.blue : Theme.of(context).primaryColor,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(Sizes.size20),
              topRight: const Radius.circular(Sizes.size20),
              bottomLeft:
                  Radius.circular(isMyMessage ? Sizes.size20 : Sizes.size5),
              bottomRight:
                  Radius.circular(isMyMessage ? Sizes.size5 : Sizes.size20),
            ),
          ),
          child: const Text(
            "This is a message",
            style: TextStyle(
              color: Colors.white,
              fontSize: Sizes.size16,
            ),
          ),
        ),
      ],
    );
  }
}
