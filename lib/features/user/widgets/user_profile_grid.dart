import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class UserProfileGrid extends StatelessWidget {
  const UserProfileGrid({super.key});

  final double imageRatio = 9 / 13;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: imageRatio,
          child: FadeInImage.assetNetwork(
            fit: BoxFit.cover,
            placeholder: 'assets/images/image_0009.png',
            // image 가 로딩 되기 전에 표시할 이미지
            image:
                'https://images.unsplash.com/photo-1704739308671-96dd994617d8?q=80&w=1588&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
          ),
        ),
        const Positioned(
          right: 0,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Sizes.size5, vertical: Sizes.size5),
            child: FaIcon(
              FontAwesomeIcons.image,
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          top: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size5,
              vertical: Sizes.size5,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size1,
                vertical: Sizes.size1,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(
                    Sizes.size4,
                  ),
                ),
              ),
              child: const Text(
                "Pinned",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Sizes.size14,
                ),
              ),
            ),
          ),
        ),
        const Positioned(
          bottom: 0,
          child: Row(
            children: [
              Gaps.h5,
              FaIcon(
                FontAwesomeIcons.play,
                color: Colors.white,
                size: Sizes.size16,
              ),
              Gaps.h5,
              Text(
                "4.1M",
                style: TextStyle(
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
