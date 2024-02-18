import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:camera/camera.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class VideoRecordingScreen extends StatefulWidget {
  static const routeUrl = "/";
  static const routeName = "video_record";

  const VideoRecordingScreen({super.key});

  @override
  State<VideoRecordingScreen> createState() => _VideoRecordingScreenState();
}

class _VideoRecordingScreenState extends State<VideoRecordingScreen> {
  bool _hasPermission = false;
  bool _isSelfieMode = false;
  late FlashMode _flashMode;

  late CameraController _cameraController;

  @override
  void initState() {
    super.initState();
    initPermissions();
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
    _flashMode = _cameraController.value.flashMode;
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
                CameraPreview(_cameraController),
                Positioned(
                  top: Sizes.size20,
                  right: Sizes.size6,
                  child: Column(
                    children: [
                      IconButton(
                        color: Colors.white,
                        onPressed: () => _toggleSelfieMode(),
                        icon: const FaIcon(FontAwesomeIcons.cameraRotate),
                      ),
                      Gaps.v10,
                      IconButton(
                        color: _flashMode == FlashMode.off ? Colors.yellow : Colors.white,
                        onPressed: () => _setFlashMode(FlashMode.off),
                        icon: const Icon(Icons.flash_off_rounded),
                      ),
                      Gaps.v10,
                      IconButton(
                        color: _flashMode == FlashMode.always ? Colors.yellow : Colors.white,
                        onPressed: () => _setFlashMode(FlashMode.always),
                        icon: const Icon(Icons.flash_on_rounded),
                      ),
                      Gaps.v10,
                      IconButton(
                        color: _flashMode == FlashMode.auto ? Colors.yellow : Colors.white,
                        onPressed: () => _setFlashMode(FlashMode.auto),
                        icon: const Icon(Icons.flash_auto_rounded),
                      ),
                      Gaps.v10,
                      IconButton(
                        color: _flashMode == FlashMode.torch ? Colors.yellow : Colors.white,
                        onPressed: () => _setFlashMode(FlashMode.torch),
                        icon: const Icon(Icons.flashlight_on_rounded),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
