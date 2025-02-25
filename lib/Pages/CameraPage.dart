import 'package:chatapp/Screens/CameraScreen.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraPage extends StatelessWidget {
  final List<CameraDescription> cameras;

  const CameraPage({Key? key, required this.cameras}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CameraScreen(cameras: cameras);
  }
}
