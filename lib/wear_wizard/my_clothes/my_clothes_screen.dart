import 'clothes_card.dart';
import 'package:flutter/material.dart';
import 'clothes_detail.dart';

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
                'My Wardrobe',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(
            height: screenHeight - 168,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ClothesDetail(
                                index: 0,
                              )),
                    )
                  },
                  child: CustomWidget(
                    backgroundImagePath: 'assets/closet/BaseBG.png',
                    leftImagePath: 'assets/closet/BaseIcon.png',
                    mainTitle: 'Base',
                    subTitle: '内搭',
                    clothesNum: 10,
                    clothesWidth: 114,
                    clothesHeight: 116,
                    gradientColor: const [
                      Color(0xDAAF9F),
                      Color(0xDDA491),
                      Color(0xEF4B05)
                    ],
                  ),
                ),
                InkWell(
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ClothesDetail(
                                index: 1,
                              )),
                    )
                  },
                  child: CustomWidget(
                    backgroundImagePath: 'assets/closet/BottomBG.jpg',
                    leftImagePath: 'assets/closet/BottomIcon.png',
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
                ),
                InkWell(
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ClothesDetail(
                                index: 2,
                              )),
                    )
                  },
                  child: CustomWidget(
                    backgroundImagePath: 'assets/closet/OuterwearBG.jpg',
                    leftImagePath: 'assets/closet/OuterwearIcon.png',
                    mainTitle: 'Outerwear',
                    subTitle: '外套',
                    clothesNum: 20,
                    clothesWidth: 114,
                    clothesHeight: 114,
                    gradientColor: const [
                      Color.fromARGB(142, 209, 218, 213),
                      Color.fromARGB(144, 58, 138, 94),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ClothesDetail(
                                index: 3,
                              )),
                    )
                  },
                  child: CustomWidget(
                    backgroundImagePath: 'assets/closet/AccessoriesBG.jpeg',
                    leftImagePath: 'assets/closet/AccessoriesIcon.png',
                    mainTitle: 'Accessories',
                    subTitle: '饰品',
                    clothesNum: 25,
                    clothesWidth: 80,
                    clothesHeight: 130,
                    gradientColor: const [
                      Color.fromRGBO(37, 37, 37, 0.414),
                      Color.fromARGB(97, 72, 72, 72),
                      Color.fromARGB(45, 147, 147, 147)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
