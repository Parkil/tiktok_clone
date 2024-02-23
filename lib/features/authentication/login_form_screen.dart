import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_button.dart';
import 'package:tiktok_clone/features/onboarding/interests_screen.dart';

import '../../util/validation.dart';

class LoginFormScreen extends StatefulWidget {
  static const routeUrl = "/login_form";
  static const routeName = "login_form";

  const LoginFormScreen({super.key});

  @override
  State<LoginFormScreen> createState() => _LoginFormScreenState();
}

class _LoginFormScreenState extends State<LoginFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, String> _formDataMap = {};

  void _onSubmitTab() {
    if (_formKey.currentState != null) {
      bool chkResult = _formKey.currentState!.validate();

      if (chkResult) {
        _formKey.currentState!.save();
        context.goNamed(InterestsScreen.routeName);
      }
    }
  }

  void put({required String key, String? value}) {
    if (value != null) {
      _formDataMap[key] = value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Log in"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size36),
          child: Form(
            key: _formKey,
            child: Column(children: [
              Gaps.v28,
              TextFormField(
                maxLength: 40,
                decoration: const InputDecoration(hintText: "Email"),
                validator: (val) => isEmailEmpty(val!),
                onSaved: (newVal) => put(key: "email", value: newVal)),
              Gaps.v16,
              TextFormField(
                obscureText: true,
                maxLength: 20,
                decoration: const InputDecoration(hintText: "Password"),
                validator: (val) => isPasswordEmpty(val!),
                onSaved: (newVal) => put(key: "password", value: newVal)),
              Gaps.v28,
              FormButton(
                  disabled: false, onTap: _onSubmitTab, buttonText: "Log in")
            ]),
          ),
        ));
  }
}
