import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/inbox/view_models/message_vm.dart';
import 'package:tiktok_clone/features/inbox/views/widget/chat_detail/chat_detail_header.dart';
import 'package:tiktok_clone/features/inbox/views/widget/chat_detail/chat_message_box.dart';
import 'package:tiktok_clone/features/inbox/views/widget/chat_detail/chat_message_input.dart';
import 'package:tiktok_clone/util/utils.dart';

class ChatDetailScreen extends ConsumerStatefulWidget {
  static const routeUrl = ":id";
  static const routeName = "chat_detail";

  final String id;

  const ChatDetailScreen({
    super.key,
    required this.id,
  });

  @override
  ChatDetailScreenState createState() => ChatDetailScreenState();
}

class ChatDetailScreenState extends ConsumerState<ChatDetailScreen> {
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
          ref.watch(chatProvider).when(
                error: (error, stackTrace) => Center(
                  child: Text(error.toString()),
                ),
                loading: () => const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
                data: (data) {
                  return ListView.separated(
                    reverse: false,
                    padding: const EdgeInsets.symmetric(
                      horizontal: Sizes.size16,
                      vertical: Sizes.size20,
                    ),
                    itemBuilder: (context, index) {
                      return ChatMessageBox(
                        model: data[index],
                      );
                    },
                    separatorBuilder: (context, index) => Gaps.v10,
                    itemCount: data.length,
                  );
                },
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
