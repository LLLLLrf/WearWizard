import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ll_dropdown_menu/dropdown/drop_down_typedef.dart';
import 'package:ll_dropdown_menu/ll_dropdown_menu.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import '../wearwizard_theme.dart';
import 'package:waterfall_flow/waterfall_flow.dart';
import 'package:marvelous_carousel/marvelous_carousel.dart';
import 'package:expandable_widgets/expandable_widgets.dart';

class EditPage extends StatefulWidget {
  const EditPage({Key? key}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
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
                      '编辑搭配',
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
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(40),
                ),
                clipBehavior: Clip.antiAlias,
                child: Center(
                  child: IconButton(
                    iconSize: 14,
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
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
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(40),
                ),
                clipBehavior: Clip.antiAlias,
                child: Material(
                  child: InkWell(
                    onTap: () {
                      print('保存');
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      color: Colors.blue,
                      child: const Center(
                        child: Text(
                          '保存',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
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
                  const ClothesForm(),
                ],
              ),
            ),
          ],
        )));
  }
}

class ClothesForm extends StatefulWidget {
  const ClothesForm({Key? key}) : super(key: key);

  @override
  State<ClothesForm> createState() => _ClothesFormState();
}

class _ClothesFormState extends State<ClothesForm>
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

  List<String> situations = ['工作', '休闲', '运动', '出行'];
  List<IconData> situationIcons = [
    Icons.work_outline,
    Icons.local_cafe_outlined,
    Icons.sports_basketball_outlined,
    Icons.card_travel_outlined,
  ];

  List<int> seasonList = [0, 0, 0, 0];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 245, 245, 245),
            borderRadius: BorderRadius.circular(40),
          ),
          child: Stack(
            alignment: AlignmentDirectional.centerStart,
            children: [
              // const Positioned(
              //   child: Icon(
              //     Icons.local_cafe_outlined,
              //   ),
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Material(
                    color:Colors.transparent,
                    child: Container(
                      width: screenWidth - 40,
                      color: Colors.transparent,
                      child: Expandable(
                        animationDuration: const Duration(milliseconds: 200),
                        borderRadius: BorderRadius.circular(40),
                        showArrowWidget: false,
                        centralizeFirstChild: false,
                        backgroundColor:
                            const Color.fromARGB(255, 245, 245, 245),
                            // const Color.fromARGB(255, 100, 100, 100),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.transparent,
                          ),
                        ],
                        clickable: Clickable.everywhere,
                        firstChild: Container(
                          margin: EdgeInsets.only(left: screenWidth - 140),
                          width: 60,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                color: Colors.black,
                                situationIcons[selectSituation],
                              ),
                              Text(
                                situations[selectSituation],
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ],
                          ),
                        ),
                        secondChild: Container(
                          width: screenWidth - 40,
                          margin: const EdgeInsets.only(top: 8),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectSituation = 0;
                                    });
                                    if (_animationController.isCompleted) {
                                      _animationController.reverse();
                                    } else {
                                      _animationController.forward();
                                    }
                                    print("点击${selectSituation}");
                                  },
                                  child: const Row(
                                    children: [
                                      Icon(
                                        color: Colors.black,
                                        Icons.work_outline,
                                      ),
                                      Text(
                                        '工作',
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
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectSituation = 1;
                                    });
                                    if (_animationController.isCompleted) {
                                      _animationController.reverse();
                                    } else {
                                      _animationController.forward();
                                    }
                                    print("点击${selectSituation}");
                                  },
                                  child: const Row(
                                    children: [
                                      Icon(
                                        color: Colors.black,
                                        Icons.local_cafe_outlined,
                                      ),
                                      Text(
                                        '休闲',
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
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectSituation = 2;
                                    });
                                    if (_animationController.isCompleted) {
                                      _animationController.reverse();
                                    } else {
                                      _animationController.forward();
                                    }
                                    print("点击${selectSituation}");
                                  },
                                  child: const Row(
                                    children: [
                                      Icon(
                                        color: Colors.black,
                                        Icons.sports_basketball_outlined,
                                      ),
                                      Text(
                                        '运动',
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
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectSituation = 3;
                                    });
                                    if (_animationController.isCompleted) {
                                      _animationController.reverse();
                                    } else {
                                      _animationController.forward();
                                    }
                                    print("点击${selectSituation}");
                                  },
                                  child: const Row(
                                    children: [
                                      Icon(
                                        color: Colors.black,
                                        Icons.card_travel_outlined,
                                      ),
                                      Text(
                                        '出行',
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
                              ]),
                        ),
                        animationController: _animationController,
                        arrowLocation: ArrowLocation.left,
                        arrowWidget: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AnimatedIcon(
                              icon: AnimatedIcons.menu_close,
                              progress: _animation,
                              size: 16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // SizedBox(height: 40,),
              const Positioned(
                left: 20,
                width: 60,
                top: 0,
                child: Text(
                  '适用场景',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                    fontWeight: FontWeight.normal,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal:20, vertical: 4),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 245, 245, 245),
            borderRadius: BorderRadius.circular(40),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:[
              const Text(
                "适用季节",
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          height: 30,
                          width: 30,
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: seasonList[0] == 1 ? Colors.blue : Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              "春",
                              style: TextStyle(
                                color: seasonList[0] == 1 ? Colors.white : Colors.black,
                                fontSize: 13.0,
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ),
                        ),
                        onTap: () => {
                          setState(() {
                            seasonList[0] = seasonList[0] == 1 ? 0 : 1;
                          }),
                        },
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          height: 30,
                          width: 30,
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: seasonList[1] == 1 ? Colors.blue : Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              "夏",
                              style: TextStyle(
                                color: seasonList[1] == 1 ? Colors.white : Colors.black,
                                fontSize: 13.0,
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ),
                        ),
                        onTap: () => {
                          setState(() {
                            seasonList[1] = seasonList[1] == 1 ? 0 : 1;
                          }),
                        },
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          height: 30,
                          width: 30,
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: seasonList[2] == 1 ? Colors.blue : Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              "秋",
                              style: TextStyle(
                                color: seasonList[2] == 1 ? Colors.white : Colors.black,
                                fontSize: 13.0,
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ),
                        ),
                        onTap: () => {
                          setState(() {
                            seasonList[2] = seasonList[2] == 1 ? 0 : 1;
                          }),
                        },
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          height: 30,
                          width: 30,
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: seasonList[3] == 1 ? Colors.blue : Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              "冬",
                              style: TextStyle(
                                color: seasonList[3] == 1 ? Colors.white : Colors.black,
                                fontSize: 13.0,
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ),
                        ),
                        onTap: () => {
                          setState(() {
                            seasonList[3] = seasonList[3] == 1 ? 0 : 1;
                          }),
                        },
                      ),
                    ]
                  ),
                ),
              ),
              
            ]
          )
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.symmetric(horizontal:20, vertical: 4),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 245, 245, 245),
            borderRadius: BorderRadius.circular(40),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:[
              const Text(
                "搭配色系",
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
                  child: InkWell(
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
                          '黑白灰',
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
    "assets/closet/base.webp",
    "assets/closet/outerwear.jpg",
    "assets/closet/base.webp",
    "assets/closet/outerwear.jpg",
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
                      print('添加');
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
                      "assets/closet/base.webp",
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
