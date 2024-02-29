import 'package:flutter/material.dart';
import 'package:tiktok_clone/features/video/views/widgets/video_post/video_post.dart';

class VideoTimelineScreen extends StatefulWidget {
  const VideoTimelineScreen({super.key});

  @override
  State<VideoTimelineScreen> createState() => _VideoTimelineScreenState();
}

class _VideoTimelineScreenState extends State<VideoTimelineScreen> {

  final PageController _pageController = PageController();

  final _scrollDuration = const Duration(milliseconds: 500);
  final _curve = Curves.linear;

  final int _itemCount = 10;

  void _onPageChanged(int page)  {
    _pageController.animateToPage(page, duration: _scrollDuration, curve: _curve);

    // if(page == _itemCount -1) {
    //   setState(() {
    //     _itemCount += 4;
    //   });
    // }
  }

  void _onVideoFinished() {
    return;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() {
    return Future.delayed(const Duration(seconds: 5));
  }

  @override
  Widget build(BuildContext context) {
    // builder 를 사용 하면 on demand (= 현재 보여 지는 widget) 만 생성 한다
    return RefreshIndicator( // refresh 아이콘 을 표시
      onRefresh: _onRefresh,
      displacement: 50,
      edgeOffset: 10,
      color: Theme.of(context).primaryColor,
      child: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        onPageChanged: _onPageChanged,
        itemCount: _itemCount,
        itemBuilder: (context, index) => VideoPost(onVideoFinished: _onVideoFinished, videoUrl: "assets/videos/video_$index.mp4", index: index)
      ),
    );
  }
}
