import 'package:flutter/material.dart';
import 'package:flutter_challange/src/constants/the_colors.dart';
import 'package:flutter_challange/src/constants/the_font_weight.dart';
import 'package:flutter_challange/src/widgets/the_sized_box.dart';

class TheTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final Function(String value) onChanged;
  final Widget prefixIcon;
  final Widget suffixIcon;
  final bool obscureText;

  TheTextField(
      {this.controller,
      this.onChanged,
      this.prefixIcon,
      this.suffixIcon,
      @required this.labelText,
      @required this.hintText,
      this.keyboardType,
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          labelText,
          style: TextStyle(
            color: TheColors.grey,
            fontSize: 10,
            fontWeight: TheFontWeight.semiBold,
          ),
        ),
        TheSizedBox.ultraSmallVertical(),
        TextField(
          keyboardType: keyboardType,
          controller: controller,
          onChanged: (value) {
            onChanged(value);
          },
          obscureText: obscureText,
          decoration: InputDecoration(
            focusColor: TheColors.buttonEnabled,
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(16.0),
              ),
            ),
            filled: true,
            hintStyle: TextStyle(color: TheColors.grey),
            hintText: hintText,
            fillColor: Colors.white,
          ),
        ),
      ],
    );
  }
}
