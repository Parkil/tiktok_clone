import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/video/video_preview_screen.dart';

import 'widgets/video_recording/camera_icon.dart';

class VideoRecordingScreen extends StatefulWidget {
  static const routeUrl = "/video_record";
  static const routeName = "video_record";

  const VideoRecordingScreen({super.key});

  @override
  State<VideoRecordingScreen> createState() => _VideoRecordingScreenState();
}

enum CameraZoom { zoomUp, zoomOut }

class _VideoRecordingScreenState extends State<VideoRecordingScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  bool _hasPermission = false;
  bool _isSelfieMode = false;

  late final bool _noCamera = kDebugMode && Platform.isIOS;

  late FlashMode _flashMode;
  late double cameraMinZoomLevel;
  late double cameraMaxZoomLevel;
  late double currentZoomLevel;
  final double _modifier = 0.1;

  late CameraController _cameraController;
  late final AnimationController _buttonAnimationController =
      AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 150),
  );

  late final AnimationController _progressAnimationController =
      AnimationController(
    vsync: this,
    duration: const Duration(seconds: 10),
    lowerBound: 0.0,
    upperBound: 1.0,
  );

  late final Animation<double> _buttonAnimation =
      Tween(begin: 1.0, end: 1.3).animate(_buttonAnimationController);

  @override
  void initState() {
    super.initState();
    initPermissions();
    WidgetsBinding.instance.addObserver(this);
    _progressAnimationController.addListener(() {
      setState(() {});
    });
    _progressAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _stopRecording();
      }
    });
  }

  @override
  void dispose() {
    _cameraController.dispose();
    _buttonAnimationController.dispose();
    _progressAnimationController.dispose();
    super.dispose();
  }

  Future<void> initPermissions() async {
    final cameraStatus = await Permission.camera.request();
    final microPhoneStatus = await Permission.microphone.request();

    final cameraDenied =
        cameraStatus.isDenied || cameraStatus.isPermanentlyDenied;
    final microPhoneDenied =
        microPhoneStatus.isDenied || microPhoneStatus.isPermanentlyDenied;

    if (!cameraDenied && !microPhoneDenied) {
      await initCamera();
      setState(() {
        _hasPermission = true;
      });
    }
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (!_hasPermission) {
      return;
    }

    if (!_cameraController.value.isInitialized) {
      return;
    }

    debugPrint("$state");

    if (state == AppLifecycleState.inactive) {
      // 권한 신청 때도 동일 하게 적용됨
      _cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      await initCamera();
      setState(() {});
    }
  }

  Future<void> initCamera() async {
    final cameras = await availableCameras();

    if (cameras.isEmpty) {
      return;
    }

    _cameraController = CameraController(
      cameras[_isSelfieMode ? 1 : 0],
      ResolutionPreset.ultraHigh,
    );
    await _cameraController.initialize();
    await _cameraController.prepareForVideoRecording();
    _flashMode = _cameraController.value.flashMode;

    cameraMinZoomLevel = await _cameraController.getMinZoomLevel();
    cameraMaxZoomLevel = await _cameraController.getMaxZoomLevel();
    currentZoomLevel = cameraMinZoomLevel;
  }

  Future<void> _toggleSelfieMode() async {
    _isSelfieMode = !_isSelfieMode;
    await initCamera();
    setState(() {});
  }

  Future<void> _setFlashMode(FlashMode newFlashMode) async {
    await _cameraController.setFlashMode(newFlashMode);
    _flashMode = newFlashMode;
    setState(() {});
  }

  Future<void> _startRecording() async {
    debugPrint("start check: ${_cameraController.value.isRecordingVideo}");
    if (_cameraController.value.isRecordingVideo) {
      return;
    }

    await _cameraController.startVideoRecording();

    _buttonAnimationController.forward();
    _progressAnimationController.forward();
    debugPrint("start recording");
  }

  Future<void> _stopRecording() async {
    debugPrint("end check: ${_cameraController.value.isRecordingVideo}");
    if (!_cameraController.value.isRecordingVideo) {
      return;
    }

    _buttonAnimationController.reverse();
    _progressAnimationController.reset();
    debugPrint("end recording");

    final file = await _cameraController.stopVideoRecording();
    debugPrint("file : ${file.name} - ${file.path}");

    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPreviewScreen(
          videoFile: file,
          isPicked: false,
        ),
      ),
    );
  }

  Future<void> _onPickVideoPressed() async {
    final file = await ImagePicker().pickVideo(source: ImageSource.gallery);

    if (file == null) {
      return;
    }

    debugPrint("$file");

    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPreviewScreen(
          videoFile: file,
          isPicked: true,
        ),
      ),
    );
  }

  Future<void> _changeZoom(DragUpdateDetails details) async {
    CameraZoom zoom =
        details.primaryDelta! < 0 ? CameraZoom.zoomUp : CameraZoom.zoomOut;

    if (zoom == CameraZoom.zoomUp) {
      currentZoomLevel += _modifier;
      currentZoomLevel = currentZoomLevel > cameraMaxZoomLevel
          ? cameraMaxZoomLevel
          : currentZoomLevel;
    } else {
      currentZoomLevel -= _modifier;
      currentZoomLevel = currentZoomLevel < cameraMinZoomLevel
          ? cameraMinZoomLevel
          : currentZoomLevel;
    }

    // zoom 기능은 안드로이드 시뮬레이터 에서는 동작하지 않음
    debugPrint("currentZoomLevel: $currentZoomLevel");
    await _cameraController.setZoomLevel(currentZoomLevel);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: !_hasPermission || !_cameraController.value.isInitialized
          ? SizedBox(
              width: MediaQuery.of(context).size.width,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Requesting Permissions",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Sizes.size20,
                    ),
                  ),
                  Gaps.v20,
                  CircularProgressIndicator.adaptive(),
                ],
              ),
            )
          : Stack(
              children: [
                if (!_noCamera && _cameraController.value.isInitialized)
                  CameraPreview(_cameraController),
                const Positioned(
                  top: Sizes.size20,
                  left: Sizes.size6,
                  child: CloseButton(
                    color: Colors.white,
                  ),
                ),
                Positioned(
                  top: Sizes.size20,
                  right: Sizes.size6,
                  child: Column(
                    children: [
                      CameraIcon(
                        isSelected: false,
                        icon: const FaIcon(FontAwesomeIcons.cameraRotate),
                        onPress: _toggleSelfieMode,
                      ),
                      Gaps.v10,
                      CameraIcon(
                        isSelected: _flashMode == FlashMode.off,
                        icon: const Icon(Icons.flash_off_rounded),
                        onPress: () => _setFlashMode(FlashMode.off),
                      ),
                      Gaps.v10,
                      CameraIcon(
                        isSelected: _flashMode == FlashMode.always,
                        icon: const Icon(Icons.flash_on_rounded),
                        onPress: () => _setFlashMode(FlashMode.always),
                      ),
                      Gaps.v10,
                      CameraIcon(
                        isSelected: _flashMode == FlashMode.auto,
                        icon: const Icon(Icons.flash_auto_rounded),
                        onPress: () => _setFlashMode(FlashMode.auto),
                      ),
                      Gaps.v10,
                      CameraIcon(
                        isSelected: _flashMode == FlashMode.torch,
                        icon: const Icon(Icons.flashlight_on_rounded),
                        onPress: () => _setFlashMode(FlashMode.torch),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  width: MediaQuery.of(context)
                      .size
                      .width, // width 를 잡아 주면 width 의 중앙 으로 자동 정렬 된다
                  bottom: Sizes.size40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      GestureDetector(
                        onTapDown: (details) => _startRecording(),
                        onTapUp: (details) => _stopRecording(),
                        onVerticalDragUpdate: _changeZoom,
                        child: ScaleTransition(
                          scale: _buttonAnimation,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                width: Sizes.size80 + Sizes.size14,
                                height: Sizes.size80 + Sizes.size14,
                                child: CircularProgressIndicator(
                                  color: Colors.red.shade500,
                                  strokeWidth: Sizes.size6,
                                  value: _progressAnimationController.value,
                                ),
                              ),
                              Container(
                                width: Sizes.size80,
                                height: Sizes.size80,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.red.shade500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: IconButton(
                            onPressed: _onPickVideoPressed,
                            icon: const FaIcon(
                              FontAwesomeIcons.image,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
