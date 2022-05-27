
import 'package:dd_js_util/widget/picture_selection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostWritePage extends StatefulWidget {
  const PostWritePage({Key? key}) : super(key: key);

  @override
  State<PostWritePage> createState() => _PostWritePageState();
}

class _PostWritePageState extends State<PostWritePage> {

  final TextEditingController _textEditingController = TextEditingController();
  final PictureSelectionController _pictureSelectionController = PictureSelectionController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("发布动态"),),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //编写内容区域
            Container(
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
              ),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: "说点什么吧~~"
                ),
                  controller: _textEditingController, minLines: 3, maxLines: 6),
            ),

            //九宫格选择图片
            PictureSelection(controller: _pictureSelectionController,),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {  },
        child: Container(
            alignment: Alignment.center,
            width: Get.width * 0.9,
            child: const Icon(Icons.check)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
