import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/views/birthday_screen.dart';
import 'package:tiktok_clone/features/authentication/views/widgets/check_element.dart';
import 'package:tiktok_clone/features/authentication/views/widgets/form_button.dart';
import 'package:tiktok_clone/features/authentication/views/widgets/input_field.dart';
import 'package:tiktok_clone/util/validation.dart';

class PasswordScreen extends StatefulWidget {

  static const routeUrl = "/password";
  static const routeName = "password";

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

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  void _onSubmit() {
    if (!isPasswordValid(_password)) {
      return;
    }

    context.pushNamed(BirthDayScreen.routeName);
  }

  void _onClearTab() {
    _passwordController.clear();
  }

  void _toggleObscureText() {
    _obscureText = !_obscureText;
    setState(() {}); // setState 에 값이 지정 되지 않아도 re-rendering 이 수행됨
  }

  Widget _suffix() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: _onClearTab,
          child: FaIcon(
            FontAwesomeIcons.solidCircleXmark,
            color: Colors.grey.shade500,
            size: Sizes.size20,
          ),
        ),
        Gaps.h20,
        GestureDetector(
          onTap: _toggleObscureText,
          child: FaIcon(
            _obscureText ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash,
            color: Colors.grey.shade500,
            size: Sizes.size20,
          ),
        ),
      ],
    );
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v40,
              Text(
                "Create Password",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Gaps.v16,
              InputField(
                textEditingController: _passwordController,
                hintText: "Make it strong",
                autocorrect: false,
                onEditingComplete: _onSubmit,
                obscureText: _obscureText,
                maxLength: 20,
                suffix: _suffix(),
              ),
              Gaps.v10,
              const Text(
                "Your password must have",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Gaps.v10,
              Column(children: [
                CheckElement(
                  completeCon:
                      getPasswordChkMap(_password)["lengthChk"] == true,
                  text: "8 to 20 characters",
                ),
                Gaps.v5,
                CheckElement(
                  completeCon:
                      getPasswordChkMap(_password)["charTypeChk"] == true,
                  text: "both alphabet and numbers",
                ),
                Gaps.v5,
                CheckElement(
                  completeCon:
                      getPasswordChkMap(_password)["specialCharChk"] == true,
                  text: "least one special character",
                ),
              ]),
              Gaps.v20,
              FormButton(
                disabled: !isPasswordValid(_password),
                onTap: _onSubmit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
