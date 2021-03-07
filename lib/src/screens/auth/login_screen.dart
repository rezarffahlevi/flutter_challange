import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_challange/src/constants/the_colors.dart';
import 'package:flutter_challange/src/constants/the_font_weight.dart';
import 'package:flutter_challange/src/constants/the_theme.dart';
import 'package:flutter_challange/src/helpers/helpers.dart';
import 'package:flutter_challange/src/helpers/validators.dart';
import 'package:flutter_challange/src/widgets/the_rounded_button.dart';
import 'package:flutter_challange/src/widgets/the_sized_box.dart';
import 'package:provider/provider.dart';
import 'package:flutter_challange/src/providers/auth/login_bloc.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = '/login';

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<LoginBloc>(context);
    bloc.didMount(context);

    final dimension = MediaQuery.of(context).size;

    Widget _entryField(String hint,
        {TextEditingController controller, bool isPassword = false}) {
      return Center(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(30),
          ),
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.normal,
            ),
            obscureText: isPassword,
            decoration: InputDecoration(
              hintText: hint,
              border: InputBorder.none,
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  borderSide: BorderSide(color: Colors.blue)),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            ),
          ),
        ),
      );
    }

    Widget _labelButton(String title, {Function onPressed}) {
      return Container(
          alignment: Alignment.bottomRight,
          margin: EdgeInsets.only(right: 10),
          child: new RichText(
            text: new TextSpan(
              children: [
                new TextSpan(
                  text: 'Belum punya akun? ',
                  style: new TextStyle(color: Colors.black),
                ),
                new TextSpan(
                  text: 'Klik disini',
                  style: new TextStyle(color: TheColors.link),
                  recognizer: new TapGestureRecognizer()
                    ..onTap = () {
                      onPressed();
                    },
                ),
              ],
            ),
          ));
    }

    Widget _emailLoginButton(BuildContext context) {
      return Container(
        width: dimension.width,
        // margin: EdgeInsets.symmetric(horizontal: 35),
        child: TheRoundedButton(
            'Masuk',
            Validators.isNull(bloc.email) || Validators.isNull(bloc.password)
                ? null
                : bloc.onSubmit),
      );
    }

    Widget _googleLoginButton(BuildContext context) {
      return Container(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: Colors.white,
                onPressed: () {},
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Row(
                  children: <Widget>[
                    Image.asset(
                      'assets/images/google_logo.png',
                      height: 20,
                      width: 20,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Lanjutkan dengan Google',
                    ),
                  ],
                )),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: TheColors.background,
      key: bloc.scaffoldKey,
      appBar: null,
//    ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: SafeArea(
          child: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);

              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [
                  Color(0xfffbfbfb),
                  Color(0xfff7f7f7),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )),
              child: Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[],
                  ),
                  // _detailWidget()
                  // _body(context),
                  Positioned(
                    top: 30,
                    left: 0,
                    right: 0,
                    child: Image.asset(
                      'assets/images/login.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                  Positioned(
                    top: dimension.height / 8,
                    left: dimension.width / 10,
                    child: Text(
                      'Flutter\nChallange\nReza Fahlevi',
                      maxLines: 3,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontFamily: 'arial',
                          fontWeight: TheFontWeight.bold,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                  DraggableScrollableSheet(
                      maxChildSize: .8,
                      initialChildSize: .5,
                      minChildSize: .5,
                      builder: (context, scrollController) {
                        return Container(
                          padding: TheTheme.padding.copyWith(bottom: 0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                            ),
                            color: TheColors.blue,
                          ),
                          child: SingleChildScrollView(
                            controller: scrollController,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                _entryField('Email kamu',
                                    controller: bloc.emailController),
                                _entryField('Password kamu',
                                    controller: bloc.passwordController,
                                    isPassword: true),
                                TheSizedBox.bloodySmallVertical(),
                                _labelButton('Belum punya akun? Daftar di sini',
                                    onPressed: () {
                                  Navigator.of(context).pushNamed('/register');
                                }),
                                TheSizedBox.normalVertical(),
                                _emailLoginButton(context),
                                TheSizedBox.normalVertical(),
                                Divider(),
                                // _googleLoginButton(context),
                                SizedBox(height: 100),
                              ],
                            ),
                          ),
                        );
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
