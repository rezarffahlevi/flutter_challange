import 'package:flutter/material.dart';

class TheSizedBox extends StatelessWidget {
  final double width;
  final double height;

  TheSizedBox({this.width, this.height});

  TheSizedBox.bloodyLargeVertical({this.width = 0, this.height = 55});

  TheSizedBox.ultraLargeVertical({this.width = 0, this.height = 45});

  TheSizedBox.extraLargeVertical({this.width = 0, this.height = 35});

  TheSizedBox.largeVertical({this.width = 0, this.height = 30});

  TheSizedBox.normalVertical({this.width = 0, this.height = 25});

  TheSizedBox.smallVertical({this.width = 0, this.height = 20});

  TheSizedBox.extraSmallVertical({this.width = 0, this.height = 15});

  TheSizedBox.ultraSmallVertical({this.width = 0, this.height = 5});

  TheSizedBox.bloodySmallVertical({this.width = 0, this.height = 3});

  TheSizedBox.bloodyLargeHorizontal({this.width = 55, this.height = 0});

  TheSizedBox.ultraLargeHorizontal({this.width = 45, this.height = 0});

  TheSizedBox.extraLargeHorizontal({this.width = 35, this.height = 0});

  TheSizedBox.largeHorizontal({this.width = 30, this.height = 0});

  TheSizedBox.normalHorizontal({this.width = 25, this.height = 0});

  TheSizedBox.smallHorizontal({this.width = 25, this.height = 0});

  TheSizedBox.extraSmallHorizontal({this.width = 15, this.height = 0});

  TheSizedBox.ultraSmallHorizontal({this.width = 5, this.height = 0});

  TheSizedBox.bloodySmallHorizontal({this.width = 3, this.height = 0});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 0,
      height: height ?? 0,
    );
  }
}
