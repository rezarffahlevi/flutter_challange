import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_challange/src/helpers/helpers.dart';
import 'package:flutter_challange/src/screens/feed/feed_screen.dart';
import 'package:flutter_challange/src/screens/user/profile_screen.dart';
import 'package:flutter_challange/src/widgets/the_loader.dart';
import 'package:provider/provider.dart';

class MemberListBloc extends ChangeNotifier {
  BuildContext _context;

  CustomLoader loader = CustomLoader();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  setSelectedIndex(int val) {
    _selectedIndex = val;
    notifyListeners();
  }

  MemberListBloc() {}

  didMount(context) {
    _context = context;
  }

  memberClicked() {
    Navigator.of(_context).pushNamed(ProfileScreen.routeName);
  }
}
