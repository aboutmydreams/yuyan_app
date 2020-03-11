import 'dart:async';

import 'package:flutter/material.dart';
import 'package:yuyan_app/models/net/requests_api/user/user.dart';
import 'package:yuyan_app/models/widgets_small/toast.dart';

class AddTopicPage extends StatefulWidget {
  AddTopicPage({Key key, this.groupId, this.callback}) : super();
  final int groupId;
  final Function callback;
  _AddTopicPageState createState() =>
      _AddTopicPageState(groupId: groupId, callback: callback);
}

class _AddTopicPageState extends State<AddTopicPage> {
  _AddTopicPageState({Key key, this.groupId, this.callback});
  final int groupId;
  final Function callback;

  var addTitleController = new TextEditingController();
  var contentController = new TextEditingController();

  addTopic() async {
    if (addTitleController.text.length > 0 &&
        contentController.text.length > 0) {
      var res = await DioUser.addTopic(
        groupId: groupId,
        title: addTitleController.text,
        body: contentController.text,
      );
      if (res) {
        myToast(context, "发布成功，返回上级页面");
        callback();
        Timer(Duration(milliseconds: 300), () {
          Navigator.pop(context);
        });
      }
      return res;
    } else {
      myToast(context, "请填写完整信息哦");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("添加话题"),
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 25,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: TextField(
              controller: addTitleController,
              keyboardType: TextInputType.text,
              maxLines: 1,
              // 是否自动更正
              autocorrect: false,
              // 是否自动对焦
              autofocus: false,
              decoration: new InputDecoration(
                labelText: "标 题",
                labelStyle: TextStyle(textBaseline: TextBaseline.alphabetic),
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
                contentPadding: EdgeInsets.all(15.0),
                hintText: ' 起个一目了然的标题~',
                hintStyle: TextStyle(
                  color: Colors.black26,
                  fontSize: 18,
                ),
              ),
              // 输入样式
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.black54,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: TextField(
              controller: contentController,
              keyboardType: TextInputType.text,

              maxLines: 10,
              // 是否自动更正
              autocorrect: false,
              // 是否自动对焦
              autofocus: false,
              decoration: new InputDecoration(
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
                // alignLabelWithHint: false,
                // focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.all(15.0),
                labelText: "正 文",
                alignLabelWithHint: true,
                labelStyle: TextStyle(textBaseline: TextBaseline.alphabetic),
                hintText: ' I have a dream, but ...',
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.black26,
                ),
              ),
              // 输入样式
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
            padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
            child: Card(
              color: Theme.of(context).accentColor,
              elevation: 3.0,
              child: FlatButton(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    '发布话题',
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                ),
                onPressed: () {
                  addTopic();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
