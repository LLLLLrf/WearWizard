import 'package:flutter/material.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
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
    return 
    SafeArea(
      child: Scaffold(
      body: ContainedTabBarView(
      
        tabs: const [
          Text(
            '今日推荐',
          ),
          Text(
            '我的搭配',
          ),
        ],
        tabBarProperties: TabBarProperties(
          background: Container(
            decoration: const BoxDecoration(
            ),
          ),
          height: 60.0,
          indicatorColor: Colors.blue[400],

          // indicatorWeight: 6.0,
          labelColor: Colors.black,
          labelStyle: const TextStyle(
            fontSize: 22.0,
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
    );
      }
}

