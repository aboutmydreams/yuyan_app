import 'package:flutter/material.dart';

class AddTopicPage extends StatefulWidget {
  AddTopicPage({Key key, this.groupId, this.iid, this.id}) : super();
  final int groupId;
  final int iid;
  final int id;
  _AddTopicPageState createState() => _AddTopicPageState();
}

class _AddTopicPageState extends State<AddTopicPage> {
  _AddTopicPageState({Key key, this.groupId, this.iid, this.id});
  final int groupId;
  final int iid;
  final int id;

  var addTitleController = new TextEditingController();
  var contentController = new TextEditingController();

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
                hintText: ' Ready to drive a car',
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
            //类似cardview
            child: Card(
              color: Theme.of(context).accentColor,
              // 阴影
              elevation: 3.0,
              //按钮
              child: FlatButton(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    '发布话题',
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                ),
                // disabledColor: Colors.grey,
                // disabledTextColor: Colors.black,
                onPressed: () {
                  // if (addTitleController.text.isEmpty) {
                  //   myToast("标题不能为空哦");
                  // } else {
                  //   var newTitle = addTitleController.text;
                  //   var newContent = contentController.text;
                  //   String labelsId = "4";
                  //   pubTopic(newTitle, newContent, labelsId).then(
                  //     (res) {
                  //       if (res == 200) {
                  //         Navigator.push(
                  //             context,
                  //             MaterialPageRoute(
                  //                 builder: (context) => new MyHomePage()));
                  //       } else {
                  //         myToast("$res");
                  //         Navigator.popAndPushNamed(context, "/");
                  //       }
                  //     },
                  //   );
                  // }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
