import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:image/image.dart' as imglib;
import 'package:image_picker/image_picker.dart';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:wearwizard/services/cloth_service.dart';

enum ControlState {
  stream,
  capture,
  waiting,
}

late List<CameraDescription> _cameras;
final double screenWidth =
    MediaQueryData.fromView(WidgetsBinding.instance.window).size.width;
final double screenHeight =
    MediaQueryData.fromView(WidgetsBinding.instance.window).size.height;

/// CameraApp is the Main Application.
class CameraApp extends StatefulWidget {
  /// Default Constructor
  const CameraApp({super.key});
  @override
  State<CameraApp> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  // bool _isCameraInitialized = true;
  bool _isCameraInitialized = false;

  ControlState _controlState = ControlState.waiting;

  String _clothType = 'negative';

  double _clothConfidence = 0.0;

  Rect _clothRect = Rect.zero;

  String _clothSpiltImage = '';

  @override
  void initState() {
    super.initState();
    // Initialize cameras
    _initializeCameras().then((_) {
      // Use the first camera from the list
      _controller = CameraController(_cameras[0], ResolutionPreset.max);
      _initializeControllerFuture = _controller.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {
          _isCameraInitialized = true;
          _controlState = ControlState.stream;
          _clothType = 'negative';
          _clothConfidence = 0.0;
          _clothRect = Rect.zero;
          _clothSpiltImage = '';
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
    _controller.dispose();
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
    // return CameraPreview(_controller);

    return Stack(
      fit: StackFit.expand,
      children: [
        CameraPreview(_controller),
        // Container(
        //   color: Colors.white.withOpacity(0.7),
        // ),

        if (_controlState == ControlState.capture ||
            _controlState == ControlState.waiting)
          CustomPaint(
            size: const Size(double.infinity, double.infinity),
            painter: BackgroundPainter(),
          ),
        if (_controlState == ControlState.capture && _clothSpiltImage != '')
          // show spilt image
          Positioned(
            child: Image.network(
              _clothSpiltImage,
              fit: BoxFit.contain,
            ),
          ),
        if (_controlState == ControlState.capture && _clothSpiltImage == '')
          Center(
            child: Container(
              alignment: Alignment.center,
              child: const Text(
                "No Cloth Detected",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                ),
              ),
            ),
          ),
        if (_controlState == ControlState.capture && _clothSpiltImage != '')
          // 半透明蓝色矩形
          Positioned(
            top: MediaQuery.of(context).size.height * 0.2 - 40, // 在挖空矩形上方40个像素
            left: MediaQuery.of(context).size.width * 0.2, // 位置与挖空矩形左边对齐
            width: MediaQuery.of(context).size.width * 0.6,
            height: 40, // 高度稍短一点
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 67, 170, 255)
                    .withOpacity(0.5), // 半透明蓝色
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), // 左上角圆角
                  topRight: Radius.circular(20), // 右上角圆角
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Text(
                        '$_clothType ${(_clothConfidence * 100).toStringAsFixed(0)}%',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          decoration: TextDecoration.none,
                        ),
                      )),
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    width:
                        MediaQuery.of(context).size.width * 0.6 * 0.1, // 宽度的20%
                    height: 26,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20), // 右上角圆角
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            try {
                              await Cloth().add(
                                  _clothSpiltImage,
                                  _clothType,
                                  'base',
                                  Season.spring,
                                  'colorType',
                                  Style.casual);
                              Navigator.pop(context);
                            } catch (e) {
                              print(e);
                              setState(() {
                                _controlState = ControlState.stream;
                              });
                            }
                          },
                          child: const Icon(
                            Icons.add_circle,
                            size: 24,
                            color: Color.fromARGB(255, 106, 171, 225),
                          ),
                        ),
                        // Container(
                        //   margin: const EdgeInsets.only(right: 8),
                        //   height: 26,
                        //   child: const Text(
                        //     "ADD",
                        //     style: TextStyle(
                        //       color: Color.fromARGB(255, 106, 171, 225),
                        //       fontSize: 16.0,
                        //       decoration: TextDecoration.none,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            SafeArea(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: Colors.transparent,
                  overlayColor: MaterialStateProperty.resolveWith(
                    (states) => Colors.transparent,
                  ),
                  onTap: () async {
                    if (_controlState == ControlState.capture) {
                      await _controller.resumePreview();
                      setState(() {
                        _controlState = ControlState.stream;
                      });
                    } else if (_controlState == ControlState.stream) {
                      Navigator.pop(context);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 120,
            color: Colors.black.withOpacity(0.8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () async {
                    try {
                      await _initializeControllerFuture;

                      final image = await ImagePicker().pickImage(
                        source: ImageSource.gallery,
                      );
                      if (image != null) {
                        // await Cloth().add(image.path, 'note', 'base',
                        //     Season.spring, 'colorType', Style.casual);

                        setState(() {
                          _controlState = ControlState.waiting;
                        });

                        var result = await Cloth().spilt(image.path);

                        await _controller.pausePreview();

                        setState(() {
                          _controlState = ControlState.capture;
                          if (result['count'] == 0) {
                            _clothType = 'negative';
                            _clothConfidence = 0.0;
                            _clothRect = Rect.zero;
                            _clothSpiltImage = '';
                          } else {
                            _clothType = result['objects'][0]['label'];
                            _clothConfidence = result['objects'][0]['prob'];
                            _clothRect = Rect.fromLTWH(
                              result['objects'][0]['rect']['x'],
                              result['objects'][0]['rect']['y'],
                              result['objects'][0]['rect']['width'],
                              result['objects'][0]['rect']['height'],
                            );
                            _clothSpiltImage = result['objects'][0]['image'];
                          }
                        });
                      }
                    } catch (e) {
                      print(e);
                      setState(() {
                        _controlState = ControlState.stream;
                      });
                      _controller.resumePreview();
                    }
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(148, 224, 224, 224),
                          borderRadius: BorderRadius.all(
                            Radius.circular(14),
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.photo,
                        color: Colors.white,
                        size: 40,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    try {
                      // Ensure that the camera is initialized.
                      await _initializeControllerFuture;

                      // Attempt to take a picture and then get the location
                      // where the image file is saved.
                      final image = await _controller.takePicture();
                      await _controller.pausePreview();
                      setState(() {
                        _controlState = ControlState.waiting;
                      });
                      // await Cloth().add(image.path, 'note', 'base',
                      //     Season.spring, 'colorType', Style.casual);
                      var result = await Cloth().spilt(image.path);

                      setState(() {
                        _controlState = ControlState.capture;
                        if (result['count'] == 0) {
                          _clothType = 'negative';
                          _clothConfidence = 0.0;
                          _clothRect = Rect.zero;
                          _clothSpiltImage = '';
                        } else {
                          _clothType = result['objects'][0]['label'];
                          _clothConfidence = result['objects'][0]['prob'];
                          _clothRect = Rect.fromLTWH(
                            result['objects'][0]['rect']['x'],
                            result['objects'][0]['rect']['y'],
                            result['objects'][0]['rect']['width'],
                            result['objects'][0]['rect']['height'],
                          );
                          _clothSpiltImage = result['objects'][0]['image'];
                        }
                      });
                    } catch (e) {
                      // If an error occurs, log the error to the console.
                      print(e);
                      setState(() {
                        _controlState = ControlState.stream;
                      });
                      _controller.resumePreview();
                    }
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 76,
                        height: 76,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Container(
                          width: 66,
                          height: 66,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.black,
                              width: 3,
                            ),
                          )),
                      const Icon(
                        Icons.camera_alt,
                        size: 30,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => {},
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(150, 103, 103, 103),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const Icon(
                        Icons.cached_sharp,
                        color: Colors.white,
                        size: 40,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(0.4); // 半透明白色
    final path = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height)); // 整个画布
    final circleRect = Rect.fromLTWH(
      size.width * 0.1, // 矩形左上角 x 坐标
      size.height * 0.2, // 矩形左上角 y 坐标
      size.width * 0.8, // 矩形宽度
      size.height * 0.6, // 矩形高度
    );
    path.addRRect(RRect.fromRectAndCorners(
      circleRect,
      topLeft: const Radius.circular(20), // 圆角
      topRight: const Radius.circular(20),
      bottomLeft: const Radius.circular(20),
      bottomRight: const Radius.circular(20),
    ));

    // 绘制四个角上的白色边框
    final borderPaint = Paint()
      ..color = Colors.white // 白色
      ..style = PaintingStyle.stroke // 线条
      ..strokeWidth = 4.0; // 宽度

    final topLeftCornerRect = Rect.fromLTWH(
      circleRect.left - 4, // 在圆角矩形左上角的基础上再左移4个像素，形成白色边框的效果
      circleRect.top - 4, // 在圆角矩形左上角的基础上再上移4个像素，形成白色边框的效果
      40, // 边框宽度
      40, // 边框高度
    );
    canvas.drawArc(
        topLeftCornerRect, pi, 0.5 * pi, false, borderPaint); // 绘制左上角

    final topRightCornerRect = Rect.fromLTWH(
      circleRect.right - 36, // 在圆角矩形右上角的基础上再右移2个像素，形成白色边框的效果
      circleRect.top - 4, // 在圆角矩形右上角的基础上再上移2个像素，形成白色边框的效果
      40, // 边框宽度
      40, // 边框高度
    );
    canvas.drawArc(
        topRightCornerRect, -0.5 * pi, 0.5 * pi, false, borderPaint); // 绘制右上角

    final bottomLeftCornerRect = Rect.fromLTWH(
      circleRect.left - 4, // 在圆角矩形左下角的基础上再左移2个像素，形成白色边框的效果
      circleRect.bottom - 36, // 在圆角矩形左下角的基础上再下移2个像素，形成白色边框的效果
      40, // 边框宽度
      40, // 边框高度
    );
    canvas.drawArc(
        bottomLeftCornerRect, 0.5 * pi, 0.5 * pi, false, borderPaint); // 绘制左下角

    final bottomRightCornerRect = Rect.fromLTWH(
      circleRect.right - 36, // 在圆角矩形右下角的基础上再右移2个像素，形成白色边框的效果
      circleRect.bottom - 36, // 在圆角矩形右下角的基础上再下移2个像素，形成白色边框的效果
      40, // 边框宽度
      40, // 边框高度
    );
    canvas.drawArc(
        bottomRightCornerRect, 0, 0.5 * pi, false, borderPaint); // 绘制右下角

    path.fillType = PathFillType.evenOdd;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
