import 'package:flutter/material.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/widgets.dart';
import '../wearwizard_theme.dart';
import 'today_recommend.dart';

class RecommendScreen extends StatelessWidget {
  final AnimationController? animationController;

  RecommendScreen({Key? key, this.animationController}) : super(key: key);
  Future<bool> getData() {
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: WearWizardTheme.background,
            body: ContainedTabBarView(
              tabs: const [
                Text(
                  '今日搭配',
                ),
                Text(
                  '我的搭配',
                ),
              ],
              tabBarProperties: TabBarProperties(
                indicator: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.blue[400]!,
                      width: 3.0,
                    ),
                  ),
                ),
                background: Container(),
                height: 50.0,
                indicatorColor: Colors.blue[400],
                indicatorSize: TabBarIndicatorSize.label,
                // indicatorWeight: 6.0,
                labelColor: Colors.black,
                labelStyle: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                unselectedLabelColor: Colors.grey[400],
                unselectedLabelStyle: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
              views: [
                const TodayRecommend(),
                Container(color: const Color.fromARGB(255, 255, 255, 255)),
              ],
              onChange: (index) => print(index),
            ),
          ),
          Container(
            color: WearWizardTheme.background,
            // color: Colors.white,
            margin: const EdgeInsets.only(top: 49.0),
            height: 2,
          )
        ],
      ),
    );
  }
}
