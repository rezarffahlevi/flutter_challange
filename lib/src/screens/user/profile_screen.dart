import 'package:flutter/material.dart';
import 'package:flutter_challange/src/constants/the_colors.dart';
import 'package:flutter_challange/src/models/user/user_model.dart';
import 'package:flutter_challange/src/providers/user/user_bloc.dart';
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
      body: Container(
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: TheColors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5.0,
                  spreadRadius: 1.0,
                  offset: Offset(2.0, 2.0)),
            ]),
      ),
    );
  }
}
