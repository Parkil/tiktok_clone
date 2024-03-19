import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/video/view_models/video_timeline_vm.dart';
import 'package:tiktok_clone/features/video/views/widgets/video_post/video_post.dart';

class VideoTimelineScreen extends ConsumerStatefulWidget {
  const VideoTimelineScreen({super.key});

  @override
  VideoTimelineScreenState createState() => VideoTimelineScreenState();
}

class VideoTimelineScreenState extends ConsumerState<VideoTimelineScreen> {
  final PageController _pageController = PageController();

  int _itemCount = 0;

  final _scrollDuration = const Duration(milliseconds: 500);
  final _curve = Curves.linear;

  void _onPageChanged(int page) {
    _pageController.animateToPage(page,
        duration: _scrollDuration, curve: _curve);

    if (page == _itemCount - 1) {
      ref.read(videoTimeLineProvider.notifier).fetchNextPage();
    }
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
    return ref.read(videoTimeLineProvider.notifier).refresh();
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(videoTimeLineProvider).when(
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: (error, trace) => Center(
            child: Text(
              "Could not load videos: $error",
              style: const TextStyle(
                color: Colors.red,
              ),
            ),
          ),
          // builder 를 사용 하면 on demand (= 현재 보여 지는 widget) 만 생성 한다
          data: (videos) {
            _itemCount = videos.length;
            return RefreshIndicator(
              // refresh 아이콘 을 표시
              onRefresh: _onRefresh,
              displacement: 50,
              edgeOffset: 10,
              color: Theme.of(context).primaryColor,
              child: PageView.builder(
                controller: _pageController,
                scrollDirection: Axis.vertical,
                onPageChanged: _onPageChanged,
                itemCount: videos.length,
                itemBuilder: (context, index) {
                  return VideoPost(
                    onVideoFinished: _onVideoFinished,
                    index: index,
                    videoData: videos[index],
                  );
                },
              ),
            );
          },
        );
  }
}
