import 'package:flutter/material.dart';
import 'package:flutter_challange/src/constants/the_colors.dart';
import 'package:flutter_challange/src/helpers/validators.dart';
import 'package:flutter_challange/src/models/user/user_model.dart';
import 'package:flutter_challange/src/providers/user/user_bloc.dart';
import 'package:flutter_challange/src/widgets/the_sized_box.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  static const String routeName = '/profile';
  @override
  Widget build(BuildContext context) {
    final UserBloc bloc = Provider.of<UserBloc>(context);
    bloc.didMount(context);

    return Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
        ),
        key: bloc.scaffoldKey,
        body: new Scaffold(
            body: new Stack(
          children: <Widget>[
            ClipPath(
              child: Container(color: Colors.black.withOpacity(0.8)),
              clipper: GetClipper(),
            ),
            Positioned(
                width: 350.0,
                top: MediaQuery.of(context).size.height / 5,
                child: Column(
                  children: <Widget>[
                    Container(
                        width: 150.0,
                        height: 150.0,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            image: DecorationImage(
                                image: NetworkImage(
                                    'https://pixel.nymag.com/imgs/daily/vulture/2017/06/14/14-tom-cruise.w700.h700.jpg'),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.all(Radius.circular(75.0)),
                            boxShadow: [
                              BoxShadow(blurRadius: 7.0, color: Colors.black)
                            ])),
                    SizedBox(height: 90.0),
                    Text(
                      bloc.user.fullname ?? '',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TheSizedBox.ultraSmallVertical(),
                    Text(
                      bloc.user.email ?? '',
                      style: TextStyle(
                        fontSize: 17.0,
                      ),
                    ),
                    TheSizedBox.ultraSmallVertical(),
                    Text(
                      Validators.isNull(bloc.user.createAt)
                          ? ''
                          : 'Terdaftar pada :\n' +
                              DateFormat('yyyy-MM-dd – kk:mm')
                                  .format(DateTime.parse(bloc.user.createAt)),
                      style: TextStyle(
                        fontSize: 17.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    TheSizedBox.extraLargeVertical(),
                    Container(
                        height: 30.0,
                        width: 95.0,
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          shadowColor: Colors.redAccent,
                          color: Colors.red,
                          elevation: 7.0,
                          child: GestureDetector(
                            onTap: bloc.logout,
                            child: Center(
                              child: Text(
                                'Log out',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Montserrat'),
                              ),
                            ),
                          ),
                        ))
                  ],
                ))
          ],
        )));
  }
}

class GetClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height / 1.9);
    path.lineTo(size.width + 125, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
