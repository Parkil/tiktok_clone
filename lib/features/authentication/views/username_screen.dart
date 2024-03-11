import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/features/authentication/view_models/signup_vm.dart';
import 'package:tiktok_clone/features/authentication/views/email_screen.dart';
import 'package:tiktok_clone/features/authentication/views/widgets/form_button.dart';
import 'package:tiktok_clone/features/authentication/views/widgets/input_field.dart';

class UserNameScreen extends ConsumerStatefulWidget {
  static const routeUrl = "/username";
  static const routeName = "username";

  const UserNameScreen({super.key});

  @override
  UserNameScreenState createState() => UserNameScreenState();
}

class UserNameScreenState extends ConsumerState<UserNameScreen> {
  final TextEditingController _userNameController = TextEditingController();
  String _username = "";

  @override
  void initState() {
    super.initState();

    _userNameController.addListener(() {
      setState(() {
        _username = _userNameController.text;
      });
    });
  }

  // controller 제거 controller 를 제거 하지 않으면 메모리 관련 문제가 발생할 수 있다
  @override
  void dispose() {
    _userNameController.dispose();
    super.dispose();
  }

  //StatefulWidget 내부 에서는 context 를 받지 않아도 사용이 가능
  void _onNextTab() {
    if (_username.isNotEmpty) {
      ref.read(signUpStateProvider.notifier).state = {"username" : _username};

      context.pushNamed(
        EmailScreen.routeName,
        extra: EmailScreenArgs(username: _username),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Sign Up"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.size36),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Gaps.v40,
          Text(
            "Create username",
            style: textTheme.titleMedium,
          ),
          Gaps.v8,
          Text(
            "You can always change this later",
            style: textTheme.titleSmall,
          ),
          Gaps.v16,
          InputField(textEditingController: _userNameController, hintText: "Username"),
          Gaps.v20,
          FormButton(disabled: _username.isEmpty, onTap: _onNextTab),
        ]),
      ),
    );
  }
}

class EmailScreenArgs {
  final String username;

  EmailScreenArgs({required this.username});
}
