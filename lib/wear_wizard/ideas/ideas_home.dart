import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:waterfall_flow/waterfall_flow.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:wearwizard/fitness_app/fitness_app_theme.dart';
import 'package:wearwizard/wear_wizard/ideas/ideas_detail.dart';
import 'package:wearwizard/services/api_http.dart';
import 'search_bar.dart';

class IdeasHome extends StatefulWidget {
  final AnimationController? animationController;

  IdeasHome({Key? key, this.animationController}) : super(key: key);

  @override
  _IdeasHomeState createState() => _IdeasHomeState();
}

class _IdeasHomeState extends State<IdeasHome> {
  final double screenWidth =
      MediaQueryData.fromView(WidgetsBinding.instance.window).size.width;
  final double screenHeight =
      MediaQueryData.fromView(WidgetsBinding.instance.window).size.height;

  var reco_data;
  void initState() {
    super.initState();
    ApiService.get(
      'user/getRecommendation?pageSize=30&pageNum=1',
    ).then((response){
      if (response.statusCode == 200 ) {
        reco_data=jsonDecode(response.body);
        print('response: $reco_data');
        print(reco_data['code']);
      } else {
        print('Failed to get data from server');
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          const SearchBarScreen(),
          Container(
            margin: const EdgeInsets.only(top: 58.0),
            child: 
            ContainedTabBarView(
              tabs: const [
                Text(
                  // '广场',
                  'Discover',
                ),
                Text(
                  // '关注',
                  'Follow',
                ),
              ],
              tabBarProperties: TabBarProperties(
                width: screenWidth - 260,
                background: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(0, 255, 255, 255),
                  ),
                ),
                height: 42.0,
                indicatorColor: WearWizardTheme.nearlyBlue,
                indicatorSize: TabBarIndicatorSize.label,
                indicator: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border(
                    bottom: BorderSide(
                      color: WearWizardTheme.nearlyBlue,
                      width: 4.0,
                    ),
                  ),
                ),
                labelColor: Colors.black,
                labelStyle: const TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                ),
                unselectedLabelColor: Colors.grey[400],
                unselectedLabelStyle: const TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
              views: [
                IdeasList(data:0),
                IdeasList(data:1),
              ],
              onChange: (index) => print(index),
            ),
          ),
          Container(
            color: const Color.fromARGB(255, 255, 255, 255),
            margin: const EdgeInsets.only(top: 98.0),
            height: 2,
          )
        ],
      ),
    );
  }

  // bottonWidget(){
  //   return IconButton(
  //     icon: const Icon(Icons.search),
  //     onPressed: () {
  //       debugPrint('Search button pressed');
  //     },
  //   );
  // }
  // trailingWidget() {
  //   return IconButton(
  //     icon: const Icon(Icons.filter_list),
  //     onPressed: () {
  //       debugPrint('Filter button pressed');
  //     },
  //   );
  // }
}

class IdeasList extends StatelessWidget {
  var data;
  IdeasList({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: WearWizardTheme.background,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: WaterfallFlow.builder(
        gridDelegate: const SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          // mainAxisSpacing: 8.0,
        ),
        itemBuilder: (BuildContext context, int index) {
          // Generate random text for demonstration
          String text = 'The Test Data $index';
          // Replace this with your actual image widget
          Widget imageWidget = Container(
            height: 40 + 70 * (index % 3),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.primaries[index % Colors.primaries.length],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            alignment: Alignment.center,
            child: Text('Image $index'),
          );
          return InkWell(
            onTap: () => {
              // navigate to detail page
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const IdeasDetail(
                          index: 0,
                        )),
              )
            },
            child: Container(
              margin: const EdgeInsets.only(top: 8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Replace SizedBox with your image widget
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      // image: DecorationImage(
                      //   image: AssetImage('assets/images/ideas/idea_$index.jpg'),
                      //   fit: BoxFit.cover,
                      // ),
                    ),
                    width: double.infinity, // Make image fill the width
                    child: imageWidget,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6.0, vertical: 6.0),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                    child: Text(text),
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: 100, // Change this to your actual item count
      ),
    );
  }
}
