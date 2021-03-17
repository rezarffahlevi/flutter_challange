import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_challange/src/screens/home/home_root_screen.dart';
import 'package:flutter_challange/src/screens/user/profile_screen.dart';
import 'package:flutter_challange/src/widgets/custom_widget.dart';
import 'package:flutter_challange/src/widgets/the_loader.dart';
import 'package:flutter_challange/src/services/auth_sevice.dart';
import 'package:flutter_challange/src/models/auth/login_model.dart';

import '../../helpers/preferences_base.dart';
import '../../models/auth/login_model.dart';

class LoginBloc extends ChangeNotifier {
  BuildContext _context;

  CustomLoader loader = CustomLoader();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  final _repository = AuthService();
  LoginResponseModel _auth;
  LoginModel loginModel = LoginModel();

  final emailController = TextEditingController();
  String _email;
  String get email => _email;
  setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  final passwordController = TextEditingController();
  String _password;
  String get password => _password;
  setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  LoginBloc() {
    emailController.addListener(() {
      setEmail(emailController.text);
    });
    passwordController.addListener(() {
      setPassword(passwordController.text);
    });
  }

  didMount(context) {
    _context = context;
  }

  onSubmit() async {
    try {
      loader.showLoader(_context);
      loginModel.email = _email;
      loginModel.password = _password;

      final response = await _repository.postLogin(loginModel);
      _auth = response;
      loader.hideLoader();
      if (_auth.status) {
        await Prefs.setAuth(loginModel);
        await Prefs.setToken(_auth.token);
        Navigator.pushReplacementNamed(_context, HomeRootScreen.routeName);
      } else {
        customSnackBar(scaffoldKey, _auth.message,
            backgroundColor: Colors.redAccent);
      }
    } catch (e) {
      loader.hideLoader();
      print("ERROR SUBMIT ==> $e");
      customSnackBar(scaffoldKey, 'Something went wrong!',
          backgroundColor: Colors.redAccent);
    }
  }

  clearEmailValue() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => emailController.clear());
  }

  clearPasswordValue() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => passwordController.clear());
  }
}
