import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_challange/src/constants/the_colors.dart';
import 'package:flutter_challange/src/constants/the_font_weight.dart';
import 'package:flutter_challange/src/constants/the_text_style.dart';
import 'package:flutter_challange/src/helpers/validators.dart';
import 'package:flutter_challange/src/models/user/user_model.dart';
import 'package:flutter_challange/src/providers/user/user_bloc.dart';
import 'package:flutter_challange/src/widgets/custom_widget.dart';
import 'package:flutter_challange/src/widgets/the_sized_box.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  static const String routeName = '/profile';
  @override
  Widget build(BuildContext context) {
    final UserBloc bloc = Provider.of<UserBloc>(context);
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
                    child: _listBody(context, bloc),
                  ),
                ),
              ),
              appBar(),
              Positioned(
                left: 0,
                right: 0,
                top: 25,
                child: Text(
                  "Profile",
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

  Widget _listBody(BuildContext context, bloc) {
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
              _listNotifWidget(context, bloc),
            ],
          ),
        ),
      ],
    );
  }

  Widget _listNotifWidget(BuildContext context, bloc) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 12),
        decoration: BoxDecoration(
            // color: TheColors.greyPlaceHolder,
            border: Border.all(color: TheColors.white, width: 0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  child: Container(
                      width: 100.0,
                      height: 100.0,
                      margin: EdgeInsets.all(15).copyWith(right: 25),
                      decoration: BoxDecoration(
                          color: Colors.red,
                          image: DecorationImage(
                              image: NetworkImage(
                                  'https://pixel.nymag.com/imgs/daily/vulture/2017/06/14/14-tom-cruise.w700.h700.jpg'),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                          boxShadow: [
                            BoxShadow(blurRadius: 7.0, color: Colors.black)
                          ])),
                  onTap: () {},
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Kagura Layla",
                        style: TextStyle(
                          color: TheColors.text,
                          fontWeight: TheFontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        "kagura@mpl.com",
                        style: TextStyle(
                          color: TheColors.text,
                          fontWeight: TheFontWeight.normal,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: bloc.logout,
              child: Center(
                child: Text(
                  'Log out',
                  style:
                      TextStyle(color: Colors.black, fontFamily: 'Montserrat'),
                ),
              ),
            ),
          ],
        ));
  }
}
