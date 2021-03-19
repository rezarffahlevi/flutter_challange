import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_challange/src/constants/the_colors.dart';
import 'package:flutter_challange/src/constants/the_font_weight.dart';
import 'package:flutter_challange/src/constants/the_text_style.dart';
import 'package:flutter_challange/src/constants/the_theme.dart';
import 'package:flutter_challange/src/helpers/helpers.dart';
import 'package:flutter_challange/src/helpers/validators.dart';
import 'package:flutter_challange/src/providers/feed/feed_bloc.dart';
import 'package:flutter_challange/src/providers/gathering/gathering_bloc.dart';
import 'package:flutter_challange/src/providers/gathering/member_list_bloc.dart';
import 'package:flutter_challange/src/providers/gathering/shake_bloc.dart';
import 'package:flutter_challange/src/providers/home/home_root_bloc.dart';
import 'package:flutter_challange/src/widgets/custom_widget.dart';
import 'package:flutter_challange/src/widgets/the_carousel_slider.dart';
import 'package:flutter_challange/src/widgets/the_rounded_button.dart';
import 'package:flutter_challange/src/widgets/the_sized_box.dart';
import 'package:provider/provider.dart';
import 'package:flutter_challange/src/providers/auth/login_bloc.dart';
import 'package:shake/shake.dart';

class ShakeScreen extends StatelessWidget {
  static const String routeName = '/shake';

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<ShakeBloc>(context);
    bloc.didMount(context);
    final dimension = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: TheColors.background,
      key: bloc.scaffoldKey,
      appBar: null,
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: Container(
        margin: EdgeInsets.only(top: 10),
        child: ClipOval(
          child: InkWell(
            onTap: bloc.backClicked,
            splashColor: TheColors.blue,
            child: Container(
              color: TheColors.primary,
              padding: EdgeInsets.all(15),
              child: Icon(
                Icons.arrow_back_ios_outlined,
                color: TheColors.textReverse,
                size: 22,
              ),
            ),
          ),
        ),
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Container(
          height: dimension.height,
          width: dimension.width,
          decoration: BoxDecoration(
            color: TheColors.yellow,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: dimension.width - 40,
                height: 140,
                decoration: BoxDecoration(
                  color: TheColors.textReverse,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: TheColors.textReverse, width: 0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      bloc.nama ?? 'GOYANGIN HP-NYA NGABS',
                      style: TheTextStyle.h1.bold,
                    ),
                    bloc.nama == null
                        ? Text(
                            "DO'A DULU BIAR MENANG!",
                            style: TheTextStyle.h1.bold,
                          )
                        : Container(),
                  ],
                ),
              ),
              ClipPath(
                clipper: TriangleClipper(),
                child: Container(
                  color: TheColors.textReverse,
                  height: 30,
                  width: 50,
                ),
              ),
              TheSizedBox.normalVertical(),
              Image.asset(
                'assets/icons/shake.png',
                fit: BoxFit.contain,
                height: dimension.height / 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0.0);
    path.lineTo(size.width / 2, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(TriangleClipper oldClipper) => false;
}
