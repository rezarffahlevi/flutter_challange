import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_challange/src/helpers/helpers.dart';
import 'package:flutter_challange/src/providers/home/home_root_bloc.dart';
import 'package:flutter_challange/src/screens/feed/feed_screen.dart';
import 'package:flutter_challange/src/screens/gathering/member_list_screen.dart';
import 'package:flutter_challange/src/screens/notification/notification_screen.dart';
import 'package:flutter_challange/src/screens/user/profile_screen.dart';
import 'package:flutter_challange/src/widgets/the_loader.dart';
import 'package:provider/provider.dart';

class FeedBloc extends ChangeNotifier {
  BuildContext _context;
  HomeRootBloc rootBloc;

  CustomLoader loader = CustomLoader();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  List<String> _listCategory = List<String>();
  List<String> get listCategory => _listCategory;
  setListCategory(List<String> val) {
    _listCategory = val;
    notifyListeners();
  }

  String _selectedCategory = 'Keluarga';
  String get selectedCategory => _selectedCategory;
  setSelectedCategory(String val) {
    _selectedCategory = val;
    notifyListeners();
  }

  DateTime _arisanDate = DateTime.now();
  DateTime get arisanDate => _arisanDate;
  setArisanDate(DateTime val) {
    _arisanDate = val;
    notifyListeners();
  }

  DateTime _selectedDate = DateTime.now();
  DateTime get selectedDate => _selectedDate;
  setSelectedDate(DateTime val) {
    _selectedDate = val;
    notifyListeners();
  }

  FeedBloc() {
    setListCategory(['Keluarga', 'Alumni 13 Depok', 'Kantor', 'RT 05']);
    setArisanDate(DateTime(2021, 03, 01, 10, 00, 00));
  }

  didMount(context) {
    _context = context;
    rootBloc = Provider.of<HomeRootBloc>(context);
  }

  allGatherClicked() {
    rootBloc.setSelectedIndex(1);
  }

  allMemberCicked() {
    // rootBloc.setSelectedIndex(1);
    Navigator.of(_context).pushNamed(MemberListScreen.routeName);
  }

  datePickerClicked() {
    Helpers.dismissKeyboard(_context);
    Helpers.showDatePicker(_context, 'Tanggal', (value) {
      setSelectedDate(value);
    }, defaultDateTime: _selectedDate);
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
