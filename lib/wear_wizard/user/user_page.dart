import 'package:flutter/material.dart';
import '../wearwizard_theme.dart';
import 'package:wearwizard/wear_wizard/login/login_page.dart';
// 动态项
class MyPostItem extends StatelessWidget {
  final List<String> imageUrlList;

  const MyPostItem({Key? key, required this.imageUrlList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),

        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 2.2/3,
        ),
        itemCount: imageUrlList.length,
        itemBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: 130,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                imageUrlList[index],
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
class UserScreen extends StatefulWidget {
  final AnimationController? animationController;
  const UserScreen({Key? key, this.animationController}) : super(key: key);

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
    
  setting() {
    print("setting");
  }

  Future<bool> getData() {
    return Future.value(true);
  }

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final double screenWidth =MediaQueryData.fromView(WidgetsBinding.instance.window).size.width;
    // final double screenHeight =MediaQueryData.fromView(WidgetsBinding.instance.window).size.height;
    return Container(
      color: WearWizardTheme.nearlyWhite,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder<bool>(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              return ListView(
                controller: scrollController,
                physics: const BouncingScrollPhysics(),
                children: <Widget>[
                  // 背景图片
                  Stack(
                    children: [
                      Positioned.fill(
                        child: Image.asset(
                          "./assets/closet/BottomBG.jpg",
                          fit: BoxFit.cover,
                          height: 300,
                          width: double.infinity,
                        ),
                      ),
                      // 渐变背景
                      Positioned.fill(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.black.withOpacity(0.5), // 渐变起始色
                                Colors.transparent, // 渐变结束色
                              ],
                            ),
                          ),
                        ),
                      ),
                      // 用户信息
                      Container(
                        margin: const EdgeInsets.only(top: 260.0),
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                          color: WearWizardTheme.nearlyWhite,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0),
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children:[
                                const Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundImage: AssetImage(
                                        "./assets/closet/OuterwearBG.jpg",
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "User Name",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "user signature",
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => const LoginPage()),
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
                                      decoration: BoxDecoration(
                                        color: WearWizardTheme.nearlyBlue,
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                      child: const Text(
                                        // "编辑资料",
                                        "Edit",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: setting,
                                    color: WearWizardTheme.nearlyBlue,
                                    iconSize: 32,
                                    icon: const Icon(Icons.settings),
                                  ),
                                ]
                              ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    // Text("发布",style: TextStyle(fontSize: 16,),),
                                    Text("Moments",style: TextStyle(fontSize: 16,),),
                                    Text("0",style: TextStyle(fontSize: 16,),),
                                  ],
                                ),
                                Column(
                                  children: [
                                    // Text("关注",style: TextStyle(fontSize: 16,),),
                                    Text("Follow",style: TextStyle(fontSize: 16,),),
                                    Text("0",style: TextStyle(fontSize: 16,),),
                                  ],
                                ),
                                Column(
                                  children: [
                                    // Text("粉丝",style: TextStyle(fontSize: 16,),),
                                    Text("Follower",style: TextStyle(fontSize: 16,),),
                                    Text("0",style: TextStyle(fontSize: 16,),),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(indent:20,endIndent: 20, height: 1, color: Color.fromARGB(44, 93, 93, 93)),
                  // 我的动态
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                    color: WearWizardTheme.nearlyWhite,
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          // "我的动态",
                          "My Moments",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        MyPostItem(
                          imageUrlList: [
                            "./assets/closet/OuterwearBG.jpg",
                            "./assets/closet/BottomBG.jpg",
                            "./assets/closet/OuterwearBG.jpg",
                            "./assets/closet/BottomBG.jpg",
                            "./assets/closet/BottomBG.jpg",
                            "./assets/closet/OuterwearBG.jpg",
                            "./assets/closet/BottomBG.jpg",
                            "./assets/closet/OuterwearBG.jpg",
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

}

