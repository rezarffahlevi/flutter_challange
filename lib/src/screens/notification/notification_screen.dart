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
import 'package:flutter_challange/src/providers/home/home_root_bloc.dart';
import 'package:flutter_challange/src/providers/notification/notification_bloc.dart';
import 'package:flutter_challange/src/widgets/custom_widget.dart';
import 'package:flutter_challange/src/widgets/the_carousel_slider.dart';
import 'package:flutter_challange/src/widgets/the_rounded_button.dart';
import 'package:flutter_challange/src/widgets/the_sized_box.dart';
import 'package:provider/provider.dart';
import 'package:flutter_challange/src/providers/auth/login_bloc.dart';

class NotificationScreen extends StatelessWidget {
  static const String routeName = '/notification';

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<NotificationBloc>(context);
    bloc.didMount(context);
    final dimension = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: TheColors.background,
      key: bloc.scaffoldKey,
      appBar: null,
//    ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: SafeArea(
            child: Container(
          height: dimension.height,
          child: Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 60),
                child: RefreshIndicator(
                  onRefresh: () async {
                    return false;
                  },
                  child: SingleChildScrollView(
                    child: _listBody(context),
                  ),
                ),
              ),
              appBar(),
              Positioned(
                left: 0,
                right: 0,
                top: 25,
                child: Text(
                  "Notifikasi",
                  textAlign: TextAlign.center,
                  style: TheTextStyle.contentTitle,
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }

  Widget _listBody(BuildContext context) {
    final dimension = MediaQuery.of(context).size;
    return ListView(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      children: [
        Container(
          color: TheColors.white,
          padding: const EdgeInsets.only(top: 0, bottom: 0),
          constraints: BoxConstraints(
              minHeight: dimension.height, minWidth: double.infinity),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              for (int i = 0; i < 12; i++) _listNotifWidget(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _listNotifWidget(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 12),
        decoration: BoxDecoration(
            // color: TheColors.greyPlaceHolder,
            border: Border.all(color: TheColors.greyLight, width: 1)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  child: Container(
                    margin: const EdgeInsets.only(right: 15, top: 5),
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/user.png'),
                            fit: BoxFit.fitWidth),
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: TheColors.white, width: 0)),
                  ),
                  onTap: () {},
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Arisan Keluarga",
                        style: TextStyle(
                          color: TheColors.text,
                          fontWeight: TheFontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        "Dustin Ilham menambahkan member baru Dustin Ilham menambahkan member baru Dustin Ilham menambahkan member baru Dustin Ilham menambahkan member baru",
                        style: TextStyle(
                          color: TheColors.text,
                          fontWeight: TheFontWeight.normal,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ));
  }
}
