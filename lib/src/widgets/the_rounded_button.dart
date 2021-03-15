import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_challange/src/constants/the_colors.dart';
import 'package:flutter_challange/src/constants/the_font_weight.dart';
import 'package:flutter_challange/src/constants/the_theme.dart';
import 'package:flutter_challange/src/widgets/extensions.dart';

class TheRoundedButtonDisable extends StatelessWidget {
  final String title;

  TheRoundedButtonDisable(this.title);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: null,
      child: Text(title),
      textColor: Colors.white,
      disabledTextColor: Colors.white,
      color: TheColors.buttonEnabled,
      disabledColor: TheColors.buttonDisabled,
      padding: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100.0),
      ),
    );
  }
}

class TheRoundedButton extends StatelessWidget {
  final String title;
  final Function onPressed;

  TheRoundedButton({this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ElevatedButton.styleFrom(
          primary: TheColors.buttonEnabled,
          onSurface: TheColors.buttonDisabled,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
      onPressed: onPressed,
      child: Text(title, style: TextStyle(color: TheColors.white)),
    );
  }
}
