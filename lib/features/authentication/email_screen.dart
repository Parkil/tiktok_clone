import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/password_screen.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_button.dart';
import 'package:tiktok_clone/util/validation.dart';

class EmailScreen extends StatefulWidget {
  const EmailScreen({super.key});

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {

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
    if(_email.isEmpty || isEmailValid(_email) != null) {
      return;
    }

    Navigator.push(context, MaterialPageRoute(builder: (context) => const PasswordScreen()));
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
            const Text("What is your email",
                style: TextStyle(
                    fontSize: Sizes.size24, fontWeight: FontWeight.w700)),
            Gaps.v16,
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
              onEditingComplete: _onSubmit,
              decoration: InputDecoration(
                hintText: "Email",
                errorText: isEmailValid(_email),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400)),
              ),
              cursorColor: Theme.of(context).primaryColor,
            ),
            Gaps.v20,
            FormButton(disabled: _email.isEmpty || isEmailValid(_email) != null, onTap: _onSubmit),
          ]),
        ),
      ),
    );
  }
}


