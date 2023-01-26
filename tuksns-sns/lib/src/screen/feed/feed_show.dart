import 'package:flutter/material.dart';
import 'package:sns_flutter/src/controller/feed_controller.dart';
import 'package:sns_flutter/src/model/feed_model.dart';
import '../../widget/my_profile.dart';
import 'package:get/get.dart';

final feedController = Get.put(FeedController());

class FeedShow extends StatefulWidget {
  final FeedModel feed;
  //const FeedShow(this.feed, {super.key});
  FeedShow(this.feed, {super.key});

  @override
  State<FeedShow> createState() => _FeedShowState();
}

class _FeedShowState extends State<FeedShow> {
  @override
  void initState() {
    super.initState();
    _feedShow();
  }

  _feedShow() {
    feedController.feedShow(widget.feed.id!);
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('피드'),
        ),
        body: GetBuilder<FeedController>(builder: (b) {
          FeedModel? feed = b.feedOne; //
          if (feed == null) {
            return CircularProgressIndicator();
          }
          return Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    MyProfile(),
                    SizedBox(width: 20),
                    Text(
                      '${widget.feed.name}',
                      style: TextStyle(fontSize: 18),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  '${widget.feed.content}',
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(),
                    ),
                    Text('${widget.feed.createdAt}')
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Visibility(
                  //visible: (feed.isMe == true),
                  child: Row(
                    children: [
                      Expanded(child: SizedBox()),
                      ElevatedButton(onPressed: null, child: Text('수정')),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("피드 삭제"),
                                  content: Text('정말 삭제하시겠습니까'),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'Cancel'),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'OK'),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Text('삭제'))
                    ],
                  ),
                ),
                Row(
                  children: [
                    TextField(
                      keyboardType: TextInputType.multiline,
                      expands: true,
                      minLines: null,
                      maxLines: 4,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(onPressed: null, child: Text('댓글 작성')),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text("id"),
                    SizedBox(
                      width: 10,
                    ),
                    Text("content"),
                  ],
                )
              ],
            ),
          );
        }));
  }
}
