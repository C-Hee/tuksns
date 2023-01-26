import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sns_flutter/src/repository/user_repository.dart';

class UserController extends GetxController {
  //매번 인스턴스를 만드는 것이 아니라 이전에 만들어진 것을 불러옴
  final userRepo = Get.put(UserRepository());

  String? token;
//앱에 저장된 토큰을 가져오는 함수
  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    return (token != null) ? token : '';
  }

//회원가입
//정상동작시 true 실패시 false
  Future<String?> register(String name, String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    Map body = await userRepo.register(name, email, password);

    if (body['result'] == 'success') {
      prefs.setString('token', body['token']);
      return null;
    } else {
      return body['message'];
    }
  }

  //로그인
  Future<String?> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    Map body = await userRepo.login(email, password);
    if (body['result'] == 'success') {
      prefs.setString('token', body['token']);
      return null;
    } else {
      return body['message'];
    }
  }
}
