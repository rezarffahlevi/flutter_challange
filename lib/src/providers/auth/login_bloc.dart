import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_challange/src/screens/user/profile_screen.dart';
import 'package:flutter_challange/src/widgets/the_loader.dart';

class LoginBloc extends ChangeNotifier {
  BuildContext _context;

  CustomLoader loader = CustomLoader();

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

  onSubmit() {
    print('_email => $_email; _password => $_password;');

    loader.showLoader(_context);
    Timer(Duration(seconds: 1), () {
      loader.hideLoader();
      // Navigator.pushReplacementNamed(_context, ProfileScreen.routeName);
    });
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
