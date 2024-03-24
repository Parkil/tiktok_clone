import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/inbox/models/message_model.dart';
import 'package:tiktok_clone/features/user/view_models/user_profile_vm.dart';

class ChatMessageBox extends ConsumerWidget {
  final MessageModel model;

  const ChatMessageBox({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String myUid = ref.read(userProfileProvider).value!.uid;
    bool isMyMessage = model.uid == myUid;

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
          child: Text(
            model.text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: Sizes.size16,
            ),
          ),
        ),
      ],
    );
  }
}
