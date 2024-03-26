import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/inbox/views/chats_screen.dart';
import 'package:tiktok_clone/features/video/views/video_recording_screen.dart';

class NotificationProvider extends FamilyAsyncNotifier<void, BuildContext> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseMessaging _fireMessage = FirebaseMessaging.instance;

  @override
  FutureOr<void> build(BuildContext arg) async {
    final token = await _fireMessage.getToken();

    if (token != null) {
      await updateToken(token);
    }

    await initListener(arg);
    _fireMessage.onTokenRefresh.listen((newToken) async {
      await updateToken(newToken);
    });
  }

  Future<void> updateToken(String token) async {
    final user = ref.read(authRepoProvider).user!;
    await _firestore.collection("users").doc(user.uid).update({"token": token});
  }

  Future<void> initListener(BuildContext context) async {
    final permission = await _fireMessage.requestPermission();

    if (permission.authorizationStatus == AuthorizationStatus.denied) {
      return;
    }

    // foreground (앱이 현재 화면에 떠 있을때) 이벤트
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("I just got a message and I`m in the foreground");
      print(event.notification?.title);
    });

    // background (앱이 가동 되어 있으나 현재 화면에 떠 있지 않을때) 이벤트
    // - background 상태 에서 알림이 오고 알림을 클릭 했을 떄 event 실행
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage event) {
      context.pushNamed(ChatsScreen.routeName);
    });
    // W/FLTFireMsgService(18185): A background message could not be handled in Dart as no onBackgroundMessage handler has been registered.
    // 위 에러가 뜨는 것으로 보아 onBackgroundMessage 가 선언 되지 않은 상태 에서는 background message 를 처리해서는 아되는거 같음
    //FirebaseMessaging.onBackgroundMessage((message) => null)
    // todo context 를 async 에서 사용 하려면 provider / riverpod 로 분리한 다음 사용 하도록 변경을 해야 할듯

    // terminated - 앱이 종료 된 상태 에서 알림 이 올 경우 처리
    // 정확 하게 말하면 앱이 종료 되고 나서 다시 가동 될때 종료된 동안 온 알림을 받아 오는 구조
    // 이것도 알림을 클릭 해야 이벤트 가 발생함
    final noti = await _fireMessage.getInitialMessage();

    if (noti != null) {
      context.pushNamed(VideoRecordingScreen.routeName);
    }
  }
}

final notiProvider = AsyncNotifierProvider.family<NotificationProvider, void, BuildContext>(
    () => NotificationProvider());
