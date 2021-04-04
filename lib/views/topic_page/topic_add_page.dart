import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuyan_app/config/service/api_repository.dart';
import 'package:yuyan_app/util/util.dart';
import 'package:yuyan_app/views/widget/editor/quill_editor_widget.dart';

class TopicAddPage extends StatefulWidget {
  final int groupId;

  const TopicAddPage({
    Key key,
    this.groupId,
  }) : super(key: key);

  @override
  _TopicAddPageState createState() => _TopicAddPageState();
}

class _TopicAddPageState extends State<TopicAddPage> {
  QuillEditorController _editorController = QuillEditorController();
  TextEditingController _titleController = TextEditingController();

  _addTopicCallback() async {
    var onErr = (err) => Util.toast('失败： $err');
    if (GetUtils.isNullOrBlank(_titleController.text) ||
        GetUtils.isNullOrBlank(_editorController.plainTextEditingValue.text)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Get.theme.primaryColor,
        content: Text('内容不能为空'),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ),
      ));
      return;
    }
    Util.futureWrap(
      _editorController.toLakeHtml(),
      onData: (lake) {
        Util.futureWrap(
          ApiRepository.addTopic(
            title: _titleController.text,
            body: lake,
            groupId: widget.groupId,
          ),
          onData: (detail) {
            Util.toast('提交成功！');
            Get.back();
          },
          onError: onErr,
        );
      },
      onError: onErr,
    );
  }

  @override
  Widget build(BuildContext context) {
    var titleInput = TextField(
      controller: _titleController,
      keyboardType: TextInputType.text,
      maxLines: null,
      autofocus: true,
      decoration: InputDecoration(
        labelText: "标 题",
        labelStyle: TextStyle(
          textBaseline: TextBaseline.alphabetic,
        ),
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(6),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 12,
        ),
        hintText: '起个一目了然的标题~',
        hintStyle: TextStyle(
          color: Colors.black26,
          fontSize: 18,
        ),
      ),
      style: TextStyle(
        fontSize: 20.0,
        color: Colors.black54,
        fontWeight: FontWeight.w700,
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("添加话题"),
        actions: [
          TextButton.icon(
            onPressed: _addTopicCallback,
            icon: Icon(
              Icons.send_sharp,
              color: Colors.white,
            ),
            label: Text(
              '提交',
              style: Get.theme.primaryTextTheme.bodyText1,
            ),
          ),
        ],
      ),
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 12),
            child: titleInput,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              '描 述',
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: QuillEditorWidget(
              padding: const EdgeInsets.all(12),
              controller: _editorController,
              toolbarType: QuillEditorToolbarType.bottom,
            ),
          ),
        ],
      ),
    );
  }
}
