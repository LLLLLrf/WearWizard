import 'package:flutter/material.dart';
import '../wearwizard_theme.dart';


class UserScreen extends StatelessWidget {
  final AnimationController? animationController;
  const UserScreen({Key? key, this.animationController}) : super(key: key);
  Future<bool> getData() {
    return Future.value(true);
  }
  @override
  Widget build(BuildContext context) {
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
              return Stack(
                children: <Widget>[
                  
                ],
              );
            }
          },
        ),
      ),
    );
  }
}