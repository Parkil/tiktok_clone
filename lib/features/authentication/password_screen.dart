import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/birthday_screen.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_button.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  String _password = "";
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();

    _passwordController.addListener(() {
      setState(() {
        _password = _passwordController.text;
      });
    });
  }

  // controller 제거 controller 를 제거 하지 않으면 메모리 관련 문제가 발생할 수 있다
  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  bool _isPasswordValid() {
    return _password.isNotEmpty && _password.length > 8;
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  void _onSubmit() {
    if (!_isPasswordValid()) {
      return;
    }

    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const BirthDayScreen()));
  }

  void _onClearTab() {
    _passwordController.clear();
  }

  void _toggleObscureText() {
    _obscureText = !_obscureText;
    setState(() {}); // setState 에 값이 지정 되지 않아도 re-rendering 이 수행됨
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Sign Up"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size36),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Gaps.v40,
            const Text("Password",
                style: TextStyle(
                    fontSize: Sizes.size24, fontWeight: FontWeight.w700)),
            Gaps.v16,
            TextField(
              controller: _passwordController,
              autocorrect: false,
              onEditingComplete: _onSubmit,
              obscureText: _obscureText,
              maxLength: 20,
              decoration: InputDecoration(
                // prefixIcon, suffixIcon : Icon 자체를 넣는 경우
                // prefix, suffix : widget 을 넣는 경우
                // FractionallySizedBox 를 이용 하여 row 의 일부를 표시 하려고 하는 경우 가로 화면 표시시 size 가 생각 했던 것보다 커질수 있다
                suffix: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: _onClearTab,
                      child: FaIcon(FontAwesomeIcons.solidCircleXmark,
                            color: Colors.grey.shade500, size: Sizes.size20)),
                    Gaps.h20,
                    GestureDetector(
                      onTap: _toggleObscureText,
                      child: FaIcon(_obscureText ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash,
                            color: Colors.grey.shade500, size: Sizes.size20)),
                  ],
                ),
                hintText: "Make it strong",
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400)),
              ),
              cursorColor: Theme.of(context).primaryColor,
            ),
            Gaps.v10,
            const Text("Your password must have", style: TextStyle(fontWeight: FontWeight.w600, )),
            Gaps.v10,
            Row(children: [
              FaIcon(FontAwesomeIcons.circleCheck, size: Sizes.size20, color: _isPasswordValid() ? Colors.green : Colors.grey.shade400),
              Gaps.h5,
              const Text("8 to 20 characters"),
            ]),
            Gaps.v20,
            FormButton(
                disabled: !_isPasswordValid(),
                onTap: _onSubmit),
          ]),
        ),
      ),
    );
  }
}
