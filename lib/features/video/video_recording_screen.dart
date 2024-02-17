import 'package:flutter/material.dart';
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

  late final CameraController _cameraController;

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
      initCamera();
      setState(() {
        _hasPermission = true;
      });
    }
  }

  Future<void> initCamera() async {
    final cameras = await availableCameras();

    debugPrint("$cameras");

    if (cameras.isEmpty) {
      return;
    }

    _cameraController = CameraController(
      cameras[0],
      ResolutionPreset.ultraHigh,
    );
    await _cameraController.initialize();
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
          : CameraPreview(_cameraController),
    );
  }
}
