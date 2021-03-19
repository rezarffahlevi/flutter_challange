import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_challange/src/helpers/helpers.dart';
import 'package:flutter_challange/src/screens/feed/feed_screen.dart';
import 'package:flutter_challange/src/screens/gathering/detail_gathering_screen.dart';
import 'package:flutter_challange/src/screens/gathering/member_list_screen.dart';
import 'package:flutter_challange/src/screens/gathering/shake_screen.dart';
import 'package:flutter_challange/src/widgets/the_loader.dart';
import 'package:provider/provider.dart';

class DetailGatheringBloc extends ChangeNotifier {
  BuildContext _context;

  CustomLoader loader = CustomLoader();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  setSelectedIndex(int val) {
    _selectedIndex = val;
    notifyListeners();
  }

  DetailGatheringBloc() {}

  didMount(context) {
    _context = context;
  }

  memberClicked() {
    Navigator.of(_context).pushNamed(MemberListScreen.routeName);
  }

  shakeClicked() {
    Navigator.of(_context).pushNamed(ShakeScreen.routeName);
  }
}
