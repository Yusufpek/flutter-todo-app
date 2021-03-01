import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../colors.dart';

class MainPageAnimWidget extends StatelessWidget {
  final double width;
  final double height;

  const MainPageAnimWidget({Key key, this.width, this.height})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: todoAmber,
      width: width,
      height: height * 0.4,
      padding: EdgeInsets.all(8),
      child: Center(
        child: Lottie.asset(
          'assets/main_page_anim.json',
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}
