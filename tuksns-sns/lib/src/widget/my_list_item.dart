import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sns_flutter/src/model/feed_model.dart';
import 'package:sns_flutter/src/widget/my_profile.dart';
import '../screen/feed/feed_show.dart';

class MyListItem extends StatelessWidget {
  final FeedModel feed;
  const MyListItem(this.feed, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          //Get.to(const FeedShow(feed));
          Get.to(FeedShow(feed));
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            MyProfile(),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${feed.name}",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("$feed.createdAt",
                              style: TextStyle(color: Colors.grey))
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text('${feed.content}'),
                    ],
                  ),
                ],
              ),
            )
          ]),
        ));
  }
}
