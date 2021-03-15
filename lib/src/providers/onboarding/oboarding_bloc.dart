import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_challange/src/helpers/validators.dart';
import 'package:flutter_challange/src/screens/auth/login_screen.dart';
import 'package:flutter_challange/src/screens/user/profile_screen.dart';

import '../../helpers/preferences_base.dart';

class OnboardingBloc extends ChangeNotifier {
  BuildContext _context;
  OnboardingBloc() {}

  didMount(context) {
    _context = context;
  }

  redirectWelcome() async {
    await Prefs.setHasInit(true);
    Navigator.pushReplacementNamed(_context, LoginScreen.routeName);
  }

  getSomething() async {
    bool isLogin = !Validators.isNull(await Prefs.token);
    Timer(Duration(seconds: 2), () {
      if (isLogin)
        Navigator.pushReplacementNamed(_context, ProfileScreen.routeName);
      else
        Navigator.pushReplacementNamed(_context, LoginScreen.routeName);
    });
  }
}
