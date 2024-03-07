import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/view_models/login_vm.dart';
import 'package:tiktok_clone/features/authentication/views/widgets/form_button.dart';
import 'package:tiktok_clone/features/authentication/views/widgets/form_input_field.dart';
import 'package:tiktok_clone/util/validation.dart';

class LoginFormScreen extends ConsumerStatefulWidget {
  static const routeUrl = "/login_form";
  static const routeName = "login_form";

  const LoginFormScreen({super.key});

  @override
  LoginFormScreenState createState() => LoginFormScreenState();
}

class LoginFormScreenState extends ConsumerState<LoginFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, String> _formDataMap = {};

  void _onSubmitTab() {
    if (_formKey.currentState != null) {
      bool chkResult = _formKey.currentState!.validate();

      if (chkResult) {
        _formKey.currentState!.save();
        ref.read(loginStateAsyncProvider.notifier).login(
            _formDataMap['email']!,
            _formDataMap['password']!,
            context);
        // context.goNamed(InterestsScreen.routeName);
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
              FormInputField(
                maxLength: 40,
                hintText: "Email",
                validate: (val) => isEmailEmpty(val!),
                onSaved: (newVal) => put(
                  key: "email",
                  value: newVal,
                ),
              ),
              // buildTextFormField(),
              Gaps.v16,
              FormInputField(
                obscureText: true,
                maxLength: 20,
                hintText: "Password",
                validate: (val) => isPasswordEmpty(val!),
                onSaved: (newVal) => put(
                  key: "password",
                  value: newVal,
                ),
              ),
              Gaps.v28,
              FormButton(
                disabled: ref.watch(loginStateAsyncProvider).isLoading,
                onTap: _onSubmitTab,
                buttonText: "Log in",
              ),
            ]),
          ),
        ));
  }
}
