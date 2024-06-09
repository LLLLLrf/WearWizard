import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ll_dropdown_menu/dropdown/drop_down_typedef.dart';
import 'package:ll_dropdown_menu/ll_dropdown_menu.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:wearwizard/wear_wizard/ideas/edit_page.dart';
import '../wearwizard_theme.dart';
import 'package:waterfall_flow/waterfall_flow.dart';
import 'package:marvelous_carousel/marvelous_carousel.dart';
import 'package:expandable_widgets/expandable_widgets.dart';

class OutfitDeatailPage extends StatefulWidget {
  final AnimationController? animationController;
  final int index;
  const OutfitDeatailPage({Key? key, this.animationController, required this.index})
      : super(key: key);

  @override
  State<OutfitDeatailPage> createState() => _OutfitDeatailState();
}

class _OutfitDeatailState extends State<OutfitDeatailPage> {
  final double screenWidth =
      MediaQueryData.fromView(WidgetsBinding.instance!.window).size.width;
  final double screenHeight =
      MediaQueryData.fromView(WidgetsBinding.instance!.window).size.height;

  late final List<Widget> _widgets = [];

  @override
  void initState() {
    super.initState();
    _widgets.addAll([
      ClothesCarousel(
        isReverse: false,
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: SafeArea(
            child: Stack(
          children: [
            Container(
              height: 40,
              // color: Colors.amber,
              child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      // '搭配详情',
                      'Outfit Deatail',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ]),
            ),
            Positioned(
              top: 6,
              left: 20,
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(40),
                ),
                clipBehavior: Clip.antiAlias,
                child: Center(
                  child: IconButton(
                    iconSize: 23,
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.blue),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ),
            Positioned(
              top: 6,
              right: 20,
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(40),
                ),
                clipBehavior: Clip.antiAlias,
                child: Material(
                  child: InkWell(
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EditPage()),
                      )
                    },
                    child: const Center(
                      child: Icon(
                        Icons.edit,
                        color: Colors.blue,
                        size: 25,)
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Column(
                children: [
                  ClothesCarousel(isReverse: false),
                  const SizedBox(
                    height: 6,
                  ),
                  const ClothesList(),
                  const SizedBox(
                    height: 6,
                  ),
                  const ClothesInfo(),
                ],
              ),
            ),
          ],
        )));
  }
}

//选择的表单
class ClothesInfo extends StatefulWidget {
  const ClothesInfo({Key? key}) : super(key: key);

  @override
  State<ClothesInfo> createState() => _ClothesInfoState();
}

class _ClothesInfoState extends State<ClothesInfo>
    with TickerProviderStateMixin {
  int selectSituation = 0;

  final Animatable<double> _sizeTween = Tween<double>(begin: 0.0, end: 1.0);
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    CurvedAnimation curve =
        CurvedAnimation(parent: _animationController, curve: Curves.linear);
    _animation = _sizeTween.animate(curve);

    super.initState();
  }

  // List<String> situations = ['工作', '休闲', '运动', '出行'];
  List<String> situations = ['Work', 'Leisure', 'Sport', 'Vocation'];
  List<IconData> situationIcons = [
    Icons.work_outline,
    Icons.local_cafe_outlined,
    Icons.sports_basketball_outlined,
    Icons.card_travel_outlined,
  ];

  List<int> seasonList = [0, 0, 0, 0];
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal:20, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: const Color.fromARGB(255, 245, 245, 245)),
            borderRadius: BorderRadius.circular(40),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:[
              const Text(
                // "适合场合",
                "Occasion",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.none,
                ),
              ),
              Container(
                height:34,
                width: 150,
                child: Material(
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        child: const Icon(
                          Icons.work_outline,
                        ),
                      ),
                      const Text(
                        // '通勤',
                        'Work',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]
          )
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal:20, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: const Color.fromARGB(255, 245, 245, 245)),
            borderRadius: BorderRadius.circular(40),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:[
              const Text(
                // "适合季节",
                "Season",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.none,
                ),
              ),
              Container(
                height:34,
                width: 150,
                child: Material(
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        child: const Icon(
                          Icons.ac_unit,
                        ),
                      ),
                      const Text(
                        // '冬天',
                        'Winter',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]
          )
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal:20, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: const Color.fromARGB(255, 245, 245, 245)),
            borderRadius: BorderRadius.circular(40),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:[
              const Text(
                // "搭配色系",
                "Colour",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.none,
                ),
              ),
              Container(
                height:34,
                width: 150,
                child: Material(
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                          margin: const EdgeInsets.only(right: 6),
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(20),
                            border: const Border(
                              top: BorderSide(width: 2.0, color: Colors.white),
                              bottom: BorderSide(width: 2.0, color: Colors.white),
                              left: BorderSide(width: 2.0, color: Colors.white),
                              right: BorderSide(width: 2.0, color: Colors.white),
                            )
                          ),
                        ),
                      const Text(
                        // '黑白色',
                        'black&white',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]
          )
        ),
      ],
    );
  }
}

// 衣服列表
class ClothesList extends StatefulWidget {
  const ClothesList({Key? key}) : super(key: key);

  @override
  State<ClothesList> createState() => _ClothesListState();
}

class _ClothesListState extends State<ClothesList> {
  List<String> images = [
    "assets/closet/OuterwearBG.jpg",
    "assets/closet/OuterwearBG.jpg",
    "assets/closet/OuterwearBG.jpg",
    "assets/closet/OuterwearBG.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        margin: const EdgeInsets.only(left: 16,bottom:8),
        child: ListView.builder(
          itemCount: images.length + 1,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            if (index < images.length) {
              // 衣服图片item
              return Container(
                margin: const EdgeInsets.only(left: 14, bottom: 10),
                padding: const EdgeInsets.all(14),
                height: 90,
                width: 90,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 120, 120, 120)
                          .withOpacity(0.14),
                      spreadRadius: 3,
                      blurRadius: 6,
                      offset: const Offset(2, 4),
                    ),
                  ],
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.asset(images[index]),
                ),
              );
            } else {
              // 添加衣服按钮
              return Container(
                margin: const EdgeInsets.only(left: 14, bottom: 10, right: 20),
                // padding: const EdgeInsets.all(14),
                height: 90,
                width: 90,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 120, 120, 120)
                          .withOpacity(0.14),
                      spreadRadius: 3,
                      blurRadius: 6,
                      offset: const Offset(2, 4),
                    ),
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                child: Material(
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {
                      // print('添加');
                      print('Add');
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: const Icon(
                        Icons.add_circle_rounded,
                        color: Color.fromARGB(255, 219, 219, 219),
                        size: 40,
                      ),
                    ),
                  ),
                ),
              );
            }
          },
        ));
  }
}

//衣服轮播图
class ClothesCarousel extends StatefulWidget {
  bool isReverse;
  ClothesCarousel({
    super.key,
    required this.isReverse,
  });

  @override
  State<ClothesCarousel> createState() => _ClothesCarouselState();
}

class _ClothesCarouselState extends State<ClothesCarousel> {
  @override
  Widget build(BuildContext context) {
    return Container(
        // padding: const EdgeInsets.only(top: 54),
        child: SizedBox(
      height: 430,
      child: MarvelousCarousel(
        scrollDirection: Axis.horizontal,
        reverse: widget.isReverse,
        margin: 0,
        dotsBottom: 30,
        opacity: 0.7,
        // scaleX: 0.8,
        scaleY: 0.8,
        children: [1, 2, 3, 4]
            .map(
              (e) => Container(
                margin: const EdgeInsets.only(top: 10, bottom: 20, right: 4),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 69, 69, 69)
                          .withOpacity(0.2),
                      spreadRadius: 3,
                      blurRadius: 10,
                      offset: const Offset(4, 6),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: SizedBox(
                    // height: 440,
                    // width: 330,
                    child: Image.asset(
                      "assets/closet/OuterwearBG.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    ));
  }
}
