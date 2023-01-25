import 'dart:io';

import 'package:get/get.dart';
import 'package:sns_flutter/src/controller/user_controller.dart';

import '../shared/global.dart';

class FeedRepository extends GetConnect {
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

  Future<List?> feedIndex() async {
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

  Future<Map?> fileUpload(File image, String filename) async {
    Response response = await post(
      '/file/upload',
      FormData({
        'file': MultipartFile(image, filename: filename),
      }),
    );
    return (response.body == null) ? null : response.body;
  }

  Future<Map?> feedCreate(String content, int? imageId) async {
    Response response = await post(
      "/api/feed",
      {'content': content, "image_id": imageId},
      headers: {'token': await userController.getToken()},
    );
    return (response.statusCode == 200) ? response.body : null;
  }

  Future<Map?> feedUpdate(int id, String content) async {
    Response response = await put(
      "/api/feed/$id",
      {'content': content},
      headers: {'token': await userController.getToken()},
    );
    return (response.statusCode == 200) ? response.body : null;
  }

  Future<Map?> feedDelete(int id) async {
    Response response = await delete(
      "/api/feed/$id",
      headers: {'token': await userController.getToken()},
    );
    return (response.statusCode == 200) ? response.body : null;
  }

  Future<Map?> feedShow(int id) async {
    Response response = await get(
      "/api/feed/$id",
      headers: {'token': await userController.getToken()},
    );
    return (response.statusCode == 200) ? response.body : null;
  }
}
