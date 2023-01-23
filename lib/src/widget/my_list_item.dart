import 'package:flutter/material.dart';
import '../screen/feed/feed_show.dart';

class MyListItem extends StatelessWidget{
  const MyListItem ({super.key});

@override
Widget build(BuildContext context){
  return InkWell(onTap: (){
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context)=> FeedShow()),
      );
  },
  child:Container(
    
    padding: const EdgeInsets.all(10),
    
    width: 100,
    height:20,
    child:Row(
      children: [
      Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color:Colors.blue,
          shape: BoxShape.circle,
        ),
        ),
        const SizedBox(width:10),
        Expanded(
          child: Column(
          children: [
            Row(
              children: const [
                Text('홍길동',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                ),
                SizedBox(width:10),
                Text('2023-01-19',
                style:TextStyle(
                  fontSize:12,
                  color:Colors.grey,
                )),
              ],
            ),
            SizedBox(height:8),
            Text('나랏말싸미 듕귁에달아'),
          ]
        ))
        

        
    ],
    )


  ),
  
  
  
  
  );
  
}

}