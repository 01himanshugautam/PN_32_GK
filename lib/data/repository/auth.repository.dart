import 'package:dio/dio.dart';
import 'package:gk/utils/constants/app-urls.constant.dart';


class AuthRepository {
  var dio = Dio();

  login(String username, String password) async {
    try {
      Response response = await dio.post(AppUrls.login,
          data: FormData.fromMap({'username': username, 'password': password}));
      return response;
    } catch (e) {
      return e;
    }
  }
}
