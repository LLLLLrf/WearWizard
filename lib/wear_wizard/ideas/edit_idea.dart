import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:waterfall_flow/waterfall_flow.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:wearwizard/fitness_app/fitness_app_theme.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';
import 'package:tap_to_dismiss_keyboard/tap_to_dismiss_keyboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:multi_image_picker_plus/multi_image_picker_plus.dart';

class EditIdea extends StatefulWidget {
  final AnimationController? animationController;
  final int index;
  const EditIdea({Key? key, this.animationController, required this.index})
      : super(key: key);

  @override
  _EditIdeaState createState() => _EditIdeaState();
}

class _EditIdeaState extends State<EditIdea> {
  final double screenWidth =
      MediaQueryData.fromView(WidgetsBinding.instance.window).size.width;
  final double screenHeight =
      MediaQueryData.fromView(WidgetsBinding.instance.window).size.height;

  @override
  Widget build(BuildContext context) {
    return TapToDissmissKeyboard(
      child: Container(
        color: Colors.white,
        child: SafeArea(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 4, right: 2),
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Center(
                        child: IconButton(
                          iconSize: 22,
                          icon: const Icon(Icons.arrow_back_ios_new,
                              color: Colors.grey),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                    Material(
                      child: Container(
                        margin: EdgeInsets.only(right:16),
                        padding: EdgeInsets.symmetric(horizontal:8,vertical:4),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child:InkWell(
                          onTap: () {
                            // Publish
                          },
                          child: const Text(
                            'Publish',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ),
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 50.0),
                child: Column(
                  children: [
                    ImagesList(),
                    SizedBox(
                      height: 6,
                    ),
                    MomentContent()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 图片列表
class ImagesList extends StatefulWidget {
  const ImagesList({Key? key}) : super(key: key);

  @override
  State<ImagesList> createState() => _ImagesListState();
}

class _ImagesListState extends State<ImagesList> {
  List<Asset> images = <Asset>[];
  List<String> imageUrls = <String>[];
  String _error = 'No Error Dectected';

  Future<void> _loadAssets() async {
    final ColorScheme colorScheme = ColorScheme.fromSwatch().copyWith(
      primary: Colors.blue,
      onPrimary: Colors.white,
      surface: Colors.blue,
      onSurface: Colors.white,
      background: Colors.blue,
      onBackground: Colors.white,);

    List<Asset> resultList = <Asset>[];
    String error = 'No Error Dectected';

    try {
      resultList = await MultiImagePicker.pickImages(
        selectedAssets: images,
        androidOptions: AndroidOptions(
          actionBarColor: colorScheme.surface,
          actionBarTitleColor: colorScheme.onSurface,
          statusBarColor: colorScheme.surface,
          actionBarTitle: "Select Photo",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: colorScheme.primary,
          maxImages: 9,
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }
    if (!mounted) return;

    setState(() {
      images = resultList;
      _error = error;
    });

    for (var image in images) {
      File file = await getFileFromAsset(image);
      await uploadImage(file);
    }
    
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
  }

  Future<File> getFileFromAsset(Asset asset) async {
    ByteData byteData = await asset.getByteData();
    List<int> imageData = byteData.buffer.asUint8List();

    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    File file = File('$tempPath/${asset.name}');
    
    return await file.writeAsBytes(imageData);
  }

  // get image url
  Future<void> uploadImage(File file) async {
    var request = http.MultipartRequest('POST', Uri.parse('http://8.134.164.130:8080/api/file/upload'));
    request.files.add(await http.MultipartFile.fromPath('image', file.path));
    request.fields['biz']='moment_img';
    var res = await request.send();
    var response = await http.Response.fromStream(res);
    print(response.body);
    imageUrls.add(response.body);
  }


  @override
  Widget build(BuildContext context) {
    return Container(
        height: 150,
        margin: const EdgeInsets.only(left: 16,bottom:8),
        child: ListView.builder(
          itemCount: images.length + 1,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            if (index < images.length) {
              Asset asset = images[index];
              return Container(
                margin: const EdgeInsets.only(left: 14, bottom: 10),
                padding: const EdgeInsets.all(14),
                height: 140,
                width: 140,
                
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 120, 120, 120)
                          .withOpacity(0.14),
                      spreadRadius: 3,
                      blurRadius: 6,
                      offset: const Offset(2, 4),
                    ),
                  ],
                  image: DecorationImage(
                    image: AssetThumbImageProvider(asset, width: 140, height: 140),
                    fit: BoxFit.cover,
                  ),
                  
                ),
              );
            } else {
              return Container(
                margin: const EdgeInsets.only(left: 14, bottom: 10, right: 20),
                height: 140,
                width: 140,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 120, 120, 120)
                          .withOpacity(0.14),
                      spreadRadius: 3,
                      blurRadius: 6,
                      offset: const Offset(2, 4),
                    ),
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                child: Material(
                  color: Colors.white,
                  child: InkWell(
                    onTap: _loadAssets,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: const Icon(
                        Icons.add_circle_rounded,
                        color: Color.fromARGB(255, 219, 219, 219),
                        size: 40,
                      ),
                    ),
                  ),
                ),
              );
            }
          },
        ));
  }
}

class MomentContent extends StatefulWidget {
  const MomentContent({Key? key}) : super(key: key);

  @override
  _MomentContentState createState() => _MomentContentState();
}

class _MomentContentState extends State<MomentContent> {
  final double screenWidth =
      MediaQueryData.fromView(WidgetsBinding.instance.window).size.width;
  final double screenHeight =
      MediaQueryData.fromView(WidgetsBinding.instance.window).size.height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenWidth,
      height: screenHeight-300,
      child: Container(
        padding: const EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TitleText(),
            Container(
              margin: const EdgeInsets.only(top: 10),
              height: 0.8,
              width: screenWidth - 28,
              color: Colors.grey.withOpacity(0.2),
            ),
            const SizedBox(height: 8),
            const ContentText(),
          ],
        )
      ),
    );
  }
}

class TitleText extends StatefulWidget {
  const TitleText({Key? key}) : super(key: key);
  
  @override
  _TitleTextState createState() => _TitleTextState();
}

class _TitleTextState extends State<TitleText> {
  final FocusNode _titlefocusNode = FocusNode();

  bool editing = false;

  @override
  void initState() {
    super.initState();
    _titlefocusNode.addListener(() {
      if (!_titlefocusNode.hasFocus) {
        _titlefocusNode.unfocus();
        setState(() {
          editing = false;
        });
      }
    });
  }
  @override
  void dispose() {
    _titlefocusNode.dispose();
    super.dispose();
  }

  final double screenWidth =
      MediaQueryData.fromView(WidgetsBinding.instance.window).size.width;
  final double screenHeight =
      MediaQueryData.fromView(WidgetsBinding.instance.window).size.height;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 5,right: 5),
      child: Container(
        height: 40,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Material(
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: screenWidth-40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Container(
                        child: TextField(
                          focusNode: _titlefocusNode,
                          onTap:() => {
                            setState(() {
                              editing = true;
                            })
                          },
                          decoration: const InputDecoration(
                            hintText: 'Title',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 16.0,
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(left: 10, bottom:14),
                          ),
                          style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ContentText extends StatefulWidget {
  const ContentText({Key? key}) : super(key: key);
  
  @override
  _ContentTextState createState() => _ContentTextState();
}

class _ContentTextState extends State<ContentText> {
  final FocusNode _ContentfocusNode = FocusNode();

  bool editing = false;

  @override
  void initState() {
    super.initState();
    _ContentfocusNode.addListener(() {
      if (!_ContentfocusNode.hasFocus) {
        _ContentfocusNode.unfocus();
        setState(() {
          editing = false;
        });
      }
    });
  }
  @override
  void dispose() {
    _ContentfocusNode.dispose();
    super.dispose();
  }

  final double screenWidth =
      MediaQueryData.fromView(WidgetsBinding.instance.window).size.width;
  final double screenHeight =
      MediaQueryData.fromView(WidgetsBinding.instance.window).size.height;
  @override
  Widget build(BuildContext context) {
    return Container(
      
      margin: const EdgeInsets.only(left: 5,right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Material(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: screenWidth-40,
                    height: screenHeight-500,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                    child: TextField(
                      maxLines: null,
                      focusNode: _ContentfocusNode,
                      onTap:() => {
                        setState(() {
                          editing = true;
                        })
                      },
                      decoration: const InputDecoration(
                        
                        hintText: 'Content',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.0,
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 10, bottom:14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

