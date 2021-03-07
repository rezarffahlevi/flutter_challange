import 'package:flutter/material.dart';
import 'package:flutter_challange/src/constants/the_colors.dart';
import 'package:flutter_challange/src/widgets/the_sized_box.dart';

class TheBottomSheetRuler extends StatelessWidget {
  Widget ruler(double width) {
    return Center(
      child: Container(
        width: width,
        height: 5,
        decoration: BoxDecoration(
          color: TheColors.grey,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ruler(60),
        TheSizedBox.bloodySmallVertical(),
        ruler(40),
        TheSizedBox.extraSmallVertical(),
      ],
    );
  }
}
