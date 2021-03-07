import 'package:flutter/foundation.dart';
import 'package:flutter_challange/src/models/user/user_model.dart';
import 'package:flutter_challange/src/services/user_service.dart';
import 'package:http/http.dart' as http;

class UserBloc extends ChangeNotifier {
  //Prototype get list data from json
  List<UserModel> _user;
  List<UserModel> get listUser => _user;
  final _repository = UserService();
  set listUser(List<UserModel> val) {
    _user = val;
    notifyListeners();
  }

  int userId;

  //Connection to api webservice database
  Future<List<UserModel>> fecthData() async {
    final response = await _repository.fecthData();
    listUser = response;
    return listUser;
  }
}
