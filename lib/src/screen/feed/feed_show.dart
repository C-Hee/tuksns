import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sns_flutter/src/controller/feed_controller.dart';
import 'package:sns_flutter/src/model/feed_model.dart';
import 'package:sns_flutter/src/screen/feed/feed_create.dart';
import 'package:sns_flutter/src/widget/my_profile.dart';

class FeedShow extends StatefulWidget {
  final FeedModel feed;
  const FeedShow(this.feed, {super.key});

  @override
  State<FeedShow> createState() => _FeedShowState();
}

class _FeedShowState extends State<FeedShow> {
  final feedController = Get.put(FeedController());

  @override
  void initState() {
    super.initState();
    _feedShow();
  }

  _feedShow() {
    feedController.feedShow(widget.feed.id!, widget.feed.type!);
  }

  _feedDelete() async {
    await feedController.feedDelete(widget.feed.id!, widget.feed.type!);
    Get.back();
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('게시글'),
      ),
      body: GetBuilder<FeedController>(builder: (b) {
        FeedModel? feed = b.feedOne;
        if (feed == null) {
          return const CircularProgressIndicator();
        }
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const MyProfile(),
                  const SizedBox(width: 20),
                  Expanded(
                      child: Text('${feed.title}',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold))),
                ],
              ),
              const Divider(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '작성자: ${feed.name}',
                    style: const TextStyle(fontSize: 15),
                  ),
                  const SizedBox(width: 30),
                  Text(
                    '작성일: ${feed.dateFromNow}',
                    style: const TextStyle(fontSize: 15),
                  ),
                ],
              ),
              const Divider(),
              Expanded(child: Text("${feed.content}")),
              const Divider(),
              Column(children: [
                //ListView()
              ]),
              const Divider(),
              Visibility(
                visible: (feed.isMe == true),
                child: Row(
                  children: [
                    const Expanded(child: SizedBox()),
                    ElevatedButton(
                        onPressed: () {
                          Get.off(() => FeedWrite(beforeFeed: feed));
                        },
                        child: const Text('수정')),
                    const SizedBox(width: 20),
                    ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("게시글 삭제"),
                                content: const Text('정말 삭제하시겠습니까'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Get.back(),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: _feedDelete,
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: const Text('삭제')),
                  ],
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
