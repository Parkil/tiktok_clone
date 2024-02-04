import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/username_screen.dart';
import 'package:tiktok_clone/features/authentication/widgets/auth_button.dart';

import 'login_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  void _onLoginTap(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  void _onUserNameTap(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const UserNameScreen()));
  }

  /*
    SafeArea - 상단 (시간, 배터리, 네트워크 상태) / 하단 ( 이전, 다음, 홈) 을 제외한 영역을 생성
   */
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size40,
              ),
              child: Column(
                children: [
                  Gaps.v52,
                  Text(
                    "Sign up for TikTok",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: Sizes.size24, fontWeight: FontWeight.bold), // main.dart 에서 style 을 설정 하고 이를 가져 오는 방식 copyWith - 기존 style 에 특정 속성만 추가 하는 경우
                  ),
                  Gaps.v20,
                  const Opacity(
                    opacity: 0.7,
                    child: Text(
                      "Create a profile, follow other accounts make your own videos, and more.",
                      style: TextStyle(
                        fontSize: Sizes.size16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Gaps.v40,
                  if (orientation == Orientation.portrait) ...[
                    AuthButton(
                      icon: const FaIcon(
                        FontAwesomeIcons.user,
                      ),
                      text: "Use email and password",
                      onTap: _onUserNameTap,
                    ),
                    Gaps.v16,
                    const AuthButton(
                      icon: FaIcon(
                        FontAwesomeIcons.apple,
                      ),
                      text: "Continue with Apple",
                    ),
                  ],
                  if (orientation == Orientation.landscape)
                    Row(
                      children: [
                        Expanded(
                          child: AuthButton(
                            icon: const FaIcon(
                              FontAwesomeIcons.user,
                            ),
                            text: "Use email and password",
                            onTap: _onUserNameTap,
                          ),
                        ),
                        Gaps.h16,
                        const Expanded(
                          child: AuthButton(
                            icon: FaIcon(
                              FontAwesomeIcons.apple,
                            ),
                            text: "Continue with Apple",
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            // color: isDarkMode(context) ? null : Colors.grey.shade50, // null 을 대입 하면 해당 property 를 적용 하지 않겠 다는 의미
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: Sizes.size16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account?",
                  ),
                  Gaps.h5,
                  GestureDetector(
                    onTap: () => _onLoginTap(context),
                    child: Text(
                      "Log in",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary,
                        // color: Color(0xFFE9435A),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
