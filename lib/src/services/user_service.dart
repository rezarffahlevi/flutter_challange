import 'package:flutter_challange/src/helpers/api_helpers.dart';
import 'package:flutter_challange/src/models/user/user_model.dart';
import 'package:flutter_challange/src/constants/constant.dart';

class UserService {
  ApiHelper apiProvider = ApiHelper();

  Future<List<UserModel>> fecthData() async {
    final response = await apiProvider.get('/api/biodata/akademik');
    final result = userModelFromJson(response.body);
    return result;
  }
}
