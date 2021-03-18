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
  bool _pinned = true;
  bool _snap = false;
  bool _floating = false;

  // SliverAppBar is declared in Scaffold.body, in slivers of a
  // CustomScrollView.
  @override
  Widget build(BuildContext context) {
    final UserBloc bloc = Provider.of<UserBloc>(context);
    bloc.didMount(context);
    final dimension = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: TheColors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: _pinned,
            snap: _snap,
            floating: _floating,
            expandedHeight: 300.0,
            backgroundColor: TheColors.primary,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Nama Lo',
                style: TextStyle(
                  color: TheColors.white,
                  fontWeight: TheFontWeight.bold,
                  fontSize: 18,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://pixel.nymag.com/imgs/daily/vulture/2017/06/14/14-tom-cruise.w700.h700.jpg'),
                      fit: BoxFit.cover),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(child: _body(context, bloc)),
        ],
      ),
    );
  }

  Widget _body(BuildContext context, bloc) {
    final dimension = MediaQuery.of(context).size;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 12),
            decoration: BoxDecoration(
                // color: TheColors.greyPlaceHolder,
                border: Border.all(color: TheColors.white, width: 0)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
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
                TheSizedBox.largeVertical(),
                Text(
                  "2 Group Arisan",
                  style: TextStyle(
                    color: TheColors.text,
                    fontWeight: TheFontWeight.normal,
                    fontSize: 18,
                  ),
                ),
                TheSizedBox.largeVertical(),
                InkWell(
                  onTap: bloc.logout,
                  child: Text(
                    'Log out',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
