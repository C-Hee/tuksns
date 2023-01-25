import 'dart:io';

import 'package:get/get.dart';
import 'package:sns_flutter/src/model/feed_model.dart';
import 'package:sns_flutter/src/repository/feed_repository.dart';

class FeedController extends GetxController {
  //매번 인스턴스를 만드는 것이 아니라 이전에 만들어진 것을 불러옴
  final feedRepo = Get.put(FeedRepository());
  List feedList = [];

  Future<bool> feedIndex() async {
    List? body = await feedRepo.feedIndex();
    if (body == null) {
      return false;
    }
    List feed = body.map((e) => FeedModel.parse(e)).toList();
    feedList = feed;
    //데이터의 변경을 알림
    update();
    return true;
  }

  feedShow(int id) async {
    Map? body = await feedRepo.feedShow(id);
    if (body == null) {
      return null;
    }
    FeedModel feed = FeedModel.parse(body);
    //feedOne = feed;
    update();
    return feed;
  }

  feedCreate(String content, int? imageId) async {
    await feedRepo.feedCreate(content, imageId);
    await feedIndex();
  }

  feedDelete(int id) async {
    await feedRepo.feedDelete(id);
    await feedIndex();
  }

  feedEdit(int id, String content) async {
    await feedRepo.feedUpdate(id, content);
    await feedShow(id);
  }

  imageUpload(String path, String name) async {
    File file = File(path);
    Map? body = await feedRepo.fileUpload(file, name);
    return (body == null) ? null : body['id'];
  }
}








//반복문으로 feedModel.parse에 넣음