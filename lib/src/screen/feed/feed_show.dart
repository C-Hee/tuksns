import 'package:flutter/material.dart';
import '../../widget/my_profile.dart';

class FeedShow extends StatelessWidget {
  const FeedShow({super.key});

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
          title:Text('피드'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              MyProfile(),
              SizedBox(width: 20),
              Text(
                '홍길동',
                style: TextStyle(fontSize:18),
                )
            ],),
            SizedBox(height: 20,),
            Text('나랏말싸미 듕귁에 달아 문자와로 서로 사맛디 아니할',),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: SizedBox(),),
                Text('2023-01-01')
              ],
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                Expanded(child: SizedBox()),
                ElevatedButton( 
                  onPressed: null,
                  child: Text('수정')),
                SizedBox(height: 20,),
                ElevatedButton( onPressed:(){
                showDialog(context: context, builder:  (context) {
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
                }
                , child: Text('삭제'))
              ],
            )
          ],
        )
        ,)
    );
  }
}