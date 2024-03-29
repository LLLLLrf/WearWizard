import 'clothes_card.dart';
import 'package:flutter/material.dart';

class MyCloset extends StatelessWidget {
  final AnimationController? animationController;
  final double screenWidth =
      MediaQueryData.fromView(WidgetsBinding.instance.window).size.width;
  final double screenHeight =
      MediaQueryData.fromView(WidgetsBinding.instance.window).size.height;

  MyCloset({Key? key, this.animationController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '我的衣橱',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          SizedBox(
            height: screenHeight - 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomWidget(
                  backgroundImagePath: 'assets/closet/base.webp',
                  leftImagePath: 'assets/closet/Base.png',
                  mainTitle: 'Base',
                  subTitle: '内搭',
                  clothesNum: 10,
                  clothesWidth: 118,
                  clothesHeight: 118,
                  gradientColor: const [
                    Color.fromRGBO(91, 214, 97, 0.448),
                    Color.fromARGB(114, 105, 230, 136),
                    Color.fromARGB(44, 234, 222, 131)
                  ],
                ),
                CustomWidget(
                  backgroundImagePath: 'assets/closet/bottom.jpg',
                  leftImagePath: 'assets/closet/Bottom.png',
                  mainTitle: 'Bottom',
                  subTitle: '下装',
                  clothesNum: 15,
                  clothesWidth: 94,
                  clothesHeight: 130,
                  gradientColor: const [
                    Color.fromRGBO(82, 109, 156, 0.333),
                    Color.fromARGB(91, 88, 170, 237),
                    Color.fromARGB(44, 54, 139, 214)
                  ],
                ),
                CustomWidget(
                  backgroundImagePath: 'assets/closet/outerwear.jpg',
                  leftImagePath: 'assets/closet/Outerwear.png',
                  mainTitle: 'Outerwear',
                  subTitle: '外套',
                  clothesNum: 20,
                  clothesWidth: 114,
                  clothesHeight: 114,
                  gradientColor: const [
                    Color.fromRGBO(27, 137, 95, 0.337),
                    Color.fromARGB(91, 114, 196, 113),
                    Color.fromARGB(45, 147, 147, 147)
                  ],
                ),
                CustomWidget(
                  backgroundImagePath: 'assets/closet/accessories.jpeg',
                  leftImagePath: 'assets/closet/Accessories.png',
                  mainTitle: 'Accessories',
                  subTitle: '饰品',
                  clothesNum: 25,
                  clothesWidth: 88,
                  clothesHeight: 140,
                  gradientColor: const [
                    Color.fromRGBO(37, 37, 37, 0.414),
                    Color.fromARGB(97, 72, 72, 72),
                    Color.fromARGB(45, 147, 147, 147)
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
