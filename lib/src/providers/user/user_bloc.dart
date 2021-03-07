import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_challange/src/models/user/user_model.dart';
import 'package:flutter_challange/src/services/user_service.dart';
import 'package:flutter_challange/src/widgets/the_loader.dart';
import 'package:http/http.dart' as http;

import '../../helpers/preferences_base.dart';
import '../../helpers/preferences_base.dart';
import '../../helpers/preferences_base.dart';

class UserBloc extends ChangeNotifier {
  BuildContext _context;

  CustomLoader loader = CustomLoader();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  final _repository = UserService();
  List<UserModel> _user;
  List<UserModel> get listUser => _user;
  set listUser(List<UserModel> val) {
    _user = val;
    notifyListeners();
  }

  int userId;

  UserBloc() {
    fecthData();
  }

  didMount(context) async {
    _context = context;
    // PreferencesHelper.removeAll();
  }

  getToken() async {
    final test = await Prefs.token;
    print('JWT TOKEN ==> $test');
  }

  fecthData() async {
    final response = await _repository.fecthData();
    listUser = response;
    return listUser;
  }
}
