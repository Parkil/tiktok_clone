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
  static const routeName = "/signup";

  const SignUpScreen({super.key});

  void _onLoginTap(BuildContext context) async {
    // go 는 push 와 다르게 기존 stack 을 무시 하고 바로 해당 widget 으로 이동 한다 (web 의 history.replace 와 비슷)
    context.push(LoginScreen.routeName);
    // final result = await Navigator.of(context).pushNamed(LoginScreen.routeName);
    // debugPrint("$result");
    // final aaa = await Navigator.of(context)
    //     .push(MaterialPageRoute(builder: (context) => const LoginScreen()));
    //
    // debugPrint(aaa);
  }

  Widget pageBuilder(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return const UserNameScreen();
  }

  void _onUserNameTap(BuildContext context) {
    context.push(UserNameScreen.routeName);
    // context.push("/users/test?show=likes111");
    // context.go(UserNameScreen.routeName);
    /*
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(seconds: 1),
        reverseTransitionDuration: const Duration(seconds: 1),
        pageBuilder: pageBuilder,
        transitionsBuilder: _transitionsBuilder,
      ),
    );*/
    // Navigator.of(context)
    //     .push(MaterialPageRoute(builder: (context) => const UserNameScreen()));
  }

  Widget _transitionsBuilder(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    final offset = Tween(begin: const Offset(0, -1), end: Offset.zero).animate(animation);
    return SlideTransition(
      position: offset,
      child: FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
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
                    S.of(context).signUpTitle(
                          "TikTok",
                          DateTime.now(),
                        ),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: Sizes.size24,
                          fontWeight: FontWeight.bold,
                        ), // main.dart 에서 style 을 설정 하고 이를 가져 오는 방식 copyWith - 기존 style 에 특정 속성만 추가 하는 경우
                  ),
                  Gaps.v20,
                  Opacity(
                    opacity: 0.7,
                    child: Text(
                      S.of(context).signUpSubTitle(2),
                      style: const TextStyle(
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
                      S.of(context).subLogin("male"),
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
