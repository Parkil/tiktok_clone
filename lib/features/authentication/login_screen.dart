import 'package:flutter/material.dart';

import '../../constants/gaps.dart';
import '../../constants/sizes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  void _onSignUpTap(BuildContext context) {
    /*
      push : 현재 화면 위에 신규 위젯을 새로 쌓음 -> 뒤로 가기를 이용 하여 이전 화면 으로 이동 하는 것이 가능
       -> 그러면 push 개수가 많아 지면 성능에 영향을 미치나? : flutter performance 로 확인해 보니 메모리 사용 율이 올라 가는 것을 확인
      pop : 현재 화면을 제거
       -> pop 사용시 메모리 에 영향을 주지 않음

      이 논리 라면 webapp 도 메모리 문제가 발생 하지 않을까?
       
      앱 설계시 이전 페이지 를 봐야 하는지 아니면 단발성 페이지(이전 페이지 볼 필요 없음) 인지를 확인 해서 페이지 이동 수단을 선정할 필요가 있다
      -> 앱 흐름 설계가 필요 하다
     */
    Navigator.of(context).pop();
  }

  /*
    SafeArea - 상단 (시간, 배터리, 네트 워크 상태) / 하단 (이전, 다음, 홈) 과 겹치지 않는 영역을 생성
   */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Sizes.size40),
          child: Column(
            children: [
              Gaps.v80,
              Text("Log in for TikTok",
                  style: TextStyle(
                      fontSize: Sizes.size24, fontWeight: FontWeight.w700)),
              Gaps.v20,
              Text(
                  "Manage your account, check notifications, comment on videos, and more",
                  style: TextStyle(fontSize: Sizes.size16, color: Colors.black54),
                  textAlign: TextAlign.center),
              Gaps.v40,
              // AuthButton(icon: FaIcon(FontAwesomeIcons.user), text: "Use email and password"),
              Gaps.v16,
              // AuthButton(icon: FaIcon(FontAwesomeIcons.apple), text: "Continue with Apple"),
            ],
          ),
        )
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey.shade50,
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: Sizes.size16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Don`t have an account?"),
              Gaps.h5,
              GestureDetector(
                onTap: () => _onSignUpTap(context),
                child: Text("Sign up", style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
