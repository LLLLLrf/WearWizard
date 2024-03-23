import 'dart:typed_data';
import 'package:image/image.dart' as img;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

late List<CameraDescription> _cameras;


/// CameraApp is the Main Application.
class CameraApp extends StatefulWidget {
  /// Default Constructor
  const CameraApp({super.key});

  @override
  State<CameraApp> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  late CameraController controller;
  bool _isCameraInitialized = false;
  
  @override
  void initState() {
    super.initState();
    // Initialize cameras
    _initializeCameras().then((_) {
      // Use the first camera from the list
      controller = CameraController(_cameras[0], ResolutionPreset.max);
      controller.initialize().then((_) {
        if (!mounted) {
          return;
        }
        controller.startImageStream((CameraImage image) {
          List<Plane> planes = image.planes;
          Uint8List yPlaneBytes = planes[0].bytes;
          Uint8List uPlaneBytes = planes[1].bytes;
          Uint8List vPlaneBytes = planes[2].bytes;
          int width = image.width;
          int height = image.height;

          List<int> bgrData = [];
          for (int i = 0; i < height; i++) {
            for (int j = 0; j < width; j++) {
              int yIndex = i * width + j;
              int uIndex = (i ~/ 2) * (width ~/ 2) + (j ~/ 2);
              int vIndex = (i ~/ 2) * (width ~/ 2) + (j ~/ 2);
              
              int Y = yPlaneBytes[yIndex];
              int U = uPlaneBytes[uIndex];
              int V = vPlaneBytes[vIndex];
              
              int R = (Y + 1.402 * (V - 128)).round().clamp(0, 255);
              int G = (Y - 0.344 * (U - 128) - 0.714 * (V - 128)).round().clamp(0, 255);
              int B = (Y + 1.772 * (U - 128)).round().clamp(0, 255);
              
              bgrData.add(B);
              bgrData.add(G);
              bgrData.add(R);
            }
          }
        });
        setState(() {
          _isCameraInitialized = true;
        });
      }).catchError((Object e) {
        if (e is CameraException) {
          switch (e.code) {
            case 'CameraAccessDenied':
              // Handle access errors here.
              break;
            default:
              // Handle other errors here.
              break;
          }
        }
      });
    });
  }

  Future<void> _initializeCameras() async {
    // Fetch the available cameras
    _cameras = await availableCameras();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isCameraInitialized) {
      // If camera is not initialized yet, show a loading indicator
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return MaterialApp(
      home: CameraPreview(controller),
    );
  }
}
