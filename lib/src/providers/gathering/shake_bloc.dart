import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_challange/src/helpers/helpers.dart';
import 'package:flutter_challange/src/screens/feed/feed_screen.dart';
import 'package:flutter_challange/src/screens/user/profile_screen.dart';
import 'package:flutter_challange/src/widgets/the_loader.dart';
import 'package:provider/provider.dart';
import 'package:shake/shake.dart';

class ShakeBloc extends ChangeNotifier {
  BuildContext _context;
  ShakeDetector _detector;

  CustomLoader loader = CustomLoader();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  String _nama;
  String get nama => _nama;
  setNama(String val) {
    _nama = val;
    notifyListeners();
  }

  ShakeBloc() {
    _detector = ShakeDetector.autoStart(onPhoneShake: () => onShake());
  }

  onShake() {
    print('onShake');
    var listNama = ['Iwan', 'Aldi', 'Dinda', 'Dustin'];

    var interval = Timer.periodic(new Duration(milliseconds: 50), (timer) {
      Random random = new Random();
      int randomNumber = random.nextInt(listNama.length);
      // print(listNama[randomNumber]);
      setNama(listNama[randomNumber]);
    });
    Timer(const Duration(seconds: 5), () {
      interval.cancel();
    });
  }

  didMount(context) {
    _context = context;
  }

  memberClicked() {
    Navigator.of(_context).pushNamed(ProfileScreen.routeName);
  }

  backClicked() {
    Navigator.of(_context).pop();
  }

  @override
  void dispose() {
    super.dispose();
    _detector.stopListening();
  }
}
