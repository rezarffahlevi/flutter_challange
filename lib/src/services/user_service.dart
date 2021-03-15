import 'package:flutter_challange/src/helpers/api_helpers.dart';
import 'package:flutter_challange/src/models/user/user_model.dart';

class UserService {
  ApiHelper apiProvider = ApiHelper();

  Future<UserResponseModel> fecthData() async {
    final response = await apiProvider.get('/api/auth/user');
    final result = UserResponseModel.fromJson(response);
    return result;
  }
}
