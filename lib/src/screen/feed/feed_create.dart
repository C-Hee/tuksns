import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sns_flutter/src/controller/feed_controller.dart';
import 'package:sns_flutter/src/model/feed_model.dart';
import 'package:sns_flutter/src/widget/image_box.dart';
import 'package:sns_flutter/src/shared/global.dart';

final feedController = Get.put(FeedController());
const snackBar = SnackBar(content: Text("글을 작성 해 주세요"));

class FeedWrite extends StatefulWidget {
  final FeedModel? beforeFeed;
  const FeedWrite({super.key, this.beforeFeed});

  @override
  State<FeedWrite> createState() => _FeedWriteState();
}

class _FeedWriteState extends State<FeedWrite> {
  final _titleController = TextEditingController();
  final _textController = TextEditingController();
  final picker = ImagePicker();
  int? tmpImg;

  Future<void> submit() async {
    String title = _titleController.text;
    String text = _textController.text;

    if (text == '') {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      if (widget.beforeFeed == null) {
        await feedController.feedCreate(
            _titleController.text, _textController.text, 1, tmpImg);
      } else {
        await feedController.feedEdit(widget.beforeFeed!.id!,
            _titleController.text, _textController.text, 1);
      }
      Get.back();
    }
  }

  @override
  void initState() {
    super.initState();
    _fillData();
  }

  _fillData() {
    if (widget.beforeFeed != null) {
      _textController.text = widget.beforeFeed!.content!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (widget.beforeFeed == null)
            ? const Text('피드 작성')
            : const Text('피드 수정'),
        actions: [
          IconButton(onPressed: submit, icon: const Icon(Icons.save)),
        ],
      ),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            TextField(
                controller: _titleController,
                minLines: null,
                maxLines: 1,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(20),
                  border: InputBorder.none,
                )),
            const Divider(),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: TextField(
                controller: _textController,
                keyboardType: TextInputType.multiline,
                expands: true,
                minLines: null,
                maxLines: null,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(20),
                  border: InputBorder.none,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  InkWell(
                    onTap: _upload,
                    child: ImageBox(child: const Icon(Icons.image)),
                  ),
                  const SizedBox(width: 20),
                  previewImage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget previewImage() {
    if (tmpImg == null) {
      return const SizedBox();
    }
    return ImageBox(
      child: Image.network(
        "${Global.API_ROOT}/file/$tmpImg",
        fit: BoxFit.cover,
      ),
    );
  }

  Future<void> _upload() async {
    final file = await picker.pickImage(source: ImageSource.gallery);
    int? result = await feedController.imageUpload(file!.path, file.name);
    if (result != null) {
      setState(() {
        tmpImg = result;
      });
    }
  }
}
