import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/inbox/models/message_model.dart';
import 'package:tiktok_clone/features/inbox/repos/message_repo.dart';
import 'package:tiktok_clone/features/user/view_models/user_profile_vm.dart';

class MessageVm extends AsyncNotifier<void> {
  late final MessageRepo _messageRepo;

  @override
  FutureOr<void> build() {
    _messageRepo = ref.read(messageRepo);
  }

  Future<void> sendMessage(String text) async {
    String uid = ref.read(userProfileProvider).value!.uid;

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return _messageRepo.sendMessage(MessageModel(
        text: text,
        uid: uid,
        createdAt: DateTime.now().millisecondsSinceEpoch,
      ));
    });
  }
}

final messageAsyncProvider =
    AsyncNotifierProvider<MessageVm, void>(() => MessageVm());

// autoDispose 를 설정 하지 않으면 해당 event 가 계속 살아 있게 된다
final chatProvider = StreamProvider.autoDispose<List<MessageModel>>((ref) {
  final fireStore = FirebaseFirestore.instance;
  return fireStore
      .collection("chat_rooms")
      .doc("6FkbMDTzdNvB33WzNcKk")
      .collection("texts")
      .orderBy("createdAt")
      .snapshots()
      .map(
        (event) => event.docs
            .map(
              (doc) => MessageModel.fromJson(
                doc.data(),
              ),
            )
            .toList(),
      );
});
