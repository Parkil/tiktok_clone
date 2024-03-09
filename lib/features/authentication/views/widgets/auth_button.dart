import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final FaIcon icon;
  final void Function()? onTap;

  const AuthButton(
      {super.key, required this.text, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: FractionallySizedBox(
        // 부모 widget 의 공간 만큼 사용
        widthFactor: 1, // 1 (부모 공간의 100%), 0.5 (부모 공간의 50%)
        child: Container(
          padding: const EdgeInsets.all(Sizes.size14),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.shade300,
              width: Sizes.size1,
            ),
          ),
          // Row - widget 을 가로 배치, Column - widget 을 세로 배치, Stack - widget 을 쌓을수 있게 배치
          // Stack 을 쓰는 이유 - Row 를 이용 하여 icon, text 를 배치 한다고 가정 하였을 경우 [icon][text] 로 배치가 되기 때문에
          // text 를 전체 영역의 중앙 으로 두고자 하면 icon 을 뺀 나머지 영역의 중앙 으로 배치가 되기 때문에 정렬이 완전히 맞지 않을
          // 수 있다
          child: Stack(alignment: Alignment.center, children: [
            Align(alignment: Alignment.centerLeft, child: icon),
            Text(
              text,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ]),
        ),
      ),
    );
  }
}
