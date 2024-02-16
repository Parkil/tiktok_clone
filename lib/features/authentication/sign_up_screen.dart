import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/username_screen.dart';
import 'package:tiktok_clone/features/authentication/widgets/auth_button.dart';

import '../../generated/l10n.dart';
import 'login_screen.dart';

class SignUpScreen extends StatelessWidget {
  static const routeUrl = "/";
  static const routeName = "signup";

  const SignUpScreen({super.key});

  void _onLoginTap(BuildContext context) async {
    // go 는 push 와 다르게 기존 stack 을 무시 하고 바로 해당 widget 으로 이동 한다 (web 의 history.replace 와 비슷)
    context.push(LoginScreen.routeName);
  }

  Widget pageBuilder(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return const UserNameScreen();
  }

  void _onUserNameTap(BuildContext context) {
    context.pushNamed("username_screen");
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
                    S.of(context).signUpTitle("TikTok"),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Gaps.v20,
                  Opacity(
                    opacity: 0.7,
                    child: Text(
                      S.of(context).signUpSubTitle(2),
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Gaps.v40,
                  if (orientation == Orientation.portrait) ...[
                    AuthButton(
                      icon: const FaIcon(
                        FontAwesomeIcons.user,
                      ),
                      text: S.of(context).singUpEmailTitle,
                      onTap: _onUserNameTap,
                    ),
                    Gaps.v16,
                    AuthButton(
                      icon: const FaIcon(
                        FontAwesomeIcons.apple,
                      ),
                      text: S.of(context).signUpAppleTitle,
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
                            text: S.of(context).singUpEmailTitle,
                            onTap: _onUserNameTap,
                          ),
                        ),
                        Gaps.h16,
                        Expanded(
                          child: AuthButton(
                            icon: const FaIcon(
                              FontAwesomeIcons.apple,
                            ),
                            text: S.of(context).signUpAppleTitle,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
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
                      S.of(context).subLogin("male"),
                      style: Theme.of(context).textTheme.labelSmall,
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
