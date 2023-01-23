import '../widget/my_list_item.dart';
import 'package:flutter/material.dart';
import './feed_create.dart';
class Home extends StatelessWidget {
  const Home({super.key});

  Widget build(BuildContext context){
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        ///글쓰기 버튼을 누를 경우 동작
        ///FeedCreate위젯 실행
        onPressed: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context)=>const FeedWrite()),
        );
      },
      child:Icon(Icons.create),
      ),
      
      body: ListView(
        children: const[
          MyListItem(),
          MyListItem(),
          MyListItem(),
          MyListItem(),
          MyListItem(),
          MyListItem(),
        ],
      )
    );
  }
}
