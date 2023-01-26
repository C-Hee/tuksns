import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sns_flutter/src/controller/feed_controller.dart';
import 'package:sns_flutter/src/widget/image_box.dart';
import 'package:sns_flutter/src/shared/global.dart';

class FeedWrite extends StatefulWidget {
  const FeedWrite({super.key});
  State<FeedWrite> createState() => _FeedWriteState();
}

class _FeedWriteState extends State<FeedWrite> {
  var snackBar = const SnackBar(content: Text("글은 비워둘 수 없습니다"));
  final textController = TextEditingController();
  final _picker = ImagePicker();
  final feedController = Get.put(FeedController());
  int? tmpImg;

  Future<void> submit() async {
    String text = textController.text;

    if (text == '') {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      await feedController.feedCreate(textController.text, tmpImg);
    }
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('피드 작성'),
          actions: [
            IconButton(onPressed: submit, icon: Icon(Icons.save)),
          ],
        ),
        body: SafeArea(
            top: false,
            child: Column(
              children: [
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    expands: true,
                    minLines: null,
                    maxLines: null,
                    decoration:
                        InputDecoration(contentPadding: EdgeInsets.all(20)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(children: [
                    InkWell(
                      onTap: _upload,
                      child: ImageBox(
                        child: const Icon(Icons.image),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    previewImage()
                  ]),
                  // IconButton(
                  //     icon: const Icon(Icons.image),
                  //     onPressed: () async {
                  //       final file =
                  //           await _picker.pickImage(source: ImageSource.gallery);
                  //       int? result =
                  //           await feedController.imageUpload(file!.path, file.name);
                  //       if (result != null) {
                  //         setState(() {
                  //           tmpImg = result;
                  //         });
                  //       }
                  //     })
                )
              ],
            )));
  }

  Widget previewImage() {
    if (tmpImg == null) {
      return const SizedBox();
    }
    return ImageBox(
      child: Image.network("${Global.API_ROOT}/file/${tmpImg}"),
    );
  }

  Future<void> _upload() async {
    final file = await _picker.pickImage(source: ImageSource.gallery);
    int? result = await feedController.imageUpload(file!.path, file.name);

    setState() {
      tmpImg = result;
    }
  }
}
