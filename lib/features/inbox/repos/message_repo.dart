import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/inbox/models/message_model.dart';

class MessageRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendMessage(MessageModel model) async {
    await _firestore
        .collection("chat_rooms")
        .doc("6FkbMDTzdNvB33WzNcKk")
        .collection("texts")
        .add(model.toJson());
  }
}

final messageRepo = Provider((ref) => MessageRepo());
