import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_challange/src/helpers/helpers.dart';
import 'package:flutter_challange/src/screens/feed/feed_screen.dart';
import 'package:flutter_challange/src/widgets/the_loader.dart';
import 'package:provider/provider.dart';

class GatheringBloc extends ChangeNotifier {
  BuildContext _context;

  CustomLoader loader = CustomLoader();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  setSelectedIndex(int val) {
    _selectedIndex = val;
    notifyListeners();
  }

  GatheringBloc() {}

  didMount(context) {
    _context = context;
  }

  DateTime currentBackPressTime;

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();

    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Helpers.showToast(
          'Tekan tombol kembali sekali lagi untuk keluar aplikasi');
      return Future.value(false);
    }
    try {
      SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
    } catch (e) {}
    return Future.value(false);
  }

  final List<Widget> children = [
    // SwiggyScreen(),
    // SearchScreen(),
    // CartScreen(),
    // AccountScreen(),
  ];
}
