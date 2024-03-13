import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class ProfileDescription extends StatelessWidget {
  const ProfileDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Sizes.size32,
      ),
      child: Text(
        "사용자와 관련된 설명, ㄹㅇ나ㅣ;ㅓㅣㅏㅇ넘라ㅣㅇㄴ머리ㅏㅇㅁ너라ㅣㅇㄴ무리ㅏㅇㄴ무라ㅓㅇ누라ㅓㅇㄴ",
        textAlign: TextAlign.center,
      ),
    );
  }
}
