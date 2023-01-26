import 'package:get/get.dart';
import 'package:sns_flutter/src/controller/feed_controller.dart';
import 'package:sns_flutter/src/screen/user/login.dart';

import '../widget/my_list_item.dart';
import 'package:flutter/material.dart';
import 'feed/feed_create.dart';
import 'user/login.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final feedController = Get.put(FeedController());
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(const FeedWrite());
        },
        child: Icon(Icons.create),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color.fromARGB(255, 191, 145, 255),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(.60),
        selectedFontSize: 14,
        unselectedFontSize: 14,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: 'All items',
            icon: Icon(Icons.favorite),
          ),
          BottomNavigationBarItem(
            label: 'BOARD1',
            icon: Icon(Icons.music_note),
          ),
          BottomNavigationBarItem(
            label: 'BOARD2',
            icon: Icon(Icons.location_on),
          ),
          BottomNavigationBarItem(
            label: 'BOARD3',
            icon: Icon(Icons.library_books),
          ),
          BottomNavigationBarItem(
            label: 'BOARD4',
            icon: Icon(Icons.add_photo_alternate_outlined),
          ),
        ],
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
