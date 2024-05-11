import 'package:searchbar_animation/searchbar_animation.dart';
import 'package:flutter/material.dart';
import 'package:wearwizard/wear_wizard/ideas/edit_page.dart';
import 'package:wearwizard/wear_wizard/wearwizard_theme.dart';
import 'edit_page.dart';

class SearchBarScreen extends StatefulWidget {
  const SearchBarScreen({Key? key}) : super(key: key);

  @override
  _SearchBarScreenState createState() => _SearchBarScreenState();
}

class _SearchBarScreenState extends State<SearchBarScreen> {
  final double screenWidth =
      MediaQueryData.fromView(WidgetsBinding.instance.window).size.width;
  final double screenHeight =
      MediaQueryData.fromView(WidgetsBinding.instance.window).size.height;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildSearchbarAnimation(),
    );
  }

  Widget _buildSearchbarAnimation() {
    return SafeArea(
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10, left: 10),
            height: 46,
            width: screenWidth - 80,
            child: Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(66, 170, 170, 170),
                borderRadius: BorderRadius.all(
                  Radius.circular(100),
                ),
              ),
              padding: const EdgeInsets.all(12),
              child: Container(
                padding: EdgeInsets.zero,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(230, 245, 245, 245),
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(230, 245, 245, 245),
                      blurRadius: 8,
                      spreadRadius: 8,
                    ),
                  ],
                ),
                width: double.infinity,
                height: 40,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, top: 16),
            width: 34,
            height: 34,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(0, 247, 247, 247),
            ),
            child: const Icon(
              Icons.search,
              color: Colors.grey,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 56, top: 10),
            height: 46,
            width: screenWidth - 130,
            child: SearchBar(
              hintText: '大家都在搜[减脂]',
              hintStyle: MaterialStateProperty.resolveWith<TextStyle?>(
                  (_) => const TextStyle(
                        color: Color.fromARGB(255, 170, 170, 170),
                        fontSize: 17,
                      )),
              constraints: BoxConstraints(
                maxWidth: screenWidth - 130,
                maxHeight: 46,
                minHeight: 46,
              ),
              backgroundColor: MaterialStateProperty.all<Color?>(
                  const Color.fromARGB(0, 255, 255, 255)),
              shadowColor: MaterialStateProperty.all<Color?>(
                  const Color.fromARGB(0, 255, 255, 255)),
              overlayColor: MaterialStateProperty.all<Color?>(
                  const Color.fromARGB(0, 255, 255, 255)),
              surfaceTintColor: MaterialStateProperty.all<Color?>(
                  const Color.fromARGB(0, 255, 255, 255)),
            ),
          ),
          Container(
            height: 42,
            width: 42,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: WearWizardTheme.nearlyBlue,
            ),
            margin: EdgeInsets.only(left: screenWidth - 60, top: 12),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EditPage()),
                );
              },
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }


}
