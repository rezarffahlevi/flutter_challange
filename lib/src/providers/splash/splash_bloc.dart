import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_challange/src/screens/auth/login_screen.dart';
import 'package:flutter_challange/src/screens/user/profile_screen.dart';

class SplashBloc extends ChangeNotifier {
  BuildContext _context;
  SplashBloc() {
    getSomething();
  }

  didMount(context) {
    _context = context;
  }

  getSomething() {
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(_context, LoginScreen.routeName);
    });
  }
}
