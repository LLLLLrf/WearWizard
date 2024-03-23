import 'package:flutter/material.dart';
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
              return Stack(
                children: <Widget>[
                  MyCarousel(imageUrls: imageUrls),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}