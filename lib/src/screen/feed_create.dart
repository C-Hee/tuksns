import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FeedWrite extends StatefulWidget{
 const FeedWrite({super.key});
  State<FeedWrite> createState() => _FeedWriteState();

}

class _FeedWriteState extends State<FeedWrite>{

  var snackBar = const SnackBar(content:Text("글은 비워둘 수 없습니다"));
  final textController=TextEditingController();
  final _picker =   ImagePicker ();
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title:Text('피드 작성'),
        actions:[
          IconButton(
            onPressed: (){
              String text = textController.text;
              if (text ==''){
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
           icon: Icon(Icons.save)),
        ],
        ),
        body: Column(
          children: [
            Expanded(
           child:TextField(
          keyboardType: TextInputType.multiline,
          expands: true,
          minLines:null,
          maxLines:null,
          decoration: InputDecoration(contentPadding:EdgeInsets.all(20)),
        ),
        
        ),
        IconButton(onPressed: ()async{
          final file = await _picker.pickImage(source: ImageSource.gallery);
          print(file);
        }, icon: Icon(Icons.image))
        ],
        )
    );
  }
}