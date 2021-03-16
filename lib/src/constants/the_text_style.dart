import 'package:flutter/material.dart';
import '../constants/the_colors.dart';
import '../constants/the_font_weight.dart';

class TheTextStyle {
  static TheTextStyleFontWeight get h1 =>
      TheTextStyleFontWeight.custom(fontSize: 24.0);

  static TheTextStyleFontWeight get h2 =>
      TheTextStyleFontWeight.custom(fontSize: 22.0);

  static TheTextStyleFontWeight get h3 =>
      TheTextStyleFontWeight.custom(fontSize: 20.0);

  static TheTextStyleFontWeight get h4 =>
      TheTextStyleFontWeight.custom(fontSize: 18.0);

  static TheTextStyleFontWeight get h5 =>
      TheTextStyleFontWeight.custom(fontSize: 16.0);

  static TheTextStyleFontWeight get h6 =>
      TheTextStyleFontWeight.custom(fontSize: 14.0);

  static TheTextStyleFontWeight get h7 =>
      TheTextStyleFontWeight.custom(fontSize: 12.0);

  static TextStyle get contentTitle => TheTextStyle.h4.bold;

  static TextStyle get contentDescription =>
      TheTextStyle.h7.normal.copyWith(color: TheColors.text);

  static TextStyle get appBarTitle =>
      TheTextStyle.h3.normal.copyWith(color: TheColors.black);

  static TextStyle get bottomSheetTitle =>
      TheTextStyle.h2.bold.copyWith(color: TheColors.backdrop);

  static TextStyle get sessionTitle =>
      TheTextStyle.h5.semiBold.copyWith(color: TheColors.backdrop);

  static TextStyle get milestoneTitle => TextStyle(
      fontSize: 32,
      fontWeight: TheFontWeight.ultraBold,
      color: TheColors.white);

  static TextStyle get buttonTitle =>
      h4.normal.copyWith(color: TheColors.backdrop);

  static TextStyle get smallButtonTitle =>
      h6.semiBold.copyWith(color: TheColors.primary);
}

// ignore: must_be_immutable
class TheTextStyleFontWeight extends Palette {
  double fontSize;

  TheTextStyleFontWeight();

  TheTextStyleFontWeight.custom({this.fontSize});

  TextStyle get _thin => TextStyle(
        fontWeight: TheFontWeight.thin,
        color: Colors.black,
        fontSize: this.fontSize,
      );

  TextStyle get _extraLight => TextStyle(
        fontWeight: TheFontWeight.extraLight,
        color: Colors.black,
        fontSize: this.fontSize,
      );

  TextStyle get _light => TextStyle(
        fontWeight: TheFontWeight.light,
        color: Colors.black,
        fontSize: this.fontSize,
      );

  TextStyle get _normal => TextStyle(
        fontWeight: TheFontWeight.normal,
        color: Colors.black,
        fontSize: this.fontSize,
      );

  TextStyle get _medium => TextStyle(
        fontWeight: TheFontWeight.medium,
        color: Colors.black,
        fontSize: this.fontSize,
      );

  TextStyle get _semiBold => TextStyle(
        fontWeight: TheFontWeight.semiBold,
        color: Colors.black,
        fontSize: this.fontSize,
      );

  TextStyle get _bold => TextStyle(
        fontWeight: TheFontWeight.bold,
        color: Colors.black,
        fontSize: this.fontSize,
      );

  TextStyle get _extraBold => TextStyle(
        fontWeight: TheFontWeight.extraBold,
        color: Colors.black,
        fontSize: this.fontSize,
      );

  TextStyle get _ultraBold => TextStyle(
        fontWeight: TheFontWeight.ultraBold,
        color: Colors.black,
        fontSize: this.fontSize,
      );

  @override
  TextStyle get thin => _thin;

  @override
  TextStyle get extraLight => _extraLight;

  @override
  TextStyle get light => _light;

  @override
  TextStyle get normal => _normal;

  @override
  TextStyle get medium => _medium;

  @override
  TextStyle get semiBold => _semiBold;

  @override
  TextStyle get bold => _bold;

  @override
  TextStyle get extraBold => _extraBold;

  @override
  TextStyle get ultraBold => _ultraBold;

//  @override
//  TextStyle tint(Color color) => TextStyle(color: color);
}

abstract class Palette extends TextStyle {
  Palette();

  TextStyle get thin;

  TextStyle get extraLight;

  TextStyle get light;

  TextStyle get normal;

  TextStyle get medium;

  TextStyle get semiBold;

  TextStyle get bold;

  TextStyle get extraBold;

  TextStyle get ultraBold;
}
