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
import 'package:flutter_challange/src/providers/home/home_root_bloc.dart';
import 'package:flutter_challange/src/widgets/custom_widget.dart';
import 'package:flutter_challange/src/widgets/the_carousel_slider.dart';
import 'package:flutter_challange/src/widgets/the_rounded_button.dart';
import 'package:flutter_challange/src/widgets/the_sized_box.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
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
              appBar(),
            ],
          ),
        )),
      ),
    );
  }

  Widget _body(BuildContext context, FeedBloc bloc) {
    final dimension = MediaQuery.of(context).size;
    return ListView(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hai,",
                  ),
                  Text(
                    "Feby Putri Fahlevi",
                    style: TheTextStyle.contentTitle,
                  ),
                ],
              ),
              InkWell(
                child: Container(
                  padding: const EdgeInsets.all(5.0),
                  child: Icon(
                    Icons.wallet_giftcard,
                    color: TheColors.text,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: TheColors.text, width: 1)),
                ),
                onTap: () {},
              ),
            ],
          ),
        ),
        // _info(context),
        // _promo(context),
        Container(
          color: TheColors.white,
          padding: const EdgeInsets.only(top: 20, bottom: 50),
          constraints: BoxConstraints(
              minHeight: dimension.height, minWidth: double.infinity),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _categoryWidget('Arisan', onTapAll: bloc.allGatherClicked),
              _categoryGatheringWidget(bloc),
              TheSizedBox.extraSmallVertical(),
              _categoryWidget('Anggota (16)', onTapAll: bloc.allMemberCicked),
              _memberWidget(context, height: 60.0),
              TheSizedBox.extraSmallVertical(),
              _categoryWidget('Detail', showAll: false),
              _detailWidget(context),
              TheSizedBox.extraSmallVertical(),
              _calendarWidget(context, bloc),
              TheSizedBox.extraSmallVertical(),
              _pemenangWidget(context, bloc),
            ],
          ),
        ),
      ],
    );
  }

  Widget _promoWidget(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
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

  Widget _infoWidget(BuildContext context) {
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

  Widget _categoryGatheringWidget(FeedBloc bloc) {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 10),
      height: 40,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              margin: const EdgeInsets.only(right: 15),
              child: Icon(Icons.group_add_rounded),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(color: TheColors.text, width: 1)),
            ),
            onTap: () {},
          ),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: bloc.listCategory.length,
                itemBuilder: (context, index) {
                  var data = bloc.listCategory[index];
                  return InkWell(
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: data == bloc.selectedCategory
                                    ? TheColors.primary
                                    : TheColors.greyPlaceHolder,
                                width: 1.4)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 2),
                        margin: const EdgeInsets.only(right: 10),
                        child: Text(data),
                      ),
                      onTap: () {
                        bloc.setSelectedCategory(data);
                      });
                }),
          ),
        ],
      ),
    );
  }

  Widget _memberWidget(BuildContext context, {type: 'all', height: 30.0}) {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 10),
      height: height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          type == 'all'
              ? InkWell(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: height / 3),
                    margin: const EdgeInsets.only(right: 15),
                    child: Icon(
                      Icons.person_add,
                      size: height / 3,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(height / 8.5),
                        border: Border.all(color: TheColors.text, width: 1)),
                  ),
                  onTap: () {},
                )
              : Container(),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return InkWell(
                    child: Container(
                      margin: const EdgeInsets.only(right: 15),
                      width: height + 5,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/user.png'),
                              fit: BoxFit.fitWidth),
                          borderRadius: BorderRadius.circular(height / 10),
                          border: Border.all(color: TheColors.white, width: 0)),
                    ),
                    onTap: () {},
                  );
                }),
          ),
        ],
      ),
    );
  }

  Widget _detailWidget(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 15, right: 15, top: 10),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        decoration: BoxDecoration(
            color: TheColors.pink,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: TheColors.white, width: 1)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                          color: TheColors.yellow,
                          border: Border.all(width: 1, color: TheColors.yellow),
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    Text(
                      'Saldo Arisan',
                      style: TextStyle(color: TheColors.white),
                    ),
                  ],
                ),
                InkWell(
                  child: Container(
                    margin: const EdgeInsets.only(right: 0),
                    child: Icon(
                      Icons.menu,
                      color: TheColors.white,
                    ),
                  ),
                  onTap: () {},
                ),
              ],
            ),
            Text(
              'Rp. 16.000.000',
              style: TextStyle(
                  color: TheColors.white,
                  fontSize: 26,
                  fontWeight: TheFontWeight.bold),
            ),
            TheSizedBox.bloodySmallVertical(),
            Text(
              'dari 5 kali arisan',
              style: TextStyle(
                  color: TheColors.white,
                  fontSize: 14,
                  fontWeight: TheFontWeight.normal),
            ),
            TheSizedBox.bloodySmallVertical(),
            Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                      color: TheColors.yellow,
                      border: Border.all(width: 1, color: TheColors.yellow),
                      borderRadius: BorderRadius.circular(5)),
                ),
                Text(
                  'Udah arisan ke (12/16)',
                  style: TextStyle(color: TheColors.white),
                ),
              ],
            ),
            TheSizedBox.ultraSmallVertical(),
            _memberWidget(context, type: 'paid', height: 30.0)
          ],
        ));
  }

  Widget _calendarWidget(BuildContext context, FeedBloc bloc) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(
          color: TheColors.backdrop,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: TheColors.white, width: 1)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                        color: TheColors.yellow,
                        border: Border.all(width: 1, color: TheColors.yellow),
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  Text(
                    'Tanggal Arisan',
                    style: TextStyle(color: TheColors.white),
                  ),
                ],
              ),
              TheSizedBox.bloodySmallVertical(),
              InkWell(
                child: Container(
                  margin: const EdgeInsets.only(right: 0),
                  child: Icon(
                    Icons.menu,
                    color: TheColors.white,
                  ),
                ),
                onTap: () {},
              ),
            ],
          ),
          Text(
            DateFormat('dd MMM yyyy – kk:mm').format(bloc.arisanDate),
            style: TextStyle(
                color: TheColors.white,
                fontSize: 26,
                fontWeight: TheFontWeight.bold),
          ),
          TheSizedBox.ultraSmallVertical(),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextButton(
                  onPressed: bloc.datePickerClicked,
                  child: Text(
                    DateFormat('MMM\nyyyy').format(bloc.selectedDate),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: TheColors.textReverse,
                      fontSize: 21,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: CalendarCarousel<Event>(
                  onDayPressed: (DateTime date, List<Event> events) {
                    // print('onDayPressed $date');
                    bloc.setSelectedDate(date);
                  },
                  onCalendarChanged: (DateTime date) {
                    // print('onCalendarChanged $date');
                    bloc.setSelectedDate(date);
                  },
                  daysTextStyle: TextStyle(color: TheColors.textReverse),
                  weekendTextStyle: TextStyle(
                    color: Colors.red,
                  ),
                  thisMonthDayBorderColor: Colors.grey,
                  showHeader: false,
                  customDayBuilder: (
                    /// you can provide your own build function to make custom day containers
                    bool isSelectable,
                    int index,
                    bool isSelectedDay,
                    bool isToday,
                    bool isPrevMonthDay,
                    TextStyle textStyle,
                    bool isNextMonthDay,
                    bool isThisMonthDay,
                    DateTime day,
                  ) {
                    var arisanDate = bloc.arisanDate;
                    if (day.day == arisanDate.day &&
                        day.month == arisanDate.month &&
                        day.year == arisanDate.year) {
                      return Center(
                        child: Icon(
                          Icons.alarm,
                          color: TheColors.yellow,
                        ),
                      );
                    } else {
                      return null;
                    }
                  },
                  weekFormat: false,
                  markedDatesMap: null,
                  height: 220.0,
                  // selectedDateTime: bloc.selectedDate,
                  targetDateTime: bloc.selectedDate,
                  daysHaveCircularBorder: null,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _pemenangWidget(BuildContext context, FeedBloc bloc) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        decoration: BoxDecoration(
            color: TheColors.backdrop,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: TheColors.white, width: 1)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                      color: TheColors.green,
                      border: Border.all(width: 1, color: TheColors.green),
                      borderRadius: BorderRadius.circular(5)),
                ),
                Text(
                  'Pemenang Arisan',
                  style: TextStyle(color: TheColors.white),
                ),
              ],
            ),
            TheSizedBox.bloodySmallVertical(),
            Text(
              DateFormat('dd MMMM yyyy').format(bloc.arisanDate),
              style: TextStyle(
                color: TheColors.greyLight,
              ),
            ),
            TheSizedBox.extraSmallVertical(),
            Row(
              children: [
                InkWell(
                  child: Container(
                    margin: const EdgeInsets.only(right: 15),
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
                        "Selamat,",
                        style: TextStyle(
                          color: TheColors.textReverse,
                          fontWeight: TheFontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "Dustin Ilham",
                        style: TextStyle(
                          color: TheColors.pink,
                          fontWeight: TheFontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ));
  }

  Widget _categoryWidget(text, {showAll = true, Function onTapAll}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(text,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          showAll
              ? TextButton(
                  onPressed: onTapAll,
                  child: Text(
                    "Lihat semua",
                    style: TextStyle(color: TheColors.primary),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
