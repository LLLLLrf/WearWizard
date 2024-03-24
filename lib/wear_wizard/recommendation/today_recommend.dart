import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../wearwizard_theme.dart';
import '../components/swiper.dart';

class TodayRecommend extends StatefulWidget{
  const TodayRecommend({Key? key}) : super(key: key);

  @override
  _TodayRecommendState createState() => _TodayRecommendState();
}
Future<bool> getData() {
  return Future.value(true);
}
class _TodayRecommendState extends State<TodayRecommend> {
  final double screenWidth =MediaQueryData.fromView(WidgetsBinding.instance.window).size.width;
  final double screenHeight =MediaQueryData.fromView(WidgetsBinding.instance.window).size.height;

  final imageUrls= [
    'https://via.placeholder.com/400x500/FF0000/FFFFFF',
    'https://via.placeholder.com/400x500/00FF00/FFFFFF',
    'https://via.placeholder.com/400x500/0000FF/FFFFFF',
  ];

  @override
  Widget build(BuildContext context) {
    return 
    Container(
      color: WearWizardTheme.nearlyWhite,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder<bool>(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              return Column(
                children: <Widget>[
                  const SizedBox(height: 10,),
                  MyCarousel(imageUrls: imageUrls),
                  const SizedBox(height: 20),
                  Container(
                    height: 100,
                    // color: Colors.white,
                    padding: const EdgeInsets.only(left: 22, right: 22, top: 10, bottom: 10),
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                          color: Color.fromARGB(132, 190, 196, 196),
                          offset: Offset(1.0, 1.0),
                          blurRadius: 14.0,
                        ),
                      ],
                    ),
                    child:const Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      Expanded(
                        flex:1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                            Icon(Icons.wb_twighlight, color: Colors.yellow, size:70),
                            SizedBox(width: 10,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("London", style: TextStyle(color: Colors.grey,fontSize: 12,)),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: Text(
                                        '23',
                                        style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(width: 4), // Add some spacing between texts
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: Text(
                                        '°C',
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal,)
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],),
                          VerticalDivider(
                            color: Color.fromARGB(255, 146, 146, 146),
                            thickness: 1,
                            width: 20,
                            indent: 0,
                            endIndent: 0,
                          ),
                          Row(children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                              Row(children: [
                                Text("阴",style: TextStyle(fontSize:15,fontWeight: FontWeight.bold),),
                                Text("22°",style: TextStyle(fontSize:15,fontWeight: FontWeight.bold),),
                                Text("/",style: TextStyle(fontSize: 18,color:Color.fromARGB(255, 200, 197, 197)),),
                                Text("16°",style: TextStyle(fontSize:15,fontWeight: FontWeight.bold),)
                              ],),
                              SizedBox(height: 6,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                Column(children: [
                                  Icon(Icons.wb_sunny, color: Colors.yellow),
                                  Text("适宜薄外套",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                                ],),
                                SizedBox(width: 18,),
                                Column(children: [
                                  Icon(Icons.wb_sunny, color: Colors.yellow),
                                  Text("做好防晒",style:TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                                ],),
                              ],)
                            ],)
                          ]),
                        ],),
                      )
                    ],)
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
    Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromARGB(255, 177, 216, 251),
          ),
          width: screenWidth/2-30, // 你可以根据需要调整矩形的大小
          height: 80,
           // 矩形的颜色
        ),
        Positioned(
          bottom: -54,
          right: -48,
          child: ClipPath(
            clipper: MyCustomClipper(), // 自定义的剪切路径
            child: Container(
              width: 78, // 圆形按钮的直径
              height: 78,
              decoration: const BoxDecoration(
                color: WearWizardTheme.background, // 圆形按钮的颜色
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ],
    ),
    Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromARGB(255, 157, 247, 216),

          ),
          width: screenWidth/2-30, // 你可以根据需要调整矩形的大小
          height: 80,
           // 矩形的颜色
        ),
        Positioned(
          bottom: -54,
          left: -48,
          child: ClipPath(
            clipper: MyCustomClipper(), // 自定义的剪切路径
            child: Container(
              width: 78, // 圆形按钮的直径
              height: 78,
              decoration: const BoxDecoration(
                color: WearWizardTheme.background, // 圆形按钮的颜色
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ],
    )
                      ],
                    ),
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height); // 左下角
    path.lineTo(size.width, size.height); // 右下角
    path.lineTo(size.width, 0); // 右上角
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}