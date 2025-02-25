import 'dart:math';
import 'package:camera/camera.dart';
import 'package:chatapp/Screens/CameraView.dart';
import 'package:chatapp/Screens/VideoView.dart';
import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  const CameraScreen({Key? key, required this.cameras}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _cameraController;
  late Future<void> cameraValue;
  bool isRecording = false;
  bool flash = false;
  bool isCameraFront = true;
  double transform = 0;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  void _initializeCamera() {
    _cameraController = CameraController(widget.cameras[0], ResolutionPreset.high);
    cameraValue = _cameraController.initialize();
  }

  @override
  void dispose() {
    if (mounted) {
      _cameraController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
            future: cameraValue,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: CameraPreview(_cameraController),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          Positioned(
            bottom: 0.0,
            child: Container(
              color: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 5),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(
                          flash ? Icons.flash_on : Icons.flash_off,
                          color: Colors.white,
                          size: 28,
                        ),
                        onPressed: () {
                          setState(() => flash = !flash);
                          _cameraController.setFlashMode(
                            flash ? FlashMode.torch : FlashMode.off,
                          );
                        },
                      ),
                      GestureDetector(
                        onLongPress: () async {
                          try {
                            await _cameraController.startVideoRecording();
                            setState(() => isRecording = true);
                          } catch (e) {
                            debugPrint("❌ Error starting video recording: $e");
                          }
                        },
                        onLongPressUp: () async {
                          try {
                            XFile videoPath = await _cameraController.stopVideoRecording();
                            setState(() => isRecording = false);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (builder) => VideoViewPage(path: videoPath.path),
                              ),
                            );
                          } catch (e) {
                            debugPrint("❌ Error stopping video recording: $e");
                          }
                        },
                        onTap: () {
                          if (!isRecording) takePhoto(context);
                        },
                        child: Icon(
                          isRecording ? Icons.radio_button_on : Icons.panorama_fish_eye,
                          color: isRecording ? Colors.red : Colors.white,
                          size: isRecording ? 80 : 70,
                        ),
                      ),
                      IconButton(
                        icon: Transform.rotate(
                          angle: transform,
                          child: const Icon(
                            Icons.flip_camera_ios,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        onPressed: () async {
                          setState(() {
                            isCameraFront = !isCameraFront;
                            transform += pi;
                          });
                          int cameraPos = isCameraFront ? 0 : 1;
                          _cameraController = CameraController(
                            widget.cameras[cameraPos],
                            ResolutionPreset.high,
                          );
                          cameraValue = _cameraController.initialize();
                          await cameraValue;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Hold for Video, tap for Photo",
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void takePhoto(BuildContext context) async {
    try {
      XFile file = await _cameraController.takePicture();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (builder) => CameraViewPage(path: file.path),
        ),
      );
    } catch (e) {
      debugPrint("❌ Error taking photo: $e");
    }
  }
}
