import 'package:flutter_challange/src/helpers/api_helpers.dart';
import 'package:flutter_challange/src/models/auth/login_model.dart';
import 'package:flutter_challange/src/constants/constant.dart';
import 'package:flutter_challange/src/models/auth/register_model.dart';

import '../models/auth/login_model.dart';

class AuthService {
  ApiHelper apiProvider = ApiHelper();

  Future<LoginResponseModel> postLogin(LoginModel param) async {
    final params = param.toJson();
    final response = await apiProvider.post('/api/auth/login',
        params: params, baseUrl: CONSTANT.KEY_BASE_URL);
    final result = LoginResponseModel.fromJson(response);
    return result;
  }

  Future<LoginResponseModel> postRegister(RegisterModel param) async {
    final params = param.toJson();
    final response = await apiProvider.post('/api/auth/signup',
        params: params, baseUrl: CONSTANT.KEY_BASE_URL);
    final result = LoginResponseModel.fromJson(response);
    return result;
  }
}
