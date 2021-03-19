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
import 'package:flutter_challange/src/widgets/custom_widget.dart';
import 'package:flutter_challange/src/widgets/the_carousel_slider.dart';
import 'package:flutter_challange/src/widgets/the_rounded_button.dart';
import 'package:flutter_challange/src/widgets/the_sized_box.dart';
import 'package:provider/provider.dart';
import 'package:flutter_challange/src/providers/auth/login_bloc.dart';

class GatheringScreen extends StatelessWidget {
  static const String routeName = '/gathering';

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<GatheringBloc>(context);
    bloc.didMount(context);
    final dimension = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: TheColors.background,
      // key: bloc.scaffoldKey,
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
                    child: _body(context, bloc),
                  ),
                ),
              ),
              appBar(onTap: () {}, icon: Icons.group_add),
              Positioned(
                left: 0,
                right: 0,
                top: 25,
                child: Text(
                  "Arisan",
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

  Widget _body(BuildContext context, GatheringBloc bloc) {
    final dimension = MediaQuery.of(context).size;
    return ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 10),
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: 13,
        itemBuilder: (context, index) {
          return _arisanWidget(context, bloc);
        });
  }

  Widget _arisanWidget(BuildContext context, GatheringBloc bloc) {
    return InkWell(
      onTap: bloc.arisanClicked,
      child: Container(
          // margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 12),
          decoration: BoxDecoration(
              color: TheColors.white,
              borderRadius: BorderRadius.circular(0),
              border: Border.all(color: TheColors.greyPlaceHolder, width: 1)),
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
                          "Admin : Dustin Ilham",
                          style: TextStyle(
                            color: TheColors.text,
                            fontWeight: TheFontWeight.normal,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "19 Anggota",
                          style: TextStyle(
                            color: TheColors.text,
                            fontWeight: TheFontWeight.normal,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 50,
                      height: 60,
                      child: Icon(
                        Icons.keyboard_arrow_right,
                        size: 30,
                      ),
                    ),
                  )
                ],
              ),
            ],
          )),
    );
  }
}
