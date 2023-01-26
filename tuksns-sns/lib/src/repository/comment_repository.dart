import 'dart:io';

import 'package:get/get.dart';
import 'package:sns_flutter/src/controller/user_controller.dart';

import '../shared/global.dart';

class CommentRepository extends GetConnect {
  final userController = Get.put(UserController());
  @override
  void onInit() {
    // TODO: implement onInit
    allowAutoSignedCert = true;
    httpClient.baseUrl = Global.API_ROOT;
    httpClient.addRequestModifier<void>((request) {
      request.headers['Accept'] = 'application/json';
      return request;
    });
    super.onInit();
  }

  Future<List?> commentIndex() async {
    String? token = await userController.getToken();
    if (token == null) return null;
    Response response = await get(
      "/api/feed",
      headers: {'token': token},
    );
    if (response.statusCode == 401) {
      //로그인실패시 서버에서 401에러를 보내주어야 함
      return null;
    }
    return response.body;
  }

  Future<Map?> commentCreate(String content, int id, int type) async {
    Response response = await post(
      "/api/feed/$type/$id/comment",
      {'content': content},
      headers: {'token': await userController.getToken()},
    );
    return (response.statusCode == 200) ? response.body : null;
  }

  Future<Map?> commentUpdate(int id, String content) async {
    // Response response = await put(
    //   "/api/feed/$type/$id/comment/$comment_id",
    //   {'content': content},
    //   headers: {'token': await userController.getToken()},
    // );
    // return (response.statusCode == 200) ? response.body : null;
  }

  Future<Map?> commentDelete(int id) async {
    Response response = await delete(
      "/api/feed/$id",
      headers: {'token': await userController.getToken()},
    );
    return (response.statusCode == 200) ? response.body : null;
  }

  Future<Map?> commentShow(int id) async {
    Response response = await get(
      "/api/feed/$id",
      headers: {'token': await userController.getToken()},
    );
    return (response.statusCode == 200) ? response.body : null;
  }
}
