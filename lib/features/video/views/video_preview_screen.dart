import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:tiktok_clone/features/video/view_models/video_timeline_vm.dart';
import 'package:video_player/video_player.dart';

class VideoPreviewScreen extends ConsumerStatefulWidget {
  static const routeUrl = "/video_preview";
  static const routeName = "video_preview";

  final XFile videoFile;
  final bool isPicked;

  const VideoPreviewScreen({
    super.key,
    required this.videoFile,
    required this.isPicked,
  });

  @override
  VideoPreviewScreenState createState() => VideoPreviewScreenState();
}

class VideoPreviewScreenState extends ConsumerState<VideoPreviewScreen> {
  late final VideoPlayerController _videoPlayerController;
  bool _isSaveVideo = false;

  @override
  void initState() {
    super.initState();
    initVideo();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  Future<void> initVideo() async {
    _videoPlayerController =
        VideoPlayerController.file(File(widget.videoFile.path));
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    await _videoPlayerController.play();

    setState(() {});
  }

  Future<void> _saveToGallery() async {
    if (_isSaveVideo) {
      return;
    }

    final result = await ImageGallerySaver.saveFile(widget.videoFile.path,
        name: "My Video");
    debugPrint(result);

    _isSaveVideo = true;
    setState(() {});
  }

  void _onUploadPressed() {
    ref.read(videoTimeLineProvider.notifier).uploadVideo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Preview video",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: ref.watch(videoTimeLineProvider).isLoading ? () {} : _onUploadPressed,
            icon: ref.watch(videoTimeLineProvider).isLoading
                ? const CircularProgressIndicator()
                : const FaIcon(
                    FontAwesomeIcons.cloudArrowUp,
                  ),
          ),
          if (!widget.isPicked)
            IconButton(
              onPressed: _saveToGallery,
              icon: FaIcon(_isSaveVideo
                  ? FontAwesomeIcons.check
                  : FontAwesomeIcons.download),
            ),
        ],
      ),
      body: _videoPlayerController.value.isInitialized
          ? VideoPlayer(_videoPlayerController)
          : null,
    );
  }
}
