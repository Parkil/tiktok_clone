import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/authentication/views/sign_up_screen.dart';
import 'package:tiktok_clone/features/video/view_models/playback_config_vm.dart';

class SettingsScreen extends ConsumerWidget {
  static const routeUrl = "/settings";
  static const routeName = "settings";

  const SettingsScreen({super.key});

  void _dateRangePicker(BuildContext context) {
    showDateRangePicker(
      context: context,
      firstDate: DateTime.now().subtract(
        const Duration(days: 90),
      ),
      lastDate: DateTime.now(),
      builder: (context, child) {
        // Theme 를 해당 widget에서만 수동으로 변경하는 방법
        return Theme(
          data: ThemeData(
            appBarTheme: const AppBarTheme(
              foregroundColor: Colors.white,
              backgroundColor: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    ).then((value) => debugPrint("range : $value"));
  }

  void _timePicker(BuildContext context) {
    showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 1, minute: 0),
    ).then((value) => debugPrint("time : $value"));
  }

  void _datePicker(BuildContext context) {
    showDatePicker(
      context: context,
      firstDate: DateTime.now().subtract(const Duration(days: 90)),
      lastDate: DateTime.now(),
    ).then((value) => debugPrint("date : $value"));
  }

  /*
    실제 제품 또는 prototype 을 개발 하고자 할때 에는 IOS / Android 전부 대응이
    될 수 있도록 adaptive 를 사용 해야 할거 같은데.. 문제는 단일 widget 은 이렇게 대응이
    가능 하다고 쳐도 Scaffold 나 기타 Container 성 widget 은 어떻게 설정을 해야 하나?

    현재 까지 지식을 기반 으로 판단해 보면 현재 OS 정보를 가져 와서 분기를 태우는 식으로 widget 을 작성 해야 할거 같은데....

    그리고 거의 모든 widget 을 공통 으로 만들어 놓고 개발 해야 나중에 잡음이 없을듯
   */
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Settings"),
        ),
        body: ListView(
          children: [
            Switch.adaptive(
              value: false,
              onChanged: (value) {},
            ),
            CupertinoSwitch(
              value: false,
              onChanged: (value) {},
            ),
            GestureDetector(
              onTap: () {},
              child: ListTile(
                title: const Text("Notifications"),
                trailing: CupertinoSwitch(
                  value: false,
                  onChanged: (value) {},
                ),
              ),
            ),
            //AnimatedBuilder + Notifier 를 결합 하면 해당 부분만 rendering 된다
            SwitchListTile.adaptive(
              value: ref.watch(playBackConfigProvider).muted,
              onChanged: (value) {
                ref.read(playBackConfigProvider.notifier).setMuted(value);
              },
              title: const Text("Auto Mute Videos"),
              subtitle: const Text("Videos will be muted by default"),
              activeColor: Colors.black,
            ),
            SwitchListTile.adaptive(
              value: ref.watch(playBackConfigProvider).autoplay,
              onChanged: (value) {
                ref.read(playBackConfigProvider.notifier).setAutoPlay(value);
              },
              title: const Text("Auto Play"),
              subtitle: const Text("Videos will play automatically"),
              activeColor: Colors.black,
            ),
            SwitchListTile(
              value: false,
              onChanged: (value) {},
              title: const Text("Notifications"),
              activeColor: Colors.black,
            ),
            ListTile(
              title: const Text(
                "Log out (ios / bottom)",
              ),
              textColor: Colors.red,
              onTap: () => showCupertinoModalPopup(
                context: context,
                builder: (context) {
                  return CupertinoActionSheet(
                    title: const Text("Are you Sure?"),
                    message: const Text("message"),
                    actions: [
                      CupertinoActionSheetAction(
                        onPressed: () => Navigator.of(context).pop(),
                        isDefaultAction: true,
                        child: const Text("No"),
                      ),
                      CupertinoActionSheetAction(
                        isDestructiveAction: true,
                        child: const Text("Yes"),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  );
                },
              ),
            ),
            ListTile(
              title: const Text(
                "Log out (ios)",
              ),
              textColor: Colors.red,
              onTap: () => showCupertinoDialog(
                context: context,
                builder: (context) {
                  return CupertinoAlertDialog(
                    title: const Text("Are you Sure?"),
                    content: const Text("Please don`t leave"),
                    actions: [
                      CupertinoDialogAction(
                        child: const Text("No"),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      CupertinoDialogAction(
                        isDestructiveAction: true,
                        child: const Text("Yes"),
                        onPressed: () {
                          ref.read(authRepoProvider).signOut();
                          context.go(SignUpScreen.routeUrl);
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
            ListTile(
              title: const Text(
                "Log out (android)",
              ),
              textColor: Colors.red,
              onTap: () => showDialog(
                barrierColor: Colors.transparent,
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return AlertDialog(
                    surfaceTintColor: Colors.white,
                    title: const Text("Are you Sure?"),
                    content: const Text("Please don`t leave"),
                    actions: [
                      IconButton(
                        icon: const FaIcon(FontAwesomeIcons.odnoklassniki),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      IconButton(
                        icon: const FaIcon(FontAwesomeIcons.node),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  );
                },
              ),
            ),
            CheckboxListTile(
              value: false,
              onChanged: (value) {},
              title: const Text("Notifications"),
              activeColor: Colors.black,
            ),
            ListTile(
              title: const Text("What is your birthday"),
              onTap: () {
                // 2개다 await 를 쓰면 warning 이 나타 난다 buildContext 와 같이 쓸때 동시성 문제가 발생 하는듯
                _datePicker(context);
                _timePicker(context);
                _dateRangePicker(context);
              },
            ),
            const AboutListTile(
              applicationName: "aaabbb",
              applicationVersion: "1.0",
              applicationLegalese: "All rights reversed. Please don`t copy me.",
            ),
          ],
        ));
  }
}
