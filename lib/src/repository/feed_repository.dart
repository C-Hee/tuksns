import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:sns_flutter/src/controller/user_controller.dart';
import '';

import '../shared/global.dart';

class FeedRepository extends GetConnect {
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

  Future<List?> feedIndex() async {
    Response response = await get(
      "/api/feed",
      headers: {'token': await userController.getToken()},
    );
    return (response.statusCode == 200) ? response.body : null;
  }

  Future<Map?> fileUpload(File image, String filename) async {
    Response response = await post(
      '/file/upload',
      FormData({
        'file': MultipartFile(image, filename: filename),
      }),
    );
    return (response.statusCode == 200) ? response.body : null;
  }

  Future<Map?> feedCreate(
      String title, String content, int type, int? imageId) async {
    Response response = await post(
      "/api/feed/$type",
      {'title': title, 'content': content, "image_id": imageId},
      headers: {'token': await userController.getToken()},
    );
    return (response.statusCode == 200) ? response.body : null;
  }

  Future<Map?> feedUpdate(
      int id, String title, String content, int type) async {
    Response response = await put(
      "/api/feed/$type/$id",
      {'title': title, 'content': content},
      headers: {'token': await userController.getToken()},
    );
    return (response.statusCode == 200) ? response.body : null;
  }

  Future<Map?> feedDelete(int id, int type) async {
    Response response = await delete(
      "/api/feed/$type/$id",
      headers: {'token': await userController.getToken()},
    );
    return (response.statusCode == 200) ? response.body : null;
  }

  Future<Map?> feedShow(int id, int type) async {
    Response response = await get(
      "/api/feed/$type/$id",
      headers: {'token': await userController.getToken()},
    );
    log('${response.body}');
    return (response.statusCode == 200) ? response.body : null;
  }
}
