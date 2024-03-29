import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:waterfall_flow/waterfall_flow.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:searchbar_animation/searchbar_animation.dart';
import 'package:wearwizard/fitness_app/fitness_app_theme.dart';

import 'search_bar.dart';

class IdeasHome extends StatefulWidget {
  final AnimationController? animationController;

  IdeasHome({Key? key, this.animationController}) : super(key: key);

  @override
  _IdeasHomeState createState() => _IdeasHomeState();
}

class _IdeasHomeState extends State<IdeasHome> {
  final double screenWidth =MediaQueryData.fromView(WidgetsBinding.instance.window).size.width;
  final double screenHeight =MediaQueryData.fromView(WidgetsBinding.instance.window).size.height;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          SearchBarScreen(),
          Container(
            margin: const EdgeInsets.only(top: 58.0),
            child: ContainedTabBarView(
              tabs: const [
                Text(
                  '关注',
                ),
                Text(
                  '广场',
                ),
              ],
              tabBarProperties: TabBarProperties(
                width: screenWidth-260,
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
                const IdeasList(),
                Container(color: const Color.fromARGB(255, 255, 255, 255)),
              ],
              onChange: (index) => print(index),
            ),
          ),
          Container(
            // color: WearWizardTheme.background,
            color: const Color.fromARGB(255, 255, 255, 255),
            margin: const EdgeInsets.only(top: 98.0),
            height: 2,
          )
        ],
      ),
    );
  }
  bottonWidget(){
    return IconButton(
      icon: const Icon(Icons.search),
      onPressed: () {
        debugPrint('Search button pressed');
      },
    );
  }
  trailingWidget() {
    return IconButton(
      icon: const Icon(Icons.filter_list),
      onPressed: () {
        debugPrint('Filter button pressed');
      },
    );
  }
}

class IdeasList extends StatelessWidget {
  const IdeasList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: WearWizardTheme.background,
      padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8.0),
      child: WaterfallFlow.builder(
        gridDelegate: const SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemBuilder: (BuildContext context, int index) {
          // Generate random text for demonstration
          String text = 'Item $index aascdsa asdfasd asdf';
          // Replace this with your actual image widget
          Widget imageWidget = Container(
            height: 40+70*(index%3),
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
          return Container(
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
                  padding: const EdgeInsets.symmetric(horizontal: 6.0,vertical: 4.0),
                  color: Colors.white,
                  child: Text(
                      text

                    ),
                ),
              ],
            ),
          );
        },
        itemCount: 100, // Change this to your actual item count
      ),
    );
  }
}
