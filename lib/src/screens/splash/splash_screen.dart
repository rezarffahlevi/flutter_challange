import 'package:flutter/material.dart';
import 'package:flutter_challange/src/constants/the_colors.dart';
import 'package:flutter_challange/src/constants/the_text_style.dart';
import 'package:flutter_challange/src/providers/splash/splash_bloc.dart';
import 'package:flutter_challange/src/providers/user/user_bloc.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    final SplashBloc bloc = Provider.of<SplashBloc>(context);
    bloc.didMount(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.green,
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                TheColors.primary.withOpacity(0.3),
                TheColors.background
              ]),
//              colors: [Color(0xFF307ADB).withOpacity(0.3), Color(0xFF8F79D4)]),
        ),
        child: Center(
          child: Text(
            'Mo-Ring',
            style: TheTextStyle.h2,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
