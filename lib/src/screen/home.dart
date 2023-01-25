import 'package:get/get.dart';
import 'package:sns_flutter/src/controller/feed_controller.dart';

import '../widget/my_list_item.dart';
import 'package:flutter/material.dart';
import 'feed/feed_create.dart';
import 'user/register.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final feedController = Get.put(FeedController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    bool result = await feedController.feedIndex();
    if (!result) {
      Get.off(const Register());
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(const FeedWrite());
        },

        ///글쓰기 버튼을 누를 경우 동작
        ///FeedCreate위젯 실행
        // onPressed: () {
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(builder: (context) => const FeedWrite()),
        //   );
        child: Icon(Icons.create),
      ),
      appBar: AppBar(
        title: const Text('MySNS'),
      ),
      body: GetBuilder<FeedController>(builder: (c) {
        return ListView.separated(
          itemBuilder: (context, index) => MyListItem(c.feedList[index]),
          separatorBuilder: (context, index) => const Divider(),
          itemCount: c.feedList.length,
        );
      }),
    );
  }
}
