import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class InBoxTile extends StatelessWidget {
  final Function? onTap;
  final Widget? icon;
  final String title;
  final String content;

  const InBoxTile({
    super.key,
    this.onTap,
    required this.icon,
    required this.title,
    required this.content,
  });

  /*
    tiktok 에서는 title 시작점 부터 구분 라인이 그어 지는데 이렇게 하려면 ListTile 로는 안되고 다른
   */
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => onTap!(),
      leading: icon,
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: Sizes.size16,
        ),
      ),
      subtitle: Text(
        content,
        style: const TextStyle(
          fontSize: Sizes.size14,
        ),
      ),
      trailing: const FaIcon(
        FontAwesomeIcons.chevronRight,
        size: Sizes.size16,
        color: Colors.black,
      ),
    );
  }
}
