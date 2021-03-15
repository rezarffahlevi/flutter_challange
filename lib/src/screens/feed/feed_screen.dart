import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_challange/src/constants/the_colors.dart';
import 'package:flutter_challange/src/constants/the_font_weight.dart';
import 'package:flutter_challange/src/constants/the_text_style.dart';
import 'package:flutter_challange/src/constants/the_theme.dart';
import 'package:flutter_challange/src/helpers/helpers.dart';
import 'package:flutter_challange/src/helpers/validators.dart';
import 'package:flutter_challange/src/providers/feed/feed_bloc.dart';
import 'package:flutter_challange/src/providers/home/home_root_bloc.dart';
import 'package:flutter_challange/src/widgets/the_carousel_slider.dart';
import 'package:flutter_challange/src/widgets/the_rounded_button.dart';
import 'package:flutter_challange/src/widgets/the_sized_box.dart';
import 'package:provider/provider.dart';
import 'package:flutter_challange/src/providers/auth/login_bloc.dart';

class FeedScreen extends StatelessWidget {
  static const String routeName = '/feed';

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<FeedBloc>(context);
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
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 60),
                  child: RefreshIndicator(
                    onRefresh: () async {
                      return false;
                    },
                    child: SingleChildScrollView(
                      child: _listFeed(context),
                    ),
                  ),
                ),
              ),
              _buildAppBar(context),
            ],
          ),
        )),
      ),
    );
  }

  Container _buildAppBar(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        height: 60.0,
        // color: TheColors.blue,
        child: Row(
          children: <Widget>[
            Text(
              'Narisa',
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  .copyWith(fontSize: 21.0),
            ),
            TheSizedBox.normalHorizontal(),
            Spacer(),
            InkWell(
              child: Container(
                padding: const EdgeInsets.all(5.0),
                child: Icon(Icons.supervised_user_circle_outlined),
              ),
              onTap: () {},
            ),
            TheSizedBox.normalHorizontal(),
            InkWell(
              child: Container(
                padding: const EdgeInsets.all(5.0),
                child: Icon(Icons.notifications),
              ),
              onTap: () {},
            ),
          ],
        ),
      );

  Widget _listFeed(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Hai,"),
                  Text(
                    "Annisa",
                    style: TheTextStyle.contentTitle,
                  ),
                ],
              ),
              InkWell(
                child: Container(
                  padding: const EdgeInsets.all(5.0),
                  child: Icon(Icons.wallet_giftcard),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: TheColors.primary, width: 1)),
                ),
                onTap: () {},
              ),
            ],
          ),
        ),
        _info(context),
        _promo(context),
        TheSizedBox.smallVertical(),
        Container(
          color: TheColors.white,
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _category('Arisan'),
              _categoryWidget(context),
              _category('Anggota'),
              _categoryWidget(context),
              _categoryWidget(context),
              _categoryWidget(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _promo(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      child: SizedBox(
          height: 100.0,
          width: width,
          child: CarouselSlider(
            height: MediaQuery.of(context).size.height,
            items: [
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 2),
                  width: width - 50,
                  decoration: BoxDecoration(
                      color: TheColors.blue,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: TheColors.white, width: 1)),
                  child: Center(child: Text('Banner promo 1'))),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 2),
                  width: width - 50,
                  decoration: BoxDecoration(
                      color: TheColors.primary,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: TheColors.white, width: 1)),
                  child: Center(child: Text('Banner promo 2'))),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 2),
                  width: width - 50,
                  decoration: BoxDecoration(
                      color: TheColors.link,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: TheColors.white, width: 1)),
                  child: Center(child: Text('Banner promo 3'))),
            ],
            autoPlayInterval: Duration(seconds: 4),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlay: false,
            enlargeCenterPage: true,
            aspectRatio: 1 / 1,
            viewportFraction: 1 / 1.1,
            enableInfiniteScroll: true,
            // initialPage: 1,
            onPageChanged: (index) {},
          )),
    );
  }

  Widget _info(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15, bottom: 12),
      padding: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
          color: TheColors.greyPlaceHolder,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: TheColors.white, width: 1)),
      child: Center(
        child: Text('Information'),
      ),
    );
  }

  Widget _categoryWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      height: 80,
      color: TheColors.buttonEnabled,
      child: ListView(scrollDirection: Axis.horizontal, children: []),
    );
  }

  Widget _category(text) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(text,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Text(
            "Lihat semua",
            style: TextStyle(color: TheColors.primary),
          )
        ],
      ),
    );
  }
}
