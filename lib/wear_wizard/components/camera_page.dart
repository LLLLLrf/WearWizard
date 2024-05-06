import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:image/image.dart' as imglib;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

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
  late CameraController controller;
  // bool _isCameraInitialized = true;
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
          debugPrint('Image Stream');
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
    // return CameraPreview(controller);

    return Stack(
      fit: StackFit.expand,
      children: [
        CameraPreview(controller),
        // Container(
        //   color: Colors.white.withOpacity(0.7),
        // ),

        CustomPaint(
          size: const Size(double.infinity, double.infinity),
          painter: BackgroundPainter(),
        ),
        // 中间的内容
        Center(
          child: Container(
            alignment: Alignment.center,
            child: const Text(
              "Scanner",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
          ),
        ),
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
                  child: const Text(
                    "上衣-98%",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  width:
                      MediaQuery.of(context).size.width * 0.6 * 0.52, // 宽度的20%
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
                      Container(
                        margin: const EdgeInsets.only(left: 8),
                        child: const Icon(
                          Icons.add_circle,
                          size: 24,
                          color: Color.fromARGB(255, 106, 171, 225),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 8),
                        height: 26,
                        child: const Text(
                          "添加到衣柜",
                          style: TextStyle(
                            color: Color.fromARGB(255, 106, 171, 225),
                            fontSize: 16.0,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
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
                  onTap: () {
                    Navigator.pop(context);
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
                  onTap: () => {},
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
                  onTap: () => {},
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
