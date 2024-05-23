// ignore_for_file: unused_import

import 'dart:math';
import 'package:wearwizard/wear_wizard/models/tabIcon_data.dart';
import 'package:flutter/material.dart';
import 'package:wearwizard/wear_wizard/user/user_page.dart';
import 'bottom_navigation_view/bottom_bar_view.dart';
import 'recommendation/recommendation.dart';
import 'wearwizard_theme.dart';
import 'my_clothes/my_clothes_screen.dart';
import 'components/camera_page.dart';
import 'ideas/ideas_home.dart';

// import 'components/full_camera.dart';

class WearWizardHomeScreen extends StatefulWidget {
  const WearWizardHomeScreen({super.key});

  @override
  _WearWizardHomeScreenState createState() => _WearWizardHomeScreenState();
}

class _WearWizardHomeScreenState extends State<WearWizardHomeScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: WearWizardTheme.background,
  );

  @override
  void initState() {
    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    tabBody = RecommendScreen(animationController: animationController);
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: WearWizardTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder<bool>(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              return Stack(
                children: <Widget>[
                  tabBody,
                  bottomBar(),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Widget bottomBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarView(
          tabIconsList: tabIconsList,
          addClick: () {
            navigateToNewPage();
          },
          changeIndex: (int index) {
            if (index == 0) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody = RecommendScreen(animationController: animationController);
                });
              });
            } else if (index == 1) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      MyCloset(animationController: animationController);
                });
              });
            }else if (index == 2){
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      IdeasHome(animationController: animationController);
                });
              });
            }else if (index == 3) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      UserScreen(animationController: animationController);
                });
              });
            }
          },
        ),
      ],
    );
  }

  // 导航方法，处理点击加号按钮后的导航操作
  void navigateToNewPage() {
    Navigator.push(
      context,
      // MaterialPageRoute(builder: (context) => const CameraExampleHome()),
      MaterialPageRoute(builder: (context) => const CameraApp()),
    );
    
  }
}
