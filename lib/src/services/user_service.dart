import 'package:flutter_challange/src/helpers/api_helpers.dart';
import 'package:flutter_challange/src/models/user/user_model.dart';

class UserService {
  ApiHelper apiProvider = ApiHelper();

  Future<List<UserModel>> fecthData() async {
    final response = await apiProvider.get('/users');
    final result = userModelFromJson(response.body);
    return result;
  }
}
