import 'dart:math';

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

import 'package:wearwizard/services/cloth_service.dart';

class ClothesDetail extends StatefulWidget {
  final int index;

  const ClothesDetail({Key? key, required this.index}) : super(key: key);

  @override
  State<ClothesDetail> createState() => _ClothesDetailState();
}

class _ClothesDetailState extends State<ClothesDetail> {
  final DropDownController dropDownController = DropDownController();
  final DropDownDisposeController dropDownDisposeController =
      DropDownDisposeController();
  List<DropDownItem> items1 = [
    // DropDownItem(text: "内搭", data: 0),
    // DropDownItem(text: "下装", data: 1),
    // DropDownItem(text: "外套", data: 2),
    // DropDownItem(text: "饰品", data: 3)
    DropDownItem(text: "Base", data: 0),
    DropDownItem(text: "Bottom", data: 1),
    DropDownItem(text: "Outerwear", data: 2),
    DropDownItem(text: "Accessories", data: 3)
  ];
  List<DropDownItem> items2 = [];
  List<DropDownItem> items3 = [];
  List<DropDownItem> items4 = [];

  bool _landscape = false;

  final List<String> ClothesList = [
    'Base',
    'Bottom',
    'Outerwear',
    'Accessories'
  ];
  // final List<String> ClothesList = ['内搭', '下装', '外套', '饰品'];

  List<String> clothesPic = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await setupData();
      setState(() {});
    });
  }

  Future<void> setupData() async {
    // items1 = List.generate(
    //   6,
    //   (index) => DropDownItem(
    //     text: "Single Item $index",
    //     data: index,
    //   ),
    // );
    items2 = List.generate(
      8,
      (index) => DropDownItem(
        text: "Multi Item $index",
        data: index,
      ),
    );
    items3 = List.generate(
      10,
      (index) => DropDownItem(
        text: "Single Item $index",
        icon: const Icon(Icons.ac_unit),
        activeIcon: const Icon(Icons.ac_unit),
        data: index,
      ),
    );
    items4 = List.generate(
      12,
      (index) => DropDownItem(
        text: "Multi Item $index",
        data: index,
      ),
    );

    var clothes = await Cloth()
        .getClothesByCategory(CategoryType.values[widget.index], 1, 20);

    for (var cloth in clothes) {
      clothesPic.add(cloth.picture);
    }
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
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  'My ${ClothesList[widget.index]}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                  ),
                ),
              ]),
            ),
            Positioned(
              top: -4,
              left: 10,
              child: IconButton(
                iconSize: 20,
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  DropDownMenu(
                    controller: dropDownController,
                    disposeController: dropDownDisposeController,
                    headerItemStyle: const DropDownItemStyle(
                      activeIconColor: Colors.blue,
                      activeTextStyle: TextStyle(color: Colors.blue),
                    ),
                    headerItems: [
                      DropDownItem<Tab>(
                        text: ClothesList[widget.index],
                        icon: const Icon(Icons.arrow_drop_down),
                        activeIcon: const Icon(Icons.arrow_drop_up),
                      ),
                      DropDownItem<Tab>(
                        // text: "类型",
                        text: "Category",
                        icon: const Icon(Icons.arrow_drop_down),
                        activeIcon: const Icon(Icons.arrow_drop_up),
                      ),
                      DropDownItem<Tab>(
                        // text: "季节",
                        text: "Seasons",
                        icon: const Icon(Icons.arrow_drop_down),
                        activeIcon: const Icon(Icons.arrow_drop_up),
                      ),
                      DropDownItem<Tab>(
                        // text: "颜色",
                        text: "Colours",
                        icon: const Icon(Icons.arrow_drop_down),
                        activeIcon: const Icon(Icons.arrow_drop_up),
                      ),
                    ],
                    viewOffsetY: MediaQuery.of(context).padding.top + 40,
                    viewBuilders: [
                      DropDownListView(
                        controller: dropDownController,
                        items: items1,
                        headerIndex: 0,
                        onDropDownHeaderUpdate:
                            (List<DropDownItem> checkedItems) {
                          return DropDownHeaderStatus(
                            text: checkedItems
                                .map((e) => e.text)
                                .toList()
                                .join("、"),
                            highlight: checkedItems.isNotEmpty,
                          );
                        },
                      ),
                      DropDownListView(
                        controller: dropDownController,
                        items: items2,
                        maxMultiChoiceSize: 2,
                        headerIndex: 1,
                        onDropDownHeaderUpdate:
                            (List<DropDownItem> checkedItems) {
                          return DropDownHeaderStatus(
                            text: checkedItems
                                .map((e) => e.text)
                                .toList()
                                .join("、"),
                            highlight: checkedItems.isNotEmpty,
                          );
                        },
                      ),
                      DropDownGridView(
                        controller: dropDownController,
                        crossAxisCount: 3,
                        boxStyle: const DropDownBoxStyle(
                          padding: EdgeInsets.all(16),
                        ),
                        itemStyle: DropDownItemStyle(
                          activeBackgroundColor: const Color(0xFFF5F5F5),
                          activeIconColor: Colors.blue,
                          activeTextStyle: const TextStyle(color: Colors.blue),
                          activeBorderRadius: BorderRadius.circular(6),
                        ),
                        items: items3,
                        headerIndex: 2,
                        onDropDownHeaderUpdate:
                            (List<DropDownItem> checkedItems) {
                          return DropDownHeaderStatus(
                            text: checkedItems
                                .map((e) => e.text)
                                .toList()
                                .join("、"),
                            highlight: checkedItems.isNotEmpty,
                          );
                        },
                      ),
                      DropDownGridView(
                        controller: dropDownController,
                        crossAxisCount: 3,
                        boxStyle: const DropDownBoxStyle(
                          padding: EdgeInsets.all(16),
                        ),
                        itemStyle: DropDownItemStyle(
                          activeBackgroundColor: const Color(0xFFF5F5F5),
                          activeIconColor: Colors.blue,
                          activeTextStyle: const TextStyle(color: Colors.blue),
                          activeBorderRadius: BorderRadius.circular(6),
                        ),
                        items: items4,
                        maxMultiChoiceSize: 2,
                        headerIndex: 3,
                        onDropDownHeaderUpdate:
                            (List<DropDownItem> checkedItems) {
                          return DropDownHeaderStatus(
                            text: checkedItems
                                .map((e) => e.text)
                                .toList()
                                .join("、"),
                            highlight: checkedItems.isNotEmpty,
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              color: WearWizardTheme.background,
              margin: EdgeInsets.only(top: 90.0),
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ClothesItemList(clothesPic),
            ),
          ],
        ),
      ),
    );
  }
}

class ClothesItemList extends StatelessWidget {
  final List<String> pictures;
  final double screenWidth =
      MediaQueryData.fromView(WidgetsBinding.instance.window).size.width;
  final double screenHeight =
      MediaQueryData.fromView(WidgetsBinding.instance.window).size.height;
  ClothesItemList(this.pictures, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: WearWizardTheme.background,
      child: WaterfallFlow.builder(
        gridDelegate: const SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10.0,
          // mainAxisSpacing: 10.0,
        ),
        itemBuilder: (BuildContext context, int index) {
          // Replace this with your actual image widget
          Widget imageWidget = Container(
            decoration: const BoxDecoration(
              // color: Colors.primaries[index % Colors.primaries.length],
              borderRadius: BorderRadius.all(
                Radius.circular(12.0),
              ),
            ),
            alignment: Alignment.center,
          );
          if (index == 0) {
            return Container(
              height: (screenWidth - 40) / 3,
              margin: const EdgeInsets.only(top: 10.0),
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
              ),
              clipBehavior: Clip.antiAlias,
              child: Material(
                color: Colors.white,
                child: InkWell(
                  onTap: () => {print("add new clothes")},
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: const Icon(
                      Icons.add_circle_rounded,
                      color: Color.fromARGB(255, 219, 219, 219),
                      size: 50,
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Container(
              height: (screenWidth - 40) / 3,
              margin: const EdgeInsets.only(top: 10.0),
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
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage(pictures[index - 1]),
                    fit: BoxFit.cover,
                  ),
                ),
                // width: double.infinity, // Make image fill the width
                child: imageWidget,
              ),
            );
          }
        },
        itemCount: pictures.length + 1,
      ),
    );
  }
}
