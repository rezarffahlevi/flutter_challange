import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_challange/src/screens/user/profile_screen.dart';
import 'package:flutter_challange/src/widgets/custom_widget.dart';
import 'package:flutter_challange/src/widgets/the_loader.dart';

class RegisterBloc extends ChangeNotifier {
  BuildContext _context;

  CustomLoader loader = CustomLoader();
  final formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  final namaController = TextEditingController();
  String _nama;
  String get nama => _nama;
  setNama(String nama) {
    _nama = nama;
    notifyListeners();
  }

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

  final passwordController2 = TextEditingController();
  String _password2;
  String get password2 => _password2;
  setPassword2(String password2) {
    _password2 = password2;
    notifyListeners();
  }

  RegisterBloc() {
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
      customSnackBar(scaffoldKey, 'Ga boleh daftar',
          backgroundColor: Colors.redAccent);
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
