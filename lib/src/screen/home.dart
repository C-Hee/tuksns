import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sns_flutter/src/controller/feed_controller.dart';
import 'package:sns_flutter/src/screen/user/login.dart';

import '../widget/my_list_item.dart';
import 'package:flutter/material.dart';
import 'feed/feed_create.dart';

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
      Get.off(const Login());
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('전체?게시판'),
        centerTitle: true,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.logout_rounded),
          onPressed: () async {
            final prefs = await SharedPreferences.getInstance();
            prefs.clear();
            Get.offAll(() => const Login());
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(const FeedWrite());
        },
        child: const Icon(Icons.create),
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
