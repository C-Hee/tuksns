import 'dart:io';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:sns_flutter/src/model/comment_model.dart';
import 'package:sns_flutter/src/model/feed_model.dart';
import '../repository/comment_repository.dart';

class FeedController extends GetxController {
  final commentRepo = Get.put(CommentRepository());
  FeedModel? feedOne;
  List commentList = [];

  Future<bool> commentIndex(feed) async {
    feedOne = feed;
    List? body = await commentRepo.commentIndex(feedOne!.id!, feedOne!.type!);
    if (body == null) {
      return false;
    }
    List comment = body.map(((e) => CommentModel.parse(e))).toList();
    commentList = comment;
    update();
    return true;
  }

  commentCreate(int id, String content, int type) async {
    await commentRepo.commentCreate(id, content, type);
    //await commentIndex(feed);
  }
}
