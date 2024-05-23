import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import '../wearwizard_theme.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

class MyRecommend extends StatefulWidget {
  const MyRecommend({Key? key}) : super(key: key);

  @override
  _MyRecommendState createState() => _MyRecommendState();
}

Future<bool> getData() {
  return Future.value(true);
}

class _MyRecommendState extends State<MyRecommend> {
  int id = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    id = 0;
                  });
                },
                child: Column(
                  children: [
                    Icon(
                      Icons.widgets_outlined,
                      color: id == 0 ? Colors.blue : Colors.grey,
                      size: 30,
                    ),
                    Text(
                      // '全部',
                      'All',
                      style: TextStyle(
                        color: id == 0 ? Colors.blue : Colors.grey,
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal,
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    id = 1;
                  });
                },
                child: Column(
                  children: [
                    Icon(
                      Icons.work_outline,
                      color: id == 1 ? Colors.blue : Colors.grey,
                      size: 30,
                    ),
                    Text(
                      // '工作',
                      'Work',
                      style: TextStyle(
                        color: id == 1 ? Colors.blue : Colors.grey,
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal,
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    id = 2;
                  });
                },
                child: Column(
                  children: [
                    Icon(
                      Icons.local_cafe_outlined,
                      color: id == 2 ? Colors.blue : Colors.grey,
                      size: 30,
                    ),
                    Text(
                      // '休闲',
                      'Leisure',
                      style: TextStyle(
                        color: id == 2 ? Colors.blue : Colors.grey,
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal,
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    id = 3;
                  });
                },
                child: Column(
                  children: [
                    Icon(
                      Icons.sports_basketball_outlined,
                      color: id == 3 ? Colors.blue : Colors.grey,
                      size: 30,
                    ),
                    Text(
                      // '运动',
                      'Sport',
                      style: TextStyle(
                        color: id == 3 ? Colors.blue : Colors.grey,
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal,
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    id = 4;
                  });
                },
                child: Column(
                  children: [
                    Icon(
                      Icons.card_travel_outlined,
                      color: id == 4 ? Colors.blue : Colors.grey,
                      size: 30,
                    ),
                    Text(
                      // '出游',
                      'Vocation',
                      style: TextStyle(
                        color: id == 4 ? Colors.blue : Colors.grey,
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Row(
                  children: [
                    Text(
                      '88',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15.0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      // '套搭配',
                      ' outfits in total',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15.0,
                        fontWeight: FontWeight.normal,
                      ),
                    )
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  // 右上角筛选按钮
                },
                icon: const Icon(
                  Icons.filter_alt_outlined,
                  color: Colors.grey,
                  size: 28,
                ),
              )
            ],
          ),
        ),
        const Expanded(
          child: RecommendList(),
        ),
      ],
    );
  }
}

class RecommendList extends StatelessWidget {
  const RecommendList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: WearWizardTheme.background,
      child: WaterfallFlow.builder(
        gridDelegate: const SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 0.0,
          // mainAxisSpacing: 8.0,
        ),

        itemBuilder: (BuildContext context, int index) {
          // Replace this with your actual image widget
          Widget imageWidget = Container(
            height: 220,
            decoration: const BoxDecoration(
              // color: Colors.primaries[index % Colors.primaries.length],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            alignment: Alignment.center,
          );

          return Container(
            margin: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Color.fromARGB(132, 190, 196, 196),
                  offset: Offset(-2.0, 4.0),
                  blurRadius: 6.0,
                ),
              ],
              // border:Border.all(
              //   color: Colors.white,
              //   width: 1,
              // ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Replace SizedBox with your image widget
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    // image: DecorationImage(
                    //   image: AssetImage('assets/images/ideas/idea_$index.jpg'),
                    //   fit: BoxFit.cover,
                    // ),
                    image: const DecorationImage(
                      image: AssetImage('./assets/closet/OuterwearBG.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  width: double.infinity, // Make image fill the width
                  child: imageWidget,
                ),
                Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6.0, vertical: 8.0),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 232, 232, 232),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromARGB(180, 250, 250, 250),
                                    blurRadius: 8,
                                    spreadRadius: 8,
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Image(
                                image:
                                    AssetImage('./assets/closet/OuterwearBG.jpg'),
                                width: 46,
                                height: 46,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 232, 232, 232),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromARGB(180, 250, 250, 250),
                                    blurRadius: 8,
                                    spreadRadius: 8,
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Image(
                                image:
                                    AssetImage('./assets/closet/OuterwearBG.jpg'),
                                width: 46,
                                height: 46,
                              ),
                            ),
                          ),
                        ])),
              ],
            ),
          );
        },
        itemCount: 100, // Change this to your actual item count
      ),
    );
  }
}
