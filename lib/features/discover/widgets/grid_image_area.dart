import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class GridImageArea extends StatelessWidget {
  // 가로 길이 / 세로 길이
  final double imageRatio = 9 / 16;

  const GridImageArea({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      /*
      밑에서 설정한 borderRadius 가 image 에 가려 지는 현상을 방지 하기 위해서 clipBehavior 를 설정
     */
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.size4),
      ),
      child: AspectRatio(
        aspectRatio: imageRatio,
        child: FadeInImage.assetNetwork(
          fit: BoxFit.cover,
          placeholder: 'assets/images/image_0009.png',
          // image 가 로딩 되기 전에 표시할 이미지
          image:
              'https://images.unsplash.com/photo-1704739308671-96dd994617d8?q=80&w=1588&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        ),
      ),
    );
  }
}
