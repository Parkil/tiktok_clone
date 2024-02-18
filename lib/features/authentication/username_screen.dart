import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/features/authentication/email_screen.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_button.dart';

class UserNameScreen extends StatefulWidget {
  static const routeUrl = "/username";
  static const routeName = "username";

  const UserNameScreen({super.key});

  @override
  State<UserNameScreen> createState() => _UserNameScreenState();
}

class _UserNameScreenState extends State<UserNameScreen> {
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
          TextField(
            controller: _userNameController,
            decoration: InputDecoration(
              hintText: "Username",
              hintStyle: const TextStyle(
                fontSize: Sizes.size14,
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey.shade400,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey.shade400,
                ),
              ),
            ),
          ),
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
