import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_challange/src/constants/the_colors.dart';
import 'package:flutter_challange/src/constants/the_text_style.dart';
import 'package:flutter_challange/src/providers/onboarding/oboarding_bloc.dart';
import 'package:flutter_challange/src/widgets/the_carousel_slider.dart';
import 'package:flutter_challange/src/widgets/the_sized_box.dart';
import 'package:provider/provider.dart';
import '../../helpers/delayed_animation.dart';

class OnboardingScreen extends StatelessWidget {
  static const String routeName = '/onboarding';
  int _current = 0;

  Widget _carouselSlider(context, bloc) {
    return Container(
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) =>
                    statefullCaroussel(context, setState, bloc)),
          ],
        ),
      ),
    );
  }

  Widget carouselItem(context, {String pic, String title, String description}) {
    final height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            height: height / 1.7,
//          width: 200,
//          padding: EdgeInsets.all(30),
//          decoration: BoxDecoration(
//            color: TheColors.primary,
//            borderRadius: BorderRadius.circular(200),
//          ),
            padding: EdgeInsets.only(bottom: 50, top: 50),
            child: Container(
              child: Image.asset(
                pic,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            margin: EdgeInsets.only(left: 15, right: 15),
            // height: height - height / 1.6,
            decoration: BoxDecoration(
                // boxShadow: [
                //   BoxShadow(
                //     color: TheColors.backdrop.withOpacity(0.3),
                //     blurRadius: 30.0, // has the effect of softening the shadow
                //     spreadRadius: 0, // has the effect of extending the shadow
                //     offset: Offset(
                //       0, // horizontal, move right 10
                //       10.0, // vertical, move down 10
                //     ),
                //   )
                // ],
                // color: TheColors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // TheSizedBox.extraLargeVertical(),
                Text(
                  title,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: TheTextStyle.contentTitle,
                ),
                TheSizedBox.smallVertical(),
                Text(
                  description,
                  maxLines: 3,
                  style: TextStyle(
                    color: TheColors.text,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  List<Widget> caroussel(context) {
    return [
      carouselItem(context,
          pic: 'assets/images/mudah.png',
          title: 'Mudah',
          description:
              'Semua ada digenggaman. Lebih mudah, praktis, dan fleksibel. #LebihMudah'),
      carouselItem(context,
          pic: 'assets/images/hemat.png',
          title: 'Rapih',
          description:
              'Semua pencatatan jadi rapih dan transparan. #LebihRapih'),
      carouselItem(context,
          pic: 'assets/images/cepat.png',
          title: 'Lengkap',
          description: 'Fitur banyak, akses mudah. #LebihEnak'),
    ];
  }

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  Widget statefullCaroussel(BuildContext context, StateSetter setState, bloc) {
    final carousellSlider = CarouselSlider(
      height: MediaQuery.of(context).size.height,
      items: caroussel(context),
      autoPlay: false,
      enlargeCenterPage: true,
      aspectRatio: 1 / 1,
      viewportFraction: 1 / 1,
      enableInfiniteScroll: false,
      onPageChanged: (index) {
        setState(() {
          _current = index;
        });
      },
    );

    return Stack(
      children: <Widget>[
        Container(
//          height: 340,
            width: MediaQuery.of(context).size.width,
            child: carousellSlider),
        Positioned(
          bottom: 50,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: map<Widget>(
              caroussel(context),
              (index, url) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      carousellSlider.jumpToPage(index);
                      carousellSlider.animateToPage(index);
                      _current = index;
                    });
                  },
                  child: Container(
                    width: 10.0,
                    height: 10.0,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _current == index
                          ? TheColors.primary
                          : Colors.transparent,
                      border: _current == index
                          ? Border.all(width: 1, color: Colors.transparent)
                          : Border.all(width: 1, color: TheColors.primary),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        if (_current >= caroussel(context).length - 1)
          Positioned(
              bottom: 35,
              right: 13,
              child: MaterialButton(
                onPressed: () {
                  if (_current >= caroussel(context).length - 1) {
                    bloc.redirectWelcome();
                  } else {
                    setState(() {
                      _current += 1;
                      carousellSlider.jumpToPage(_current);
                    });
                  }
                },
                color: TheColors.primary,
                textColor: TheColors.white,
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 24,
                ),
                padding: EdgeInsets.all(16),
                shape: CircleBorder(),
              ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<OnboardingBloc>(context);
    bloc.didMount(context);

    return Scaffold(
      backgroundColor: TheColors.background,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            color: TheColors.background,
            child: _carouselSlider(context, bloc),
          ),
        ),
      ),
    );
  }
}
