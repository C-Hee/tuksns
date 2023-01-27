import 'dart:io';

import 'package:get/get.dart';
import 'package:sns_flutter/src/controller/user_controller.dart';

import '../shared/global.dart';

class CommentRepository extends GetConnect {
  final userController = Get.put(UserController());

  @override
  void onInit() {
    allowAutoSignedCert = true;
    httpClient.baseUrl = Global.API_ROOT;
    httpClient.addRequestModifier<void>((request) {
      request.headers['Accept'] = 'application/json';
      return request;
    });
    super.onInit();
  }

  Future<List?> commentIndex(int feed_id, int type) async {
    Response response = await get(
      "/api/feed/$type/$feed_id",
      headers: {'token': await userController.getToken()},
    );
    return (response.statusCode == 200) ? response.body : null;
  }

  Future<Map?> commentCreate(int feed_id, String content, int type) async {
    Response response = await post(
      "/api/feed/$type/$feed_id/comment",
      {'content': content},
      headers: {'token': await userController.getToken()},
    );
    return (response.statusCode == 200) ? response.body : null;
  }
}
