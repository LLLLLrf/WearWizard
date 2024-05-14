import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:waterfall_flow/waterfall_flow.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:wearwizard/fitness_app/fitness_app_theme.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';
import 'package:tap_to_dismiss_keyboard/tap_to_dismiss_keyboard.dart';
import 'package:flutter/cupertino.dart';

class IdeasDetail extends StatefulWidget {
  final AnimationController? animationController;
  final int index;
  const IdeasDetail({Key? key, this.animationController, required this.index})
      : super(key: key);

  @override
  _IdeasDetailState createState() => _IdeasDetailState();
}

class _IdeasDetailState extends State<IdeasDetail> {
  final double screenWidth =
      MediaQueryData.fromView(WidgetsBinding.instance.window).size.width;
  final double screenHeight =
      MediaQueryData.fromView(WidgetsBinding.instance.window).size.height;

  @override
  Widget build(BuildContext context) {
    return TapToDissmissKeyboard(
      child: Container(
        color: Colors.white,
        child: SafeArea(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 4, right: 2),
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Center(
                            child: IconButton(
                              iconSize: 22,
                              icon: const Icon(Icons.arrow_back_ios_new,
                                  color: Colors.grey),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 10),
                          child: const CircleAvatar(
                            radius: 18,
                            backgroundImage:
                                AssetImage('assets/closet/OuterwearBG.jpg'),
                          ),
                        ),
                        Container(
                          height: 40,
                          // color: Colors.amber,
                          child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '用户名',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ]),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      height: 34,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Material(
                        child: InkWell(
                          onTap: () {
                            print('分享');
                          },
                          child: Container(
                            width: 34,
                            height: 34,
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.ios_share_outlined,
                                color: Colors.grey,
                                size: 22,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 50,
                left: 0,
                right: 0,
                child: Container(
                  height: 1,
                  color: Colors.grey.withOpacity(0.2),
                ),
              ),
              const Positioned(
                top: 50,
                left: 0,
                right: 0,
                child: CommendList(),
              ),
              const BottomBar(),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);
  
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  final FocusNode _focusNode = FocusNode();

  bool liked = false;
  bool commending = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        // 如果失去焦点，则收起键盘
        _focusNode.unfocus();
        setState(() {
          commending = false;
        });
      }
    });
  }
  @override
  void dispose() {
    // 在组件销毁时释放焦点
    _focusNode.dispose();
    super.dispose();
  }

  final double screenWidth =
      MediaQueryData.fromView(WidgetsBinding.instance.window).size.width;
  final double screenHeight =
      MediaQueryData.fromView(WidgetsBinding.instance.window).size.height;
  @override
  Widget build(BuildContext context) {
    return Padding(
      // bottom:MediaQuery.of(context).viewInsets.bottom,
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: 50,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Material(
              child: Container(
                margin: const EdgeInsets.only(left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: const CircleAvatar(
                        radius: 16,
                        backgroundImage:
                            AssetImage('assets/closet/OuterwearBG.jpg'),
                      ),
                    ),
                    Container(
                      width: commending?screenWidth-100:screenWidth - 160,
                      height: 32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.grey.withOpacity(0.1),
                      ),
                      child: Container(
                        child: TextField(
                          focusNode: _focusNode,
                          onTap:() => {
                            setState(() {
                              commending = true;
                            })
                          },
                          decoration: const InputDecoration(
                            
                            hintText: '评论',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 14.0,
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(left: 10, bottom:14),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: !commending,
              child: Container(
                margin: const EdgeInsets.only(right: 0),
                child: Material(
                  child: InkWell(
                    onTap: () {
                      print('赞');
                      setState(() {
                      liked = !liked;
                    });
                    },
                    child: Container(
                      width: 34,
                      height: 34,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Center(
                        child: liked?const Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 22,
                      ):const Icon(
                          CupertinoIcons.heart,
                          color: Colors.grey,
                          size: 22,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: commending ? Material(
                child: InkWell(
                  onTap: () {
                    print('发送');
                  },
                  child: Container(
                    width: 34,
                    height: 34,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.send,
                        color: Colors.grey,
                        size: 22,
                      ),
                    ),
                  ),
                ),
              ) : Material(
                child: InkWell(
                  onTap: () {
                    
                  },
                  child: Container(
                    width: 34,
                    height: 34,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: const Center(
                      child:Icon(
                        Icons.comment_outlined,
                        color: Colors.grey,
                        size: 22,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CommendList extends StatefulWidget {
  const CommendList({Key? key}) : super(key: key);

  @override
  _CommendListState createState() => _CommendListState();
}

class _CommendListState extends State<CommendList> {
  final double screenWidth =
      MediaQueryData.fromView(WidgetsBinding.instance.window).size.width;
  final double screenHeight =
      MediaQueryData.fromView(WidgetsBinding.instance.window).size.height;

  List<String> commends = [
    '1234',
    'aaaa',
    'hello',
    '1234',
    'aaaa',
    'hello',
    '1234',
    'aaaa',
    'hello',
    '1234',
    'aaaa',
    'hello',
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenWidth,
      height: screenHeight,
      child: ListView.builder(
        itemCount: commends.length + 2,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return const ImageSwiper();
          }else if(index == 1){
            return Container(
              padding: const EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "标题部分。。。。",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "正文部分。。。。123123 123 1231231231231 123123 123123 12123123123123123123123123123123123123123123123123",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    children: [
                      Text(
                        '2021-10-10 10:10',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.0,
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'ip:GuangDong',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.0,
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    height: 0.8,
                    width: screenWidth - 28,
                    color: Colors.grey.withOpacity(0.2),
                  ),
                  
                ],
              )
            );
          }else {
            return Container(
              margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: const CircleAvatar(
                      radius: 16,
                      backgroundImage:
                          AssetImage('assets/closet/OuterwearBG.jpg'),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: const Text(
                          '用户名',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 0),
                        child: Text(
                          commends[index - 1],
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        height: 0.8,
                        width: screenWidth - 80,
                        color: Colors.grey.withOpacity(0.2),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class ImageSwiper extends StatefulWidget {
  const ImageSwiper({Key? key}) : super(key: key);

  @override
  _ImageSwiperState createState() => _ImageSwiperState();
}

class _ImageSwiperState extends State<ImageSwiper> {
  List<String> images = [
    "assets/closet/OuterwearBG.jpg",
    "assets/closet/OuterwearBG.jpg",
  ];
  final double screenWidth =
      MediaQueryData.fromView(WidgetsBinding.instance.window).size.width;
  final double screenHeight =
      MediaQueryData.fromView(WidgetsBinding.instance.window).size.height;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth,
      height: screenWidth * 1.2,
      child: Swiper(
          pagination: const SwiperPagination(builder: SwiperPagination.dots),
          itemCount: images.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(images[index]),
                  fit: BoxFit.cover,
                ),
              ),
            );
          }),
    );
  }
}
