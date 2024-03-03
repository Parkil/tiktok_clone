import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/util/utils.dart';

class GridBottomArea extends StatelessWidget {
  const GridBottomArea({super.key});

  @override
  Widget build(BuildContext context) {
    Color textColor = switchColor(
      condition: isDarkMode(context),
      matchedColor: Colors.grey.shade300,
      altColor: Colors.grey.shade600,
    );
    
    /*
      DefaultTextStyle 을 설정 하면 하위 text 에서는 DefaultTextStyle 의 font style 을 이어 받는다 
     */
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.bodySmall!.copyWith(color: textColor),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 12,
            backgroundImage: NetworkImage(
                "https://upload.wikimedia.org/wikipedia/commons/thumb/4/47/PNG_transparency_demonstration_1.png/280px-PNG_transparency_demonstration_1.png"),
          ),
          Gaps.h4,
          const Expanded(
            child: Text(
              "My avatar is very long text",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Gaps.h4,
          FaIcon(
            FontAwesomeIcons.heart,
            size: Sizes.size16,
            color: Colors.grey.shade600,
          ),
          Gaps.h2,
          const Text(
            "2.5M",
          ),
        ],
      ),
    );
  }
}
