import 'dart:io';
import 'package:get/get.dart';
import 'package:sns_flutter/src/model/comment_model.dart';
import 'package:sns_flutter/src/repository/comment_repository.dart';

class CommentController extends GetxController {
  //매번 인스턴스를 만드는 것이 아니라 이전에 만들어진 것을 불러옴
  final commentRepo = Get.put(CommentRepository());
  CommentModel? commentOne;

  List commentList = [];

  Future<bool> commentIndex() async {
    List? body = await commentRepo.commentIndex();
    if (body == null) {
      return false;
    }
    List comment = body.map((e) => CommentModel.parse(e)).toList();
    commentList = comment;
    //데이터의 변경을 알림
    update();
    return true;
  }

  commentShow(int id) async {
    Map? body = await commentRepo.commentShow(id);
    if (body == null) {
      return null;
    }
    CommentModel comment = CommentModel.parse(body);
    commentOne = comment;
    update();
    return comment;
  }

  commentCreate(String content, int id, int type) async {
    await commentRepo.commentCreate(content, id, type);
    await commentIndex();
  }

  commentDelete(int id) async {
    await commentRepo.commentDelete(id);
    await commentIndex();
  }

  commentEdit(int id, String content) async {
    await commentRepo.commentUpdate(id, content);
    await commentShow(id);
  }
}



//반복문으로 feedModel.parse에 넣음