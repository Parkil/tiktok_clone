import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/view_models/signup_vm.dart';
import 'package:tiktok_clone/features/authentication/views/password_screen.dart';
import 'package:tiktok_clone/features/authentication/views/widgets/form_button.dart';
import 'package:tiktok_clone/features/authentication/views/widgets/input_field.dart';
import 'package:tiktok_clone/util/validation.dart';

class EmailScreen extends ConsumerStatefulWidget {
  static const routeUrl = "/email";
  static const routeName = "email";

  final String userName;

  const EmailScreen({
    super.key,
    required this.userName,
  });

  @override
  EmailScreenState createState() => EmailScreenState();
}

class EmailScreenState extends ConsumerState<EmailScreen> {
  final TextEditingController _emailController = TextEditingController();
  String _email = "";

  @override
  void initState() {
    super.initState();

    _emailController.addListener(() {
      setState(() {
        _email = _emailController.text;
      });
    });
  }

  // controller 제거 controller 를 제거 하지 않으면 메모리 관련 문제가 발생할 수 있다
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  void _onSubmit() {
    if (_email.isEmpty || isEmailValid(_email) != null) {
      return;
    }

    ref.read(signUpStateProvider.notifier).state = {"email" : _email};
    context.pushNamed(PasswordScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    // pushNamed 에서 넘긴 데이터 를 가져 오는 방법
    // final args = ModalRoute.of(context)!.settings.arguments as EmailScreenArgs;

    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Sign Up"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size36,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v40,
              Text(
                "What is your email? ${widget.userName}",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Gaps.v16,
              InputField(
                textEditingController: _emailController,
                hintText: "Email",
                keyBoardType: TextInputType.emailAddress,
                autocorrect: false,
                errorText: isEmailValid(_email),
                onEditingComplete: _onSubmit,
              ),
              Gaps.v20,
              FormButton(
                disabled: _email.isEmpty || isEmailValid(_email) != null,
                onTap: _onSubmit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
