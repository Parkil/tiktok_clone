import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/inbox/views/widget/chat_detail/chat_detail_header.dart';
import 'package:tiktok_clone/features/inbox/views/widget/chat_detail/chat_message_box.dart';
import 'package:tiktok_clone/features/inbox/views/widget/chat_detail/chat_message_input.dart';
import 'package:tiktok_clone/util/utils.dart';

class ChatDetailScreen extends StatefulWidget {
  static const routeUrl = ":id";
  static const routeName = "chat_detail";

  final String id;

  const ChatDetailScreen({
    super.key,
    required this.id,
  });

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  @override
  Widget build(BuildContext context) {
    Color color = switchColor(
      condition: isDarkMode(context),
      matchedColor: Colors.black,
      altColor: Colors.grey.shade100,
    );

    return Scaffold(
      backgroundColor: color,
      appBar: AppBar(
        backgroundColor: color,
        title: ChatDetailHeader(id: widget.id),
      ),
      body: Stack(
        children: [
          ListView.separated(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size16,
              vertical: Sizes.size20,
            ),
            itemBuilder: (context, index) {
              final isMine = index % 2 == 0;
              return ChatMessageBox(isMyMessage: isMine);
            },
            separatorBuilder: (context, index) => Gaps.v10,
            itemCount: 10,
          ),
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: BottomAppBar(
              color: color,
              surfaceTintColor: color,
              child: const ChatMessageInput(),
            ),
          ),
        ],
      ),
    );
  }
}
