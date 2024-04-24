import 'package:flutter/material.dart';

import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/widgets.dart';


class CustomWidget extends StatelessWidget {
  final String backgroundImagePath;
  final String leftImagePath;
  final String mainTitle;
  final String subTitle;
  final double clothesHeight;
  final double clothesWidth;
  final List<Color> gradientColor;
  final int clothesNum;

  final double screenWidth =
      MediaQueryData.fromView(WidgetsBinding.instance.window).size.width;
  final double screenHeight =
      MediaQueryData.fromView(WidgetsBinding.instance.window).size.height;

  CustomWidget({
    Key? key,
    required this.backgroundImagePath,
    required this.leftImagePath,
    required this.mainTitle,
    required this.subTitle,
    required this.clothesNum,
    required this.clothesHeight,
    required this.clothesWidth,
    required this.gradientColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth-28,
      height: 160,
      child: Stack(
        children: [
          ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
              colors: gradientColor,
            ).createShader(bounds),
            blendMode: BlendMode.srcATop,
            child: Container(
              margin: const EdgeInsets.only(top: 36.0),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(40.0),
                  topLeft: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                ),
                image: DecorationImage(
                  image: AssetImage(backgroundImagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            left: 10.0,
            top: 8,
            child: Container(
              width: clothesWidth.toDouble(),
              height: clothesHeight,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(leftImagePath),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          Positioned(
            bottom: 62.0,
            left: 126.0,
            child: BorderedText(
              strokeColor:Colors.black,
              strokeWidth: 2,
              child: Text(
                mainTitle,
                style: const TextStyle(
                  height: BorderSide.strokeAlignInside,
                  color: Colors.white,
                  fontSize: 42.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: BorderSide.strokeAlignInside,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 24.0,
            left: 126.0,
            child: BorderedText(
              strokeColor:Colors.black,
              strokeWidth: 2,
              child: Text(
                subTitle,
                style: const TextStyle(
                  height: BorderSide.strokeAlignInside,
                  color: Colors.white,
                  fontSize: 36.0,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      blurRadius: 3.0,
                      color: Colors.black,
                      offset: Offset(0.2, 0.2),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 26.0,
            left: 208.0,
            child: BorderedText(
              strokeColor:Colors.black,
              strokeWidth: 2,
              child: Text(
                "$clothesNum 件",
                style: const TextStyle(
                  letterSpacing: BorderSide.strokeAlignInside,
                  height: BorderSide.strokeAlignInside,
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
