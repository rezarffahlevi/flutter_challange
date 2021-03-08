import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_challange/src/models/user/user_model.dart';
import 'package:flutter_challange/src/screens/auth/login_screen.dart';
import 'package:flutter_challange/src/services/user_service.dart';
import 'package:flutter_challange/src/widgets/custom_widget.dart';
import 'package:flutter_challange/src/widgets/the_loader.dart';
import 'package:http/http.dart' as http;

import '../../helpers/preferences_base.dart';
import '../../helpers/preferences_base.dart';
import '../../helpers/preferences_base.dart';

class UserBloc extends ChangeNotifier {
  BuildContext _context;

  CustomLoader loader = CustomLoader();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  final _repository = UserService();
  UserModel _user = UserModel();
  UserModel get user => _user;
  set setUser(UserModel val) {
    _user = val;
    notifyListeners();
  }

  UserBloc() {
    fecthData();
    // getToken();
  }

  didMount(context) {
    _context = context;
  }

  getToken() async {
    final test = await Prefs.token;
    print('JWT TOKEN ==> $test');
  }

  fecthData() async {
    final response = await _repository.fecthData();
    if (response.status) {
      setUser = response.data;
    } else {
      customSnackBar(scaffoldKey, response.message,
          backgroundColor: Colors.redAccent);
      Timer(Duration(seconds: 2), () {
        logout();
      });
    }
    return user;
  }

  logout() async {
    PreferencesHelper.removeAll();
    Navigator.pushReplacementNamed(_context, LoginScreen.routeName);
  }
}
