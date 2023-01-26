import 'dart:io';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:sns_flutter/src/model/feed_model.dart';
import 'package:sns_flutter/src/repository/feed_repository.dart';

class FeedController extends GetxController {
  final feedRepo = Get.put(FeedRepository());
  List feedList = [];
  FeedModel? feedOne;

  Future<bool> feedIndex() async {
    List? body = await feedRepo.feedIndex();
    if (body == null) {
      return false;
    }
    List feed = body.map(((e) => FeedModel.parse(e))).toList();
    feedList = feed;
    update();
    return true;
  }

  imageUpload(String path, String name) async {
    File file = File(path);
    Map? body = await feedRepo.fileUpload(file, name);
    return (body == null) ? null : body['id'];
  }

  feedShow(int id) async {
    Map? body = await feedRepo.feedShow(id);
    if (body == null) {
      return null;
    }
    FeedModel feed = FeedModel.parse(body);
    feedOne = feed;
    update();
    return feed;
  }

  feedCreate(String title, String content, int type, int? imageId) async {
    await feedRepo.feedCreate(title, content, type, imageId);
    await feedIndex();
  }

  feedDelete(int id) async {
    await feedRepo.feedDelete(id);
    await feedIndex();
  }

  feedEdit(int id, String title, String content, int type) async {
    await feedRepo.feedUpdate(id, title, content, type);
    await feedShow(id);
  }
}
