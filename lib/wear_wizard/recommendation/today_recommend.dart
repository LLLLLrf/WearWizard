import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wearwizard/wear_wizard/components/camera_page.dart';
import '../wearwizard_theme.dart';
import '../components/swiper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TodayRecommend extends StatefulWidget{
  TodayRecommend({Key? key}) : super(key: key);
  final double screenWidth =MediaQueryData.fromView(WidgetsBinding.instance.window).size.width;
  final double screenHeight =MediaQueryData.fromView(WidgetsBinding.instance.window).size.height;

  @override
  _TodayRecommendState createState() => _TodayRecommendState();
}
Future<bool> getData() {
  return Future.value(true);
}
class _TodayRecommendState extends State<TodayRecommend> {
//  Future<String> fetchImageUrl() async {
//     final response = await http.get(Uri.parse('https://ww-1301781137.cos.ap-guangzhou.myqcloud.com/test/test.png'));
    
//     if (response.statusCode == 200) {
//       // 假设返回的数据是 JSON 格式
//       final data = json.decode(response.body);
//       return data['imageUrl'];
//     } else {
//       throw Exception('Failed to load image URL');
//     }
//   }


  final imageUrls= [
    'assets/images/model.png',
    'assets/images/model.png',
    'assets/images/model.png',
    // './assets/closet/OuterwearBG.jpg',
    // './assets/closet/BaseBG.png',
  ];
  final double sizeBox = (screenHeight-((screenWidth-40)*5/4+100+158+90))/3;

  @override
  Widget build(BuildContext context) {
    return 
    Stack(
      children: [
        Container(
        color: WearWizardTheme.background,
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
                    SizedBox(height: sizeBox,),
                    MyCarousel(imageUrls: imageUrls),
                    SizedBox(height: sizeBox,),
                    Container(
                      height: 100,
                      // color: Colors.white,
                      padding: const EdgeInsets.only(left: 22, right: 22, top: 10, bottom: 10),
                      margin: const EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 0),
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
                              color: Color.fromARGB(255, 235, 235, 235),
                              thickness: 1.6,
                              width: 16,
                              indent: 6,
                              endIndent: 6,
                            ),
                            Row(children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                Row(children: [
                                  Text("Cloudy",style: TextStyle(fontSize:15,fontWeight: FontWeight.bold),),
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
                                    Text("Light Jacket",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                                  ],),
                                  SizedBox(width: 18,),
                                  Column(children: [
                                    Icon(Icons.wb_sunny, color: Colors.yellow),
                                    Text("Sun Protection",style:TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                                  ],),
                                ],)
                              ],)
                            ]),
                          ],),
                        )
                      ],)
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
      Positioned(
        bottom: 78,
        height: 80,
        width: screenWidth,
        child:Container(
          color: WearWizardTheme.background,
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
                      color: const Color.fromARGB(255, 201, 226, 248),
                    ),
                    padding: const EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 10),
                    width: screenWidth/2-30,
                    height: 80,
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Add New Outfit",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color:Color.fromARGB(255, 90, 90, 90)),),
                            Text("Record today's outfit",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color:Colors.grey[800]),),
                          ],
                        )
                      ],
                    ),
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
                    padding: const EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 157, 247, 216),
                    ),
                    width: screenWidth/2-30,
                    height: 80,
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Community",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color:Color.fromARGB(255, 90, 90, 90)),),
                            Text("Explore fashion trends",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color:Colors.grey[800]),),
                          ],
                        )
                      ],
                    ),
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
      )
      ]
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