import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../wearwizard_theme.dart';
import 'package:wearwizard/services/api_http.dart';
import 'package:async/async.dart';
import 'package:wearwizard/services/user_service.dart';
import 'package:wearwizard/services/socialStatistics_service.dart';
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

  Future<void> getUserInfo() async {
    User user = await User().getCurrentUser();
    socialStatistics socialNum = await socialStatistics().getsocialStatistics();
    setState(() {
      userName = user.userName;
      selfIntro = user.selfIntro;
      momentNum = socialNum.moment_num.toString();
      followNum = socialNum.follow_num.toString();
      followerNum = socialNum.follower_num.toString();
    });
  }

  final ScrollController scrollController = ScrollController();

  String? userName;
  String? selfIntro;
  String? momentNum;
  String? followNum;
  String? followerNum;

  @override
  void initState() {
    scrollController.addListener(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getUserInfo();
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
                          "./assets/images/background.jpg",
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
                                Row(
                                  children: [
                                    const CircleAvatar(
                                      radius: 30,
                                      backgroundImage: AssetImage(
                                        "./assets/images/avatar.jpg",
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Material(
                                      child: InkWell(
                                        onTap: () => {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => const LoginPage()),
                                          )
                                        },
                                        child:Container(
                                          color:WearWizardTheme.nearlyWhite,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                userName ?? "Login now",
                                                style: userName == null
                                                  ? const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.bold,
                                                      color: Color(0xFF00B6F0),
                                                    )
                                                  : const TextStyle(
                                                      fontSize: 20,
                                                    ),
                                              ),
                                              Text(
                                                selfIntro ?? "user self intro",
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () => {
                                      print("edit"),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    // Text("发布",style: TextStyle(fontSize: 16,),),
                                    const Text("Moments",style: TextStyle(fontSize: 16,),),
                                    Text(momentNum ?? "0",style: const TextStyle(fontSize: 16,),),
                                  ],
                                ),
                                Column(
                                  children: [
                                    // Text("关注",style: TextStyle(fontSize: 16,),),
                                    const Text("Follow",style: TextStyle(fontSize: 16,),),
                                    Text(followNum ?? "0",style: const TextStyle(fontSize: 16,),),
                                  ],
                                ),
                                Column(
                                  children: [
                                    // Text("粉丝",style: TextStyle(fontSize: 16,),),
                                    const Text("Follower",style: TextStyle(fontSize: 16,),),
                                    Text(followerNum ?? "0",style: const TextStyle(fontSize: 16,),),
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
                            "./assets/outfit/640.jpg",
                            "./assets/outfit/641.jpg",
                            "./assets/outfit/642.jpg",
                            "./assets/outfit/643.jpg",
                            "./assets/outfit/644.jpg",
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

